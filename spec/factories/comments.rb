# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :comment do
    text  { Faker::String.random }
  end
end
