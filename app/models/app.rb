class App
  attr_reader :name, :namespace, :version, :configurations

  def initialize(name, namespace,version)
    @name = name
    @namespace = namespace
    @version = version
    @configurations = Array.new
  end
end
