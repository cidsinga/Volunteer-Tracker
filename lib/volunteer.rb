class Volunteer
  attr_accessor :name, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(self_to_compare)
    (self.name() == self_to_compare.name()) && (self.project_id() == self_to_compare.project_id())
  end

  def self.all()
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

  def save()
    results = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;").first
    @id = results.fetch("id").to_i
  end

  def self.find(id)
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = returned_volunteers.fetch("name")
    id = returned_volunteers.fetch("id").to_i
    project_id = returned_volunteers.fetch("project_id").to_i
    volunteer = Volunteer.new({:name => name, :id => id, :project_id => project_id})
  end
end
