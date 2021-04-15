# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  describe 'Associations' do
    it { should have_db_column(:commentable_id).of_type(:integer) }
    it { should have_db_column(:commentable_type).of_type(:string) }
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:text) }
  end
end
