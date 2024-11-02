class VacationDay < ApplicationRecord
  #after_initialize :set_initial_qty

  #def set_initial_qty()
  #  self.initial_qty = self.days
  #end

  def use(days)
    unfulfilled_days = self.days >= days ? 0 : days - self.days

    days_to_use = self.days >= days ? days : self.days
    self.days -= days_to_use

    return unfulfilled_days
  end

  def add(days)
    available_capacity = self.initial_qty - self.days 
    puts "available_capacity: #{available_capacity}"
    days_to_add = days >= available_capacity ? available_capacity : days  
    puts "days_to_add: #{days_to_add}"
    self.days += days_to_add
    puts "self.days: #{self.days}"
    days - days_to_add
  end

  def to_s()
    "initial_qty: #{self.initial_qty}, days: #{self.days}"
  end
end
