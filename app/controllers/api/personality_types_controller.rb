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

  def persona_statistics
    # @types = PersonalityType.includes(:patients)
    #                        .map do |type|
    #   {
    #     type: type.name,
    #     count: type.patients.count,
    #     avg_response_time: type.patients.joins(:communications)
    #                           .average('communications.response_time'),
    #     preferred_channel: type.patients.joins(:communications)
    #                           .group('communications.channel')
    #                           .order('count_id DESC')
    #                           .count('id')
    #                           .first&.first
    #   }
    # end
    @types = {'numbers': [12, 19, 3]}

    render json: @types
  end

  def patient_satisfaction
    # Example data - replace with your actual data from database
    render json: {
      months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      overall_satisfaction: [25, 67, 36, 79, 92, 90],
      wait_time_satisfaction: [75, 78, 80, 82, 35, 13],
      care_quality: [88, 89, 87, 90, 33, 64]
    }
  end
end
