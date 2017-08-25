require 'sinatra'
require 'sinatra/reloader' if development?
require 'cgi'
require 'open-uri'
require 'digest/sha2'

helpers do
  def h(str)
    CGI.escape_html(str)
  end

  def default_name
    'Joe Bloggs'
  end

  def salt
    'UNIQUE_SALT'
  end

  def salted_name(name)
    [salt, name].join
  end

  def hexdigest(str)
    Digest::SHA256.hexdigest(str)
  end
end

mainpage = Proc.new do
  @name = request.post? ? params[:name] : default_name
  @name_hash = hexdigest(salted_name(@name))

  erb :index
end

get  '/', &mainpage
post '/', &mainpage

get '/monster/:name' do
  resp = open("http://dnmonster:8080/monster/#{params[:name]}?size=80")
  image = resp.read

  content_type :png

  image
end

__END__

@@ layout
<html>
  <head>
    <title>Identidock</title>
  </head>

  <body>
    <%= yield %>
  </body>
</html>

@@ index
<form method="post">
  Hello <input type="text" name="name" value="<%= h @name %>">
  <input type="submit" value="submit">
</form>

<p>
  You look like a:
  <img src="/monster/<%= h @name_hash %>">
</p>
