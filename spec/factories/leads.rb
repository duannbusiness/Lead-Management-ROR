# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :lead do
    name  { Faker::Name.name }
    client_name { Faker::Name.name }
    client_address { Faker::Address.street_address }
    client_email { Faker::Name.name }
    client_contact { Faker::PhoneNumber.phone_number }
    leadType 'not_sale'
    user
  end
end
