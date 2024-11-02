class AddVacationDaysInitialCount < ActiveRecord::Migration[7.1]
  def change
    add_column :vacation_days, :initial_qty, :integer
  end
end
