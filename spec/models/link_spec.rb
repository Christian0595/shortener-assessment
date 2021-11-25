require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
  end

  # Since the code is generated in the model, it is necessary to generate a uniqueness validation algorithm manually.

  describe 'uniqueness validation' do
    context 'when code is repeated' do
      it 'show error message' do
        @link = create(:link)
        @second_link = create(:link)
        allow(@second_link).to receive(:random_code).and_return(@link.code)
        expect(@second_link).to be_invalid
        expect(@second_link.errors.messages[:code].first).to eq('has already been taken')
      end
    end
  end

  describe 'relations' do
    it { should belong_to(:user)}
  end
end
