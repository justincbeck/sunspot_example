require 'active_record'

class Child < ActiveRecord::Base
  belongs_to :parent
end