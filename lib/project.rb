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

def save()
  results = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}')RETURNING id;").first
  @id = results.fetch("id").to_i
end

def self.find(id)
  returned_projects = DB.exec("SELECT * FROM projects WHERE id = #{id};").first()
  title = returned_projects.fetch("title")
  project = Project.new({:title => title, :id => id})
end

def volunteers
  Volunteer.find_by_project(self.id)
end

def update(attributes)
  @title = attributes.fetch(:title)
  DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")

end


end
