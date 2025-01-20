class AddRecordIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :record_id, :string
  end
end
