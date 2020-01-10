class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save()
    new_id = DB.exec("INSERT INTO projects (title) VALUEs ('#{@title}') RETURNING id; ")
    @id = new_id.first().fetch("id").to_i
  end

  def ==(self_compare)
    self.title == self_compare.title ? true : false
  end

  def self.all()
  from_db_projects = DB.exec("SELECT * FROM projects;")
  projects = []
  from_db_projects.each do |project|
    title = project.fetch("title")
    id = project.fetch("id").to_i
    projects.push(Project.new({:title => title, :id => id}))
  end
  projects
end


end
