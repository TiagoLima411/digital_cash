FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday }
    gender { 'male' }
    mother_name { Faker::Name.feminine_name }
    cpf { Faker::CPF.pretty }
    rg { Faker::Number.number(digits = 10) }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    zipcode { Faker::Address.zip_code }
    complement { '' }
    district { Faker::Address.street_address }
    address_number { Faker::Number.number(digits = 3) }
    address_reference { Faker::Address.street_address }

    user
  end
end
