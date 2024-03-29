defmodule LivriAppWeb.Router do
  use LivriAppWeb, :router
  
  alias LivriApp.Users

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Users.AuthAccessPipeline
  end

  scope "/api/v1", LivriAppWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/signup", UserController, :create

    # get "/users", UserController, :index
    # delete "/users/:id", UserController, :delete
  end

  scope "/api/v1", LivriAppWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/user", UserController, :show
    put "/user", UserController, :update
    delete "/user", UserController, :delete

    resources "/tasks", TaskController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end

end
