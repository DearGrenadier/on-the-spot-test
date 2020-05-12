describe 'bank accounts route', type: :request do
  describe 'index' do
    let!(:bank_account) { create :bank_account }

    before do
      get '/bank_accounts'
    end

    it 'returns data with :ok status code' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to match_array(
        [{
          'id' => bank_account.id,
          'name' => bank_account.name,
          'balance' => bank_account.balance
        }]
      )
    end
  end

  describe 'create' do
    before do
      post '/bank_accounts', params: params
    end

    context 'with valid data' do
      let(:params) { { name: 'Bank Account #1', balance: '10.20' } }

      it 'returns record with :created status code' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include(
          'name' => 'Bank Account #1',
          'balance' => 10.20
        )
      end
    end

    context 'with invalid data' do
      let(:params) { { name: '', balance: '-10.20' } }

      it 'returns errors array with :unprocessable_entity status code' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq(
          'errors' => ["Balance can't be or become negative", "Name can't be blank"]
        )
      end
    end
  end
end
