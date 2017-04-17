# frozen_string_literal:true

class CreateGames < ActiveRecord::Migration
  # rubocop:disable Metrics/AbcSize
  def change
    m, n = Rails.application.config.game_settings.values_at(:m, :n)

    create_table :games do |t|
      t.references :player_x, null: false
      t.references :player_o
      t.integer :m, default: m[:min], null: false
      t.integer :n, default: n[:min], null: false
      t.integer :k, default: [m[:min], n[:min]].min, null: false
      t.string :cells, array: true, null: false
      t.boolean :over, default: false, null: false
    end
  end
end
