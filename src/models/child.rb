require 'active_record'

include Sunspot::Rails::Searchable

class Child < ActiveRecord::Base
  belongs_to :parent
  
  searchable do
    string :name, :stored => true 
    text :name 
    integer :parent_id, :references => Parent 
  end
end