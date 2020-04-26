defmodule LivriAppWeb.TagController do
  use LivriAppWeb, :controller

  alias LivriApp.Tags
  alias LivriApp.Tags.Tag

  action_fallback LivriAppWeb.FallbackController

  require Logger
  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    tags = Tags.list_tags(user.id)
    render(conn, "index.json", tags: tags)
  end

  def create(conn, %{"tag" => params}) do
    user = Guardian.Plug.current_resource(conn)
    tag_params = Map.put(params, "user_id", user.id)
    with {:ok, %Tag{} = tag} <- Tags.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    tag = Tags.get_tag!(user.id, id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => params}) do
    user = Guardian.Plug.current_resource(conn)
    tag = Tags.get_tag!(user.id, id)    
    tag_params = Map.put(params, "user_id", user.id)
    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    tag = Tags.get_tag!(user.id, id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
