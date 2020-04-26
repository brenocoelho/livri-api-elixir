defmodule LivriAppWeb.UserController do
  use LivriAppWeb, :controller

  alias LivriApp.Users
  alias LivriApp.Users.User
  alias LivriApp.Users.Guardian

  action_fallback LivriAppWeb.FallbackController

  # require Logger
  # Logger.info("user_controller - username: #{inspect(username)}")
  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.user_path(conn, :show, user))
      # |> render("show.json", user: user)
      |> render("jwt.json", token: token)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    id = Guardian.Plug.current_resource(conn)
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _params) do
    id = Guardian.Plug.current_resource(conn)
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    Users.authenticate_user(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:ok, %User{} = user}, conn) do
    with {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", token: token)
    end
  end

  defp login_reply({:error, :unauthorized}, _conn) do
    {:error, :unauthorized} 
  end

end
