class CreateSunSigns < ActiveRecord::Migration[6.0]
  def change
    create_table :sun_signs do |t|
      t.string :name
      t.text :wish
      t.text :hates
      t.text :bad_traits
      t.text :good_traits
      t.text :favorites
      t.text :planet
      t.string :symbol
      t.text :keywords
      t.string :vibe
      t.text :compatability
      t.text :mental_traits
      t.text :physical_traits
      t.text :sun_dates
      t.string :element

      t.timestamps
    end
  end
end
