require 'rubygems'

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

Sunspot.setup(Child) do
  string :name, :stored => true
  text :name
  integer :parent_id, :references => Parent
end

parent = Parent.create( :name => 'Big Jim')

Child.create( :name => 'Bob', :parent => parent )
Child.create( :name => 'Bill', :parent => parent )

logger.debug "Defining Search"
search = Sunspot.search(Child) do
  keywords 'bill'
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
