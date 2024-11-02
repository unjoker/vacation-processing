class VacationRequest < ApplicationRecord
  validates :to, :from, presence: true
  validates :to, comparison: { greater_than: :from , message: 'the ending date must be later than the initial one' }
  validates :from, :to, comparison: { greater_than: Date.today, message: 'the requested dates must be later than today' }

  def includes?(date)
    (self.from..self.to).include?(date)
  end

  def days()
    (self.to - self.from).to_i
  end

  def to_s()
    "#{self.from} to #{self.to}"
  end
end
