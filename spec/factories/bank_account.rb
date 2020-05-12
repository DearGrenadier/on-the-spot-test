FactoryBot.define do
  factory :bank_account do
    sequence(:name) { |n| "Bank Account ##{n}" }
    balance { 100.00 }
  end
end
