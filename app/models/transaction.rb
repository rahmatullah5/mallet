class Transaction < ApplicationRecord
  belongs_to :sourceable, polymorphic: true, optional: true 
  belongs_to :targetable, polymorphic: true, optional: true 

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :check_current_balance, :check_self_transfer, on: :create

  private
  def check_current_balance
    errors.add(:amount, 'is not enough to process this transcation') if sourceable.present? && sourceable.balance - amount < 0
  end

  def check_self_transfer
    errors.add(:targetable, 'cannot same as transfer source') if sourceable.eql?(targetable)
  end
end
