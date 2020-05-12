class BankAccount < ApplicationRecord
  include ActiveModel::Serialization

  validates :balance, numericality: { greater_than_or_equal_to: 0.0, message: "can't be or become negative" }
  validates :name, presence: true

  def withdrawal!(amount)
    update!(balance: balance - amount)
  end

  def deposit(amount)
    update(balance: balance + amount)
  end

  def attributes
    {
      'id' => nil,
      'name' => nil,
      'balance' => nil
    }
  end
end
