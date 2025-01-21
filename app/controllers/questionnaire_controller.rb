class QuestionnaireController < ApplicationController
  def index
    @questionnaires = Questionnaire.includes(:questions)
  end
end
