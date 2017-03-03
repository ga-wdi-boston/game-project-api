# frozen_string_literal:true
class AddMNKToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :m, :integer, default: 3, null: false
    add_column :games, :n, :integer, default: 3, null: false
    add_column :games, :k, :integer, default: 3, null: false
  end
end
