require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity  }
  end

  describe 'relations' do
    it { should have_many(:links)}
  end
end
