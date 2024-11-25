class Api::RetentionRatesController < ApplicationController
  def index
    @rates = RetentionRate.includes(:personality_type)
                         .group_by { |rate| rate.personality_type.name }
                         .transform_values do |rates|
      rates.map { |rate| [rate.month, rate.rate] }.to_h
    end

    render json: @rates
  end
end
