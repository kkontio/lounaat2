class Restaurant < ActiveRecord::Base
  attr_accessible :name, :alias
  validates_uniqueness_of :name
  has_many :lunches, :dependent => :destroy
end
