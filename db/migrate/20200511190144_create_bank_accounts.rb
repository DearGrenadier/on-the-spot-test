class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.float :balance, default: 0.0, null: false
    end
  end
end
