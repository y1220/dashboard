class Api::CommunicationsController < ApplicationController
  def index
    @communications = Communication.group_by_month(:created_at)
                                 .count
    render json: @communications
  end
end
