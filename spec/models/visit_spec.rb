require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:ip_address) }
    it { should validate_presence_of(:web_browser) }
    it { should validate_presence_of(:date) }
  end

  describe 'relations' do
    it { should belong_to(:link)}
  end
end
