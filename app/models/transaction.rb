class Transaction < ApplicationRecord
  belongs_to :sourceable, polymorphic: true
  belongs_to :targetable, polymorphic: true
end
