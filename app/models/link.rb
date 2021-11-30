class Link < ApplicationRecord
  belongs_to :user
  has_many :visits
  validates_presence_of :url
  validates_uniqueness_of :code

  before_validation :generate_short_url, on: :create
  
  def generate_short_url
    self.code = random_code
  end

  def random_code
    characters = [*'a'..'z', *'A'..'Z', *0..9].shuffle
    loop do
      code = characters.permutation(8).next.join
      break code unless Link.exists?(code: code)
    end  
  end
end
