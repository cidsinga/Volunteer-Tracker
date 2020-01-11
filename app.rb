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
end

post('/projects') do
  #take us to a page for adding new projects
  title = params[:title]
  if title =~ /^[a-z0-9 \_ \-]*$/
    project = Project.new({:title => title, :id => nil})
    project.save()
    erb(:projects)
end


end
