class PatientController < ApplicationController
  def categorized_list
    @id = params[:id]
    @patients = Patient.where(personality_type_id: @id).page(params[:page]).per(10)
    # Apply filters if present
    @patients = @patients.where("LOWER(name) LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @patients = @patients.where(gender: params[:gender]) if params[:gender].present?

    # Age range filter
    if params[:age_from].present? || params[:age_to].present?
      if params[:age_from].present?
        age_from_date = Date.today - params[:age_from].to_i.years
        @patients = @patients.where("birthday <= ?", age_from_date)
      end

      if params[:age_to].present?
        age_to_date = Date.today - params[:age_to].to_i.years
        @patients = @patients.where("birthday >= ?", age_to_date)
      end
    end
  end

  def export
    @patients = Patient.all

    respond_to do |format|
      format.csv { send_data @patients.to_csv, filename: "patients-#{Date.today}.csv" }
    end
  end
end
