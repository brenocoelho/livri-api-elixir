defmodule LivriAppWeb.UserView do
  use LivriAppWeb, :view
  alias LivriAppWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      document: user.document,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone}
  end

  def render("jwt.json", %{token: jwt}) do
    %{token: jwt}
  end  
end
