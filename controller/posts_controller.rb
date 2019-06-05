class PostController < Sinatra::Base ##Sinatra is a module, base is a class inside

  #Set the root of the parent directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..') ##___FILE___ gives name of current file - says to join on a .. which takes back to root
  #Sets the view directory correctly - forms a path to where the views are
  set :views, Proc.new {File.join(root, "views")}
  configure :development do
    register Sinatra::Reloader
  end

  $posts = [{
    id: 0,
    title: "Audi r8",
    body: "A super fast car!",
    color: "Red",
    engine: "5.2 L V10",
    speed: "200.1 to 205.1 mph",
    price: "£125,445"
    }]
    puts File.join(root, "views")

    #Displays all posts
    get "/" do
      @title = "Homepage"
      @posts = $posts
      erb :'posts/index'
    end

    #Add new entry, then redirect to homepage 
    post "/" do
    new_post = {
      id: $posts.length,
      title: params[:title],
      body: params[:body],
      color: params[:color],
      engine: params[:engine],
      speed: params[:speed],
      price: params[:price]
    }
      $posts.push(new_post)
      redirect "/"
    end

    #Show form to add new post
    get "/new" do
      @title = "New Post"
      @post = {
      id: "",
      title: "",
      body: "",
      color: "",
      engine: "",
      speed: ""
    }
      erb :'posts/new'
    end

    #Edit post
    get "/:id/edit" do
      @title = "Edit Post"
      id = params[:id].to_i
      @post = $posts[id]
      erb :'posts/edit'
    end

    #Delete post
    delete "/:id" do
      id = params[:id].to_i
      $posts.delete_at(id)
      redirect "/"
    end

    #Update entry - then redirect to homepage
    put "/:id" do
      id = params[:id].to_i
      post = $posts[id]
      $posts[id] = post
      post[:title] = params[:title]
      post[:body] = params[:body]
      post[:color] = params[:color]
      post[:engine] = params[:engine]
      post[:speed] = params[:speed]
      post[:price] = params[:price]
      redirect "/"
    end

    #Show individual entry when clicked
    get "/:id" do
      @title = "Cars"
      id = params[:id].to_i
      @post = $posts[id]
      erb :'posts/shows'
    end

end
