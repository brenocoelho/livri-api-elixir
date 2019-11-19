defmodule LivriAppWeb.Router do
  use LivriAppWeb, :router
  
  alias LivriAppWeb.{UserController, TaskController}

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LivriAppWeb do
    pipe_through :api
  end

  resources "/users", UserController, except: [:new, :edit]
  resources "/tasks", TaskController, except: [:new, :edit]

end
