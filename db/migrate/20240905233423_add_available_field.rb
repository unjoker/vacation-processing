class AddAvailableField < ActiveRecord::Migration[7.1]
  def change
    add_column :employee_vacations, :available, :integer
  end
end
