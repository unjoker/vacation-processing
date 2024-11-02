class CreateVacationRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :vacation_requests do |t|

      t.timestamps
    end
  end
end
