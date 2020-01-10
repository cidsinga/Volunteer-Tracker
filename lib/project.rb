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


end
