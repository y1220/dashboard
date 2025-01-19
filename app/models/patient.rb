class Patient < ApplicationRecord
  belongs_to :personality_type
  has_many :communications

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :birthday, presence: true
end
