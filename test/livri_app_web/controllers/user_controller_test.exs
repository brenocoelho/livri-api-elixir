defmodule LivriAppWeb.UserControllerTest do
  use LivriAppWeb.ConnCase

  alias LivriApp.Users
  alias LivriApp.Users.User

  @create_attrs %{
    digital_hash: "some digital_hash",
    document: "some document",
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    phone: "some phone",
    username: "some username"
  }
  @update_attrs %{
    digital_hash: "some updated digital_hash",
    document: "some updated document",
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    phone: "some updated phone",
    username: "some updated username"
  }
  @invalid_attrs %{digital_hash: nil, document: nil, email: nil, first_name: nil, last_name: nil, phone: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "digital_hash" => "some digital_hash",
               "document" => "some document",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "phone" => "some phone",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "digital_hash" => "some updated digital_hash",
               "document" => "some updated document",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "phone" => "some updated phone",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end