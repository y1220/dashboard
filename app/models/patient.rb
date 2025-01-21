require 'csv'
class Patient < ApplicationRecord
  belongs_to :personality_type
  has_many :communications

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :birthday, presence: true

  def self.to_csv
    attributes = %w{id name email gender birthday}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |patient|
        csv << attributes.map{ |attr| patient.send(attr) }
      end
    end
  end
end
