defmodule LivriAppWeb.TaskController do
  use LivriAppWeb, :controller

  alias LivriApp.Tasks
  alias LivriApp.Tasks.Task

  action_fallback LivriAppWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    tasks = Tasks.list_tasks(user.id)
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => params}) do
    user = Guardian.Plug.current_resource(conn)
    task_params = Map.put(params, "user_id", user.id)
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    task = Tasks.get_task!(user.id, id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => params}) do
    user = Guardian.Plug.current_resource(conn)
    task = Tasks.get_task!(user.id, id)
    task_params = Map.put(params, "user_id", user.id)
    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    task = Tasks.get_task!(user.id, id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
