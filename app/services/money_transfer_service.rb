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
  def initialize(params)
    @sender = BankAccount.find_by_id(params[:sender_id])
    @receiver = BankAccount.find_by_id(params[:receiver_id])
    @amount = params[:amount].to_f
  end

  def call!
    raise AccountNotFound if [@sender, @receiver].any?(nil)
    raise NegativeAmount if @amount.negative?

    ActiveRecord::Base.transaction do
      @sender.withdrawal!(@amount)
      @receiver.deposit(@amount)
    end
  end
end
