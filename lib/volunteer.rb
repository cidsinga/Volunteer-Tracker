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
end
