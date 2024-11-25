class InitializeTables < ActiveRecord::Migration[7.0]
  def change
    create_table :personality_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :patients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :personality_type, foreign_key: true
      t.timestamps
    end

    create_table :communications do |t|
      t.references :patient, foreign_key: true
      t.text :content
      t.integer :channel, null: false
      t.integer :sentiment
      t.float :response_time
      t.timestamps
    end

    create_table :retention_rates do |t|
      t.references :personality_type, foreign_key: true
      t.integer :month
      t.float :rate
      t.timestamps
    end

    add_index :patients, :email, unique: true
  end
end
