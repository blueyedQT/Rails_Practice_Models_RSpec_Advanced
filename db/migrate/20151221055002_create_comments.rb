class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :comment
      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
