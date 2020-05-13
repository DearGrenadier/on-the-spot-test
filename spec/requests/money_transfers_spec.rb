describe 'money transfer route', type: :request do
  describe 'create' do
    context 'single thread' do
      let(:sender) { create(:bank_account, balance: 10) }
      let(:receiver) { create(:bank_account, balance: 20) }

      before do
        post '/money_transfers', params: params
      end

      context 'with valid data' do
        let(:params) { { sender_id: sender.id, receiver_id: receiver.id, amount: 0.5 } }

        it 'returns :ok status code' do
          expect(response).to have_http_status(:ok)
          expect(receiver.reload.balance).to eq(20.5)
          expect(sender.reload.balance).to eq(9.5)
        end
      end

      context 'with empty receiver' do
        let(:params) { { sender_id: sender.id, receiver_id: nil, amount: 5 } }

        it 'returns error with :unprocessable_entity status code' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq(
            'error' => 'Bank account is not found'
          )
        end
      end

      context 'with negative transfer amount' do
        let(:params) { { sender_id: sender.id, receiver_id: receiver.id, amount: - 5 } }

        it 'returns error with :unprocessable_entity status code' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq(
            'error' => 'Transfer amount can not be negative'
          )
        end
      end

      context 'with insufficient balance' do
        let(:params) { { sender_id: sender.id, receiver_id: receiver.id, amount: 15 } }

        it 'returns error with :unprocessable_entity status code' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq(
            'error' => "Validation failed: Balance can't be or become negative"
          )
        end
      end
    end

    context 'concurrent' do
      it 'transfer money twice despite having race condition', skip_db_cleaner: true do
        sender = create(:bank_account, balance: 10)
        receiver = create(:bank_account, balance: 20)
        params = { sender_id: sender.id, receiver_id: receiver.id, amount: 1 }

        processes = 2.times.map do
          ForkBreak::Process.new do |breakpoints|
            original_method = BankAccount.method(:find_by_id)

            allow(BankAccount).to receive(:find_by_id) do |*args|
              bank_account = original_method.call(*args)
              breakpoints << :find_by_id
              bank_account
            end

            post '/money_transfers', params: params
          end
        end

        processes.each { |process| process.run_until(:find_by_id).wait }
        processes.each { |process| process.finish.wait }

        expect(receiver.reload.balance).to eq(22)
        expect(sender.reload.balance).to eq(8)
      end
    end
  end
end
