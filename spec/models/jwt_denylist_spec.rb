require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:jti) }
    it { should validate_presence_of(:expired_at) }
  end
end
