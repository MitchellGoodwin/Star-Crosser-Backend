class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstName
      t.string :lastName
      t.string :location
      t.integer :age
      t.string :birthDate
      t.string :picture
      t.string :gender
      t.string :lookingFor
      t.integer :sun_sign_id
      t.text :bioIntro
      t.text :bioGeneral
      t.text :bioFood
      t.text :bioMusic
      t.text :bioMovies
      t.text :bioBooks
      t.text :bioActivities
      t.text :bioGoals

      t.timestamps
    end
  end
end
