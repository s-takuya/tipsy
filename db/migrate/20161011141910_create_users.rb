class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.text :email
      t.text :image
      t.string :provider

      t.timestamps
    end
  end
end
