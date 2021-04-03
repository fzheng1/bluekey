class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""

      # DB authenticatable
      t.string :email, null: false
      t.string :encrypted_password, null:false
      
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end

  def down
    drop_table :users
  end
end
