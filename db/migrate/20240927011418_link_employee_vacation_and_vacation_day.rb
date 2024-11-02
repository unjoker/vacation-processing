class LinkEmployeeVacationAndVacationDay < ActiveRecord::Migration[7.1]
  def change
    add_column :vacation_days, :employee_vacation_id, :integer
  end
end
