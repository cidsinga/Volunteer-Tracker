class Project
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def title()
    result = DB.exec("SELECT title FROM projects;").first()

  end
end
