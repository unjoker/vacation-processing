class VacationsController < ApplicationController

  before_action :authenticate_user!
  #def request()
  #  vacations = EmployeeVacation.find(params[:employee])
  #  vacations.request(from: params[:from], to: params[:to])
  #end

  def index()
   @vacations = get_vacations() 
   @errors = []
  end

  def hello()
    render plain: 'hello!', status: :ok
  end

  def cancel()
    vacations = get_vacations()
    vacations.cancel(on: Date.parse(params[:date]))
    vacations.save
  end

  def vacation_request()
    vacations = get_vacations()
    start_date, end_date = params[:date_range].split(' to ')
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    errors = vacations.request(from: start_date, to: end_date)
    puts "errors: #{errors.to_a}"
    
    if vacations.save() then
      @vacations = vacations
      @errors = []
      render :index
    else
      @vacations = EmployeeVacation.find(vacations.id)
      @errors = vacations.errors.full_messages
      render :index, status: :unprocessable_entity
    end
  end

  def get_vacations()
    EmployeeVacation.find_by(employee: current_user.email)
  end




end
