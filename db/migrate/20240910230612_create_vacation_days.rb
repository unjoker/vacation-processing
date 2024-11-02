class CreateVacationDays < ActiveRecord::Migration[7.1]
  def change
    create_table :vacation_days do |t|
      t.integer :days
      t.date :expire_on

      t.timestamps
    end
  end
end
