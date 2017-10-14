class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.references

      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
  end
end
