class Restaurant < ActiveRecord::Base
  attr_accessible :name

  has_many :lunches, :dependent => :destroy
end
