class QuestionnaireController < ApplicationController
  def index
    @questionnaires = Questionnaire.includes(:questions)
  end

  def show
    @questions = Question.where(questionnaire_id: Questionnaire.first.id)
    @patient = Patient.find(params[:id])
    @answered_at = Answer.where(patient_id: @patient.id).last.created_at
  end
end
