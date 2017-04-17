# frozen_string_literal:true

class AddAdditionalConstraints < ActiveRecord::Migration
  def add_constraint(column, constraint)
    query = "ALTER TABLE games ADD CONSTRAINT #{column} CHECK (#{constraint});"

    execute(query)
  end

  # rubocop:disable Metris/AbcSize, Metrics/MethodLength
  def change
    m, n = Rails.application.config.game_settings.values_at(:m, :n)

    reversible do |direction|
      direction.up do
        constraints = {
          m: "m >= #{m[:min]} AND m <= #{m[:max]}",
          n: "n >= #{n[:min]} AND n <= #{n[:max]}",
          k: "k >= #{[m[:min], n[:min]].min} AND k <= LEAST(m, n)",
          cells: 'array_length(cells, 1) = m * n'
        }

        constraints.each do |column, constraint|
          add_constraint(column, constraint)
        end
      end

      direction.down do
        execute <<-SQL.squish
          ALTER TABLE games
          DROP CONSTRAINT m,
          DROP CONSTRAINT n,
          DROP CONSTRAINT k,
          DROP CONSTRAINT cells
        SQL
      end
    end
  end
end
