class CreateMilks < ActiveRecord::Migration[5.1]
  def change
    create_table :milks do |t|
      t.integer :user_id
      t.date :date_milk_expires
      t.text :description

      t.timestamps
    end
  end
end
