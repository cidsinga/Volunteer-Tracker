class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  # def title()
  #   project = DB.exec("SELECT * title FROM projects;").first()
  # end
end