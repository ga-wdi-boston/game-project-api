#
class GameSerializer < ActiveModel::Serializer
  attributes :id, :cells, :over

  # S/B belongs_to
  # method name added in active_model_serializers RC 0.10.0
  has_one :player_x
  has_one :player_o
end
