# frozen_string_literal:true
# rubocop:disable Metrics/MethodLength
class AddAdditionalConstraints < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL.squish
          ALTER TABLE games
          ADD CONSTRAINT m
          CHECK (m >= 3 AND m <= 20),
          ADD CONSTRAINT n
          CHECK (n >= 3 AND n <= 20),
          ADD CONSTRAINT k
          CHECK (k >= 3 AND k <= LEAST(m, n)),
          ADD CONSTRAINT cells
          CHECK (array_length(cells, 1) = m * n)
        SQL
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
