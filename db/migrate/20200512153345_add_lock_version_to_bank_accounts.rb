class AddLockVersionToBankAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :lock_version, :integer
  end
end
