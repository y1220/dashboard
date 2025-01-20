class ChangeContentToFieldLabelAndAddFieldKeyToQuestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :content, :field_label
    add_column :questions, :field_key, :string
  end
end
