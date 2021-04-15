# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#User' do
    let(:user) { FactoryGirl.create(:user) }
    describe 'Associations' do
      it { should have_one_attached(:image) }
      it { should have_many(:leads).dependent(:destroy) }
      it { should have_many(:phase_users).dependent(:destroy) }
      it { should have_many(:requests).dependent(:destroy) }
      it { should have_many(:comments).dependent(:destroy) }
      it { should have_many(:projects).dependent(:destroy) }
      it { should have_many(:phases).dependent(:destroy) }
    end

    describe 'Validations' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:user_name) }
    end
    describe 'Role' do
      context 'is admin' do
        let(:user) { FactoryGirl.create(:admin) }
        it { expect(user.admin?).to eql(true) }
        it { expect(user.developer?).to eql(false) }
        it { expect(user.manager?).to eql(false) }
        it { expect(user.engineer?).to eql(false) }
      end
      context 'is business developer' do
        let(:user) { FactoryGirl.create(:business_developer) }
        it { expect(user.admin?).to eql(false) }
        it { expect(user.developer?).to eql(true) }
        it { expect(user.manager?).to eql(false) }
        it { expect(user.engineer?).to eql(false) }
      end
      context 'is manager' do
        let(:user) { FactoryGirl.create(:manager) }
        it { expect(user.admin?).to eql(false) }
        it { expect(user.developer?).to eql(false) }
        it { expect(user.manager?).to eql(true) }
        it { expect(user.engineer?).to eql(false) }
      end
      context 'is engineer' do
        let(:user) { FactoryGirl.create(:engineer) }
        it { expect(user.admin?).to eql(false) }
        it { expect(user.developer?).to eql(false) }
        it { expect(user.manager?).to eql(false) }
        it { expect(user.engineer?).to eql(true) }
      end
    end
  end
end
