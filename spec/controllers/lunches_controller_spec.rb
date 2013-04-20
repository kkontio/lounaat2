require 'spec_helper'

describe LunchesController do

  before :each do
    @lunch = mock_model(Lunch)
  end

  describe 'GET index' do
    it 'should call the model class method which returns lunches for the next week' do
      @lunch.class.should_receive(:week_of_lunches)
      get :index
    end

    it 'should load all the upcoming lunches for the week into instance variables' do
      d = Date.today
      expected_with = {}
      expected_without = {}
      expected_with[d] = ['lunch1', 'lunch2']
      expected_without[d] = ['lunch3', 'lunch4']

      @lunch.class.should_receive(:week_of_lunches).and_return([expected_with, expected_without])

      get :index

      assigns(:lunches_with_lunch_items).should eq expected_with
      assigns(:lunches_without_lunch_items).should eq expected_without
    end
  end

  describe 'POST vote' do
    it 'should call the model method which increments votes' do
      l = double('lunch', :id => 1)
      @lunch.class.should_receive(:find).with(l.id.to_s).and_return(l)
      l.should_receive(:add_vote)
      post :vote, :id => l.id
    end
  end
end
