# frozen_string_literal:true
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player_x, null: false
      t.references :player_o
      t.integer :m, default: 3, null: false
      t.integer :n, default: 3, null: false
      t.integer :k, default: 3, null: false
      t.string :cells, array: true
      t.boolean :over, null: false, default: false
    end
  end
end
