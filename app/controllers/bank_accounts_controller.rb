class BankAccountsController < ApplicationController
  def index
    render json: BankAccount.all, status: :ok
  end

  def create
    bank_account = BankAccount.create(bank_account_params)

    if bank_account.persisted?
      render json: bank_account, status: :created
    else
      render json: { errors: bank_account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def bank_account_params
    params.permit(:balance, :name)
  end
end
