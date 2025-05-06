class AddJoinCodeToTeams < ActiveRecord::Migration[7.2]
  def change
    add_column :teams, :join_code, :string, null: false
    add_index :teams, :join_code, unique: true
  end
end
