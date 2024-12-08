class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.text :text_value
      t.integer :numerical_value
      t.integer :option_id

      t.timestamps
    end
  end
end
