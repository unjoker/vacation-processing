require 'rails_helper'

RSpec.describe VacationRequest, type: :model do
  describe 'on creation' do
    context 'end date < inital date' do
      it 'marks itself as invalid' do
        start_date = Date.today >> 15
        end_date = start_date - 1
        vacation = VacationRequest.new(from:start_date, to:end_date)
        expect(vacation.invalid?).to eq true
        expect(vacation.errors[:to].size).to eq 1 
        expect(vacation.errors[:to][0]).to eq 'the ending date must be later than the initial one'
      end
    end
    context 'only receives initial date' do
      it 'marks itself as invalid' do
        vacation = VacationRequest.new(from: Date.today >> 15)
        expect(vacation.invalid?).to eq true
        expect(vacation.errors[:to].size).to eq 3
      end
    end
    context 'only receives ending date' do
      it 'marks itself as invalid' do
        vacation = VacationRequest.new(to: Date.today >> 15)
        expect(vacation.invalid?).to eq true
        expect(vacation.errors[:from].size).to eq 2
      end
    end
    context 'with no dates' do
      it 'marks itself as invalid' do
        vacation = VacationRequest.new()
        expect(vacation.invalid?).to eq true
        expect(vacation.errors.size).to eq 5
      end
    end
    context 'initial date < today' do
      it 'marks itself as invalid' do
        vacation = VacationRequest.new(from: Date.today << 1, to: Date.today >> 1)
        expect(vacation.invalid?).to eq true
        expect(vacation.errors.size).to eq 1
      end
    end
    context 'ending date < today' do
      it 'marks itself as invalid' do
        vacation = VacationRequest.new(from: Date.today >> 1, to: Date.today << 1)
        expect(vacation.invalid?).to eq true
        expect(vacation.errors.size).to eq 2
      end
    end
  end

end
