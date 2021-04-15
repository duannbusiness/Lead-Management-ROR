# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    user_name  { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    factory :admin do
      after(:create) { |user| user.add_role :admin }
    end
    factory :business_developer do
      after(:create) { |user| user.add_role :business_developer }
    end
    factory :manager do
      after(:create) { |user| user.add_role :manager }
    end
    factory :engineer do
      after(:create) { |user| user.add_role :engineer }
    end
  end
end
