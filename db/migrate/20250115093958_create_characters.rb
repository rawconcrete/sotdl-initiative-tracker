class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.boolean :is_ally
      t.boolean :fast_turn
      t.boolean :acted, default: false

      t.timestamps
    end
  end
end
