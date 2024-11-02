class AddEmployeeToEmployeeVacation < ActiveRecord::Migration[7.1]
  def change
    add_column :employee_vacations, :employee, :string
  end
end
