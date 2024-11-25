class DashboardController < ApplicationController
  def index
    @personality_types = PersonalityType.all
    @total_communications = Communication.count
    @avg_response_time = Communication.average(:response_time)
    @satisfaction_rate = calculate_satisfaction_rate
    @engagement_rate = calculate_engagement_rate
  end

  private

  def calculate_satisfaction_rate
    total = Communication.count
    positive = Communication.where(sentiment: :positive).count
    ((positive.to_f / total) * 100).round(2)
  end

  def calculate_engagement_rate
    # Custom logic for engagement calculation
    78 # Placeholder
  end
end
