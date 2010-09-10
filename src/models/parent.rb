require 'active_record'

class Parent < ActiveRecord::Base
  has_many :children
end