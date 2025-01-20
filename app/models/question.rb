class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :question_options, dependent: :destroy

  validates :field_label, presence: true
  validates :field_type, presence: true
  validates :field_key, presence: true
end
