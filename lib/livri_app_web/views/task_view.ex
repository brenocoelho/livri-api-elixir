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
      when: task.when,
      frequency: task.frequency,
      status: task.status}
  end
end
