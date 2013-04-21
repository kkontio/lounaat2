require 'spec_helper'

describe LunchItem do
  it {should belong_to(:lunch)}
  it {should validate_uniqueness_of(:description).scoped_to(:lunch_id)}
end
