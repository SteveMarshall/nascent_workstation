actions :add

attribute :description, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String, :default => nil

def initialize(name, run_context=nil)
  super
  @action = :add
end
