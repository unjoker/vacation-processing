require 'rails_helper'

RSpec.describe EmployeeVacation, type: :model do

  describe 'on creation' do
    it 'requires an employee email' do
      vacations = EmployeeVacation.new
      expect(vacations.valid?).to eq false

      vacations = EmployeeVacation.new({employee:'john@acme.com'})
      expect(vacations.employee).to eq 'john@acme.com'
      expect(vacations.valid?).to eq true
    end
  end

  describe 'add days' do
    context 'given a positive number' do
      it 'increases the available days' do
        vacations = EmployeeVacation.new
        vacations.add(days: 10, expire_on:Date.today)
        expect(vacations.available).to eq 10
      end
    end
    context 'given a negative number' do
      it 'ignores it' do
        vacations = EmployeeVacation.new
        vacations.add(days: -2, expire_on:Date.today)
        expect(vacations.available).to eq 0
      end  
    end
  end

  describe 'request vacations' do  
    context 'has enough available days' do
      it 'subtracts the requested days from the available days' do
        vacations = EmployeeVacation.new 
        vacations.add(days: 10, expire_on:Date.today)
        vacations.request(from:Date.today, to:Date.today + 5)
        expect(vacations.available).to eq 5
      end
      it 'creates a vacations request' do
        vacations = EmployeeVacation.new
        vacations.add(days: 10, expire_on:Date.today)
        vacations.request(from:Date.today, to:Date.today + 5)
        expect(vacations.requested.size).to eq 1
      end
      it 'uses the days closer to expire first' do
        vacations = EmployeeVacation.new
        vacations.add(days:10, expire_on:Date.today + 30)
        vacations.add(days: 7, expire_on:Date.today + 15)
        expect(vacations.available).to eq 17
        vacations.request(from:Date.today, to:Date.today + 8)
        expect(vacations.available(expiring:Date.today + 15)).to eq 0
        expect(vacations.available(expiring:Date.today + 30)).to eq 9
      end
    end
  end

  describe 'cancel a vacation request' do
    it 'restores the last to expire days first' do
      vacations = EmployeeVacation.new
      vacations.add(days:10, expire_on: Date.today >> 18)
      vacations.add(days:5, expire_on: Date.today + 15)
      vacations.request(from: Date.today + 10, to: Date.today + 22)
      expect(vacations.available(expiring: Date.today >> 18)).to eq 3
      vacations.cancel(on: Date.today + 10)
      expect(vacations.available(expiring: Date.today >> 18)).to eq 10
    end
    it 'removes it' do
      vacations = EmployeeVacation.new
      vacations.add(days:10, expire_on: Date.today + 10)
      vacations.request(from: Date.today, to: Date.today + 5)
      expect(vacations.requested.size).to eq 1
      vacations.cancel(on: Date.today)
      expect(vacations.requested.size).to eq 0
    end
  end
end
