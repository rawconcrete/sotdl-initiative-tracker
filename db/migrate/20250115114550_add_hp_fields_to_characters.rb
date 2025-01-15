class AddHpFieldsToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :hp, :integer
    add_column :characters, :damage, :integer, default: 0
    add_column :characters, :bonus_hp, :integer, default: 0
  end
end
