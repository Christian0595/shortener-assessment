class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
  validates_presence_of :jti, :expired_at

  self.table_name = 'jwt_denylist'
end
