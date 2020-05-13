class AccountNotFound < StandardError
  def message
    'Bank account is not found'
  end
end

class NegativeAmount < StandardError
  def message
    'Transfer amount can not be negative'
  end
end

class MoneyTransferService
  MAX_RETRIES = 5

  def initialize(params)
    @sender = BankAccount.find_by_id(params[:sender_id])
    @receiver = BankAccount.find_by_id(params[:receiver_id])
    @amount = params[:amount].to_f
  end

  def call!
    raise AccountNotFound if [@sender, @receiver].any?(nil)
    raise NegativeAmount if @amount.negative?

    begin
      retries ||= 0
      transfer_money
    rescue ActiveRecord::StaleObjectError
      @sender.reload
      @receiver.reload
      retry if (retries += 1) <= MAX_RETRIES
    end
  end

  private

  def transfer_money
    ActiveRecord::Base.transaction do
      @sender.withdrawal!(@amount)
      @receiver.deposit(@amount)
    end
  end
end
