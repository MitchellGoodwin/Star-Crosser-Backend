class ChangeColumnNameSunSignComp < ActiveRecord::Migration[6.0]
  def change
    rename_column :sun_signs, :compatability, :compatibility
  end
end
