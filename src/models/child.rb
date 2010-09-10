require 'active_record'

include Sunspot::Rails::Searchable

class Child < ActiveRecord::Base
  has_and_belongs_to_many :parents, :foreign_key => 'child_id', :join_table => 'parent_child'
  
  searchable do
    string :name, :stored => true 
    text :name 
  end
end