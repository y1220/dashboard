class PersonalityType < ApplicationRecord
  has_many :patients
  has_many :retention_rates

  validates :name, presence: true
end
