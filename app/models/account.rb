class Account < ActiveRecord::Base
  attr_accessible :balance, :number

  validate :price_must_be_at_least_a_cent

  def withdraw(amount)
    adjust_balance_and_save(-amount)
  end

  def deposit(amount)
    adjust_balance_and_save(amount)
  end

  private

  def adjust_balance_and_save(amount)
    self.balance += amount
    save!
  end

  def price_must_be_at_least_a_cent
    errors.add(:balance, "is negative") if balance < 0
  end
end
