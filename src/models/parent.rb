require 'active_record'

class Parent < ActiveRecord::Base
  has_and_belongs_to_many :children, :foreign_key => 'parent_id', :join_table => 'parent_child'
end