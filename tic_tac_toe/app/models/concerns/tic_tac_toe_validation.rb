#
module TicTacToeValidation
  extend ActiveSupport::Concern

  included do
    validate :no_cell_reset
  end

  private

  def cell_reset?
    cells_was.zip(cells).any? do |e|
      e.first != e.last && !e.first.empty?
    end
  end

  def no_cell_reset
    errors.add(:cells, 'cell reset disallowed') if cell_reset?
  end
end
