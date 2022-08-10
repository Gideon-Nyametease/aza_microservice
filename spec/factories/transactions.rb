FactoryBot.define do
    factory :transaction, class: 'Transaction' do
      transaction_id { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
      customer_id { Faker::Alphanumeric.alphanumeric(number: 10) }
      input_currency { Faker::Currency.code }
      input_amount { Faker::Number.decimal(r_digits: 3) }
      output_currency { Faker::Currency.code }
      output_amount { Faker::Number.decimal(r_digits: 3) }
    end
  end