class App
  attr_reader :name, :namespace

  def initialize(name, namespace)
    @name = name
    @namespace = namespace
  end
end
