require 'rubygems'

require 'rails'

require 'sunspot'
require 'sunspot/rails'

require 'active_record'
require 'mysql'
require 'logger'

require 'models/parent'
require 'models/child'

logger = Logger.new(STDERR)

ActiveRecord::Base.logger = logger
ActiveRecord::Base.colorize_logging = true

ActiveRecord::Base.establish_connection(
        :adapter => 'mysql',
        :host => 'localhost',
        :database => 'sunspot_test'
        )
        
Sunspot.config.solr.url = 'http://127.0.0.1:8983/solr'

Sunspot::Adapters::InstanceAdapter.register(Sunspot::Rails::Adapters::ActiveRecordInstanceAdapter, ActiveRecord::Base)
Sunspot::Adapters::DataAccessor.register(Sunspot::Rails::Adapters::ActiveRecordDataAccessor, ActiveRecord::Base)

Sunspot.setup(Child) do
  string :name, :stored => true
  text :name
  integer :parent_id, :references => Parent
end

parent = Parent.create( :name => 'Big Jim')

bob = Child.create( :name => 'Bob', :parent => parent )
Sunspot.index(bob)

bill = Child.create( :name => 'Bill', :parent => parent )
Sunspot.index(bill)

logger.debug "Defining Search"
search = Sunspot.search(Child)
search.build do
  keywords ['bill']
end

logger.debug "Hits: #{search.hits.size}"
search.each_hit_with_result do |hit, child|
  logger.debug child.name
end

children = Child.find(:all)
children.each do |child|
  child.delete
end

parents = Parent.find(:all)
parents.each do |parent|
  parent.delete
end
