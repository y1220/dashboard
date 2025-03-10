class PatientController < ApplicationController
  def categorized_list
    @id = params[:id]
    @patients = Patient.where(personality_type_id: @id).page(params[:page]).per(10)
    @patients = @patients.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
    @patients = @patients.where(gender: params[:gender]) if params[:gender].present?

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
    @id = params[:id]
    @patients = Patient.where(personality_type_id: @id)
    @filter = ""
    if params[:name].present?
      @filter += "_NameLike#{params[:name]}"
      @patients = @patients.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    if params[:gender].present?
      @filter += "_Gender#{params[:gende1r]}"
      @patients = @patients.where(gender: params[:gender])
    end

    if params[:age_from].present? || params[:age_to].present?
      if params[:age_from].present?
        @filter += "_AgeFrom#{params[:age_from]}"
        age_from_date = Date.today - params[:age_from].to_i.years
        @patients = @patients.where("birthday <= ?", age_from_date)
      end

      if params[:age_to].present?
        @filter += "_AgeTo#{params[:age_to]}"
        age_to_date = Date.today - params[:age_to].to_i.years
        @patients = @patients.where("birthday >= ?", age_to_date)
      end
    end

    respond_to do |format|
      format.csv { send_data @patients.to_csv, filename: "Persona#{@id}#{@filter}_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end
  end

  def assign_persona_type
    @patient = Patient.find(params[:id])
    @patient.personality_type_id = params[:persona_type]
    if @patient.save
      flash[:success] = 'Successfully assigned persona type ' + params[:persona_type] + ' to patient ' + @patient.name
      respond_to do |format|
        format.html { redirect_to result_persona_path(persona_type: @patient.personality_type_id) }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash") }
      end
    else
      flash[:error] = 'Failed to assign persona type'
      respond_to do |format|
        format.html { redirect_to result_persona_path(persona_type: @patient.personality_type_id) }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash") }
      end
    end
  end
end
