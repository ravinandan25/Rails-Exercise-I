class CreateEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :gender
      t.date :dob
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
