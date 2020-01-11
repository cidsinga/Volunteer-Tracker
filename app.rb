require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/project')
require('./lib/volunteer')
require('pg')


DB = PG.connect({:dbname => "new_volunteer_tracker"})

get('/') do
  erb(:projects)
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
end
