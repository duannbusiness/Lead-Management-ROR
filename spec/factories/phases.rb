# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :phase do
    name  { Faker::Name.name }
    phaseType 'interview'
    description 'dawdaw dawdaw dawdwad dwadawd '
    start_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    due_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }
    lead
    user
  end
end
