defmodule LivriAppWeb.TaskView do
  use LivriAppWeb, :view
  alias LivriAppWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      name: task.name,
      detail: task.detail,
      due_date: task.due_date,
      frequency: task.frequency,
      tags: task.tags,
      status: task.status}
  end
end
