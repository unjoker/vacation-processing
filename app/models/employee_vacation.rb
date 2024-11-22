class EmployeeVacation < ApplicationRecord
  has_many :requested, class_name: 'VacationRequest'
  has_many :vacation_days
  validates :employee, presence: true, uniqueness: true 
  accepts_nested_attributes_for :requested, :vacation_days
  
  def add(days:,expire_on:)
    return if days < 1
    self.vacation_days.build({initial_qty:days, days:days, expire_on:expire_on})
  end

  def request(from:, to:)
    days = (to - from).to_i
    puts "days requested #{days}"
    return if days < 1
    return if days > self.available
    puts "about to take days!"
    take(days)
    puts "days taken!"
    self.requested.build({from:from, to:to})
    puts "requested vacations: #{self.requested}"
  end

  def take(days)
    puts "taking days"
    day_buckets = self.vacation_days.sort { |d| d.expire_on }
    i = 0
    while(days > 0) do
      days = day_buckets[i].use(days) 
      i+=1 
    end
  end
  
  def cancel(on:)
    request = self.requested.find { |r| r.includes?(on) }
    puts "cancelling request #{request}"
    return_days_from(request)
    request.mark_for_destruction
  end

  def return_days_from(request)
    days = request.days
    puts "days to return #{days}"
    day_buckets = self.vacation_days.sort { |v| v.expire_on }.reverse
    i = day_buckets.size - 1
    puts i
    while(days > 0) do
      puts "buckets: #{day_buckets[i]}"
      days = day_buckets[i].add(days)
      puts "remaining days #{days}"
      i -= 1
    end
  end

  def available(options={})
    return self.vacation_days.sum { |d| d.days } unless !options[:expiring].nil?
  
    (self.vacation_days.find(ifnone:0) { |d| d.expire_on == options[:expiring]}).days
  end
end
