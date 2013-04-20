require 'spec_helper'

describe Restaurant do
  it {should validate_uniqueness_of(:name)}
  it {should have_many(:lunches)}
end
