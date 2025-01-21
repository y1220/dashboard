class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :patient

  validate :at_least_one_value_present

  private

  def at_least_one_value_present
    if text_value.blank? && numerical_value.blank? && option_id.blank?
      errors.add(:base, "At least one of text_value, numerical_value, or option_id must be present")
    end
  end
end
