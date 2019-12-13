class AddMilkCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :milks_count, :integer
  end
end
