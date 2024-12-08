class PatientController < ApplicationController
  def categorized_list
    @id = params[:id]
    @patients = Patient.where(personality_type_id: @id)
    # Your logic here using the id parameter
  end
end
