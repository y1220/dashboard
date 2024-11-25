class Api::PersonalityTypesController < ApplicationController
  def index
    @types = PersonalityType.includes(:patients)
                           .map do |type|
      {
        type: type.name,
        count: type.patients.count,
        avg_response_time: type.patients.joins(:communications)
                              .average('communications.response_time'),
        preferred_channel: type.patients.joins(:communications)
                              .group('communications.channel')
                              .order('count_id DESC')
                              .count('id')
                              .first&.first
      }
    end

    render json: @types
  end
end
