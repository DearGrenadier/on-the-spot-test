class MoneyTransfersController < ApplicationController
  def create
    MoneyTransferService.new(transfer_params).call!
    head :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def transfer_params
    params.permit(:sender_id, :receiver_id, :amount)
  end
end