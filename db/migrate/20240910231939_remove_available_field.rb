class RemoveAvailableField < ActiveRecord::Migration[7.1]
  def change
    remove_column :employee_vacations, :available
  end
end
