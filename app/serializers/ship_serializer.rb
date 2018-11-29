class ShipSerializer < ActiveModel::Serializer
  attributes :id, :name, :pilot, :notes, :like
end
