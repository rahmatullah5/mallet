module Wallet
  extend ActiveSupport::Concern

  included do
    after_create :init_default_balance
    has_many :credits, -> { where.not(targetable: nil) }, class_name: 'Transaction', as: :sourceable
    has_many :withdraws, -> { where(targetable: nil) }, class_name: 'Transaction', as: :sourceable
    has_many :debits, -> { where.not(sourceable: nil) }, class_name: 'Transaction', as: :targetable
    has_many :deposits, -> { where(sourceable: nil) }, class_name: 'Transaction', as: :targetable
  end

  def transfer(target, amount)
    ActiveRecord::Base.transaction do
      credits.create(targetable: target, amount: amount)  
    end
  end

  def withdraw(amount)
    ActiveRecord::Base.transaction do
      credits.create(amount: amount)
    end
  end

  def deposit(amount)
    ActiveRecord::Base.transaction do
      deposits.create(amount: amount)
    end
  end

  def balance
    (sum_of_debits + sum_of_deposits) - (sum_of_credits + sum_of_withdraws)
  end

  def sum_of_debits
    debits.sum(:amount)
  end

  def sum_of_credits
    credits.sum(:amount)
  end

  def sum_of_withdraws
    withdraws.sum(:amount)
  end

  def sum_of_deposits
    deposits.sum(:amount)
  end

  def transactions_count
    debits.count + withdraws.count + credits.count
  end

  private
  def init_default_balance
    ActiveRecord::Base.transaction do
      #let's assume whenever user create new account, the admin will gave them 1000 balance for free
      debits.create!(sourceable: Admin.first, amount: 1000)
    end
  end
end