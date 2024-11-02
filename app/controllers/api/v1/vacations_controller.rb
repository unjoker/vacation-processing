class Api::V1::VacationsController < ActionController::API
  def add()
    vacations = EmployeeVacation.new({employee: params[:employee]})
    vacations.add(days: params[:days].to_i, expire_on: Date.today >> 365)
    if(vacations.save)
      head :ok
    else
      head :bad_request
    end 
  end
end
