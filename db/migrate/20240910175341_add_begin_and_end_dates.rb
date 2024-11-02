class AddBeginAndEndDates < ActiveRecord::Migration[7.1]
  def change
    add_column :vacation_requests, :from, :date
    add_column :vacation_requests, :to, :date
  end
end
