require 'rubygems'

require 'rails'
require 'sunspot'
require 'sunspot/rails'
require 'active_record'
require 'mysql'
require 'logger'

logger = Logger.new(STDERR)
ActiveRecord::Base.logger = logger
ActiveRecord::Base.colorize_logging = true
ActiveRecord::Base.establish_connection(:adapter => 'mysql', :host => 'localhost', :database => 'sunspot_example')
Sunspot::Adapters::InstanceAdapter.register(Sunspot::Rails::Adapters::ActiveRecordInstanceAdapter, ActiveRecord::Base)
Sunspot::Adapters::DataAccessor.register(Sunspot::Rails::Adapters::ActiveRecordDataAccessor, ActiveRecord::Base)

require 'models/parent'
require 'models/child'

mom = Parent.create( :name => 'Betty Sue')
dad = Parent.create( :name => 'Jim Bob')

bob = Child.new( :name => 'Bob' )
bob.parents << mom
bob.parents << dad
bob.save

bill = Child.new( :name => 'Bill' )
bill.parents << mom
bill.parents << dad
bill.save

Sunspot.commit

logger.debug "Defining Search"
search = Child.search { keywords ['bill'] }

logger.debug "Hits: #{search.hits.size}"
search.each_hit_with_result { |hit, child| logger.debug child.name }

Child.destroy_all
Parent.destroy_all