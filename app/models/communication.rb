class Communication < ApplicationRecord
  belongs_to :patient

  validates :content, presence: true
  validates :channel, presence: true

  enum channel: { email: 0, sms: 1, phone: 2 }
  enum sentiment: { positive: 0, neutral: 1, negative: 2 }
end
