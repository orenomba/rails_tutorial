class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
    
    change_table :users do |t|
      t.index :name
      t.index :email
    end
  end

  def self.down
    drop_table :users
  end
end