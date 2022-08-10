FactoryBot.define do
    factory :customer do
    customer_id { Faker::Alphanumeric.alphanumeric(number: 10) }
      first_name { Faker::Name.name }
      last_name { Faker::Name.name }
      dob { Faker::Date.between(from: '1900-01-01', to: '2009-01-01') }
      phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
      active_status {true}
    end
  end