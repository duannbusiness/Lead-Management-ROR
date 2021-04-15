# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phase, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
  subject { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
  describe '#Phase' do
    describe 'Associations' do
      it { should belong_to(:lead) }
      it { should have_many(:phase_users).dependent(:destroy) }
      it { should have_many(:requests).dependent(:destroy) }
      it { should have_many(:comments).dependent(:destroy) }
    end

    describe 'Validations' do
      it { should validate_presence_of(:lead_id) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:phaseType) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:start_date) }
      it { should validate_presence_of(:due_date) }
    end

    describe 'Enum' do
      it { should define_enum_for(:status).with(%i[pending completed]) }
    end
  end
end
