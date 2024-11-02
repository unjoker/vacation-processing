class AddEmployeeVacationId < ActiveRecord::Migration[7.1]
  def change
    add_column :vacation_requests, :employee_vacation_id, :integer 
  end
end
