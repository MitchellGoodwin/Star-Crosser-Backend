class AddLatAndLongToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lat, :integer
    add_column :users, :lng, :integer
  end
end
