class AddNameToBankAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :name, :string, null: false
  end
end
