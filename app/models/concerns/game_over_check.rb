# frozen_string_literal:true

module GameOverCheck
  extend ActiveSupport::Concern

  included do
    after_update :check_game_over, if: :min_turns_to_win?
  end

  private

  def min_turns_to_win?
    cells.select(&:present?).count >= 2 * k - 1
  end

  def check_game_over
    self.over = true if game_over?
  end

  def k_in_a_row?(cells)
    cells.all? { |cell| !cell.nil? && cell == cells.first }
  end

  def rows
    cells.each_slice(m).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    cell_rows = rows

    [cell_rows, cell_rows.map(&:reverse)].flat_map do |row_set|
      row_set.map.with_index do |row, index|
        ([nil] * index) + row + ([nil] * (n - 1 - index))
      end.transpose.map(&:compact)
    end
  end

  def game_over?
    (rows + columns + diagonals).each do |subset|
      next if subset.length < k
      subset.each_cons(k) { |k_set| return true if k_in_a_row?(k_set) }
    end

    false
  end
end
