class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :type_of_user, null: false
      t.string :location, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
