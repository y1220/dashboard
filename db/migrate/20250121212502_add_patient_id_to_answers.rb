class AddPatientIdToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :patient_id, :integer
  end
end
