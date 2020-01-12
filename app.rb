require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/project')
require('./lib/volunteer')
require('pg')


DB = PG.connect({:dbname => "new_volunteer_tracker"})

get('/') do
  erb(:index)
end

get('/projects') do
  #will show a list of projects
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  #take us to a page for adding new projects
  title = params[:title]
  project = Project.new({:title => title, :id => nil})
  project.save()
  redirect to ('/projects')
end

get('/projects/:id') do
  #will show a specific project based on its id
  @project = Project.find(params[:id].to_i)
  @project.update(params[:title])
  erb(:project)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

get('/projects/:id/volunteers/:vol_id') do
  @project = Project.find(params[:id].to_i())
  @volunteer = Volunteer.find(params[:vol_id].to_i())
  erb(:volunteer)
end

patch('/projects/:id/volunteers/:vol_id') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.find(params[:vol_id].to_i())
  volunteer.update(params[:rename], @project.id)
  erb(:project)
end
