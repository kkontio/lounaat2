require 'spec_helper'

describe Lunch do
  describe 'listing lunches' do
    it 'should list lunches for a week forward, starting today' do
      r = FactoryGirl.create(:restaurant)

      lunches = []

      for i in 0..13
        lunches << FactoryGirl.create(:lunch, restaurant: r, date: Date.today + i.days)
      end

      for i in 1..14
        FactoryGirl.create(:lunch, restaurant: r, date: Date.today - i.days)
      end

      with_lunch_items, without_lunch_items = Lunch.week_of_lunches

      expect(without_lunch_items[Date.today - 1.days]).to eq(nil)

      for i in 0..6
        expect(without_lunch_items[Date.today + i.days]).to eq([lunches[i]])
      end

      expect(without_lunch_items[Date.today + 7.days]).to eq(nil)
    end

    it 'should order lunches by restaurant name' do
      r1 = FactoryGirl.create(:restaurant, name: 'A ravintola')
      r2 = FactoryGirl.create(:restaurant, name: 'B ravintola')
      r3 = FactoryGirl.create(:restaurant, name: 'C ravintola')
      r4 = FactoryGirl.create(:restaurant, name: 'D ravintola')
      l1 = FactoryGirl.create(:lunch, restaurant: r1, date: Date.today)
      l2 = FactoryGirl.create(:lunch, restaurant: r2, date: Date.today)
      l3 = FactoryGirl.create(:lunch, restaurant: r3, date: Date.today)
      l4 = FactoryGirl.create(:lunch, restaurant: r4, date: Date.today)
      li1 = FactoryGirl.create(:lunch_item, lunch: l1)
      li2 = FactoryGirl.create(:lunch_item, lunch: l2)
      with_lunch_items, without_lunch_items = Lunch.week_of_lunches
      expect(with_lunch_items[Date.today]).to eq([l1, l2])
      expect(without_lunch_items[Date.today]).to eq([l3, l4])
    end
  end

  describe 'initializing lunches' do
    it 'should initialize lunches for a week forward, excluding weekdays' do
      r = FactoryGirl.create(:restaurant)
      Lunch.init_lunches

      for i in 0..6
        d = Date.today + i.days

        if d.saturday? || d.sunday?
          Lunch.find_by_restaurant_id_and_date(r.id, d).should == nil
        else
          Lunch.find_by_restaurant_id_and_date(r.id, d).should_not == nil
        end
      end
    end
  end

  describe 'voting' do
    it 'should be able to increment votes given' do
      l = FactoryGirl.create(:lunch)
      l.votes.should eq 0
      l.add_vote
      l.votes.should eq 1
    end
  end
end
