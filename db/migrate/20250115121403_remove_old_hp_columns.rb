class RemoveOldHpColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :characters, :max_hp, :integer if column_exists?(:characters, :max_hp)
    remove_column :characters, :current_hp, :integer if column_exists?(:characters, :current_hp)
  end
end
