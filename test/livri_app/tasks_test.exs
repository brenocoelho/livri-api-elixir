defmodule LivriApp.TasksTest do
  use LivriApp.DataCase

  alias LivriApp.Tasks

  describe "tasks" do
    alias LivriApp.Tasks.Task

    @valid_attrs %{frequency: "some frequency", name: "some name", status: "some status", when: ~D[2010-04-17]}
    @update_attrs %{frequency: "some updated frequency", name: "some updated name", status: "some updated status", when: ~D[2011-05-18]}
    @invalid_attrs %{frequency: nil, name: nil, status: nil, when: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.frequency == "some frequency"
      assert task.name == "some name"
      assert task.status == "some status"
      assert task.when == ~D[2010-04-17]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)
      assert task.frequency == "some updated frequency"
      assert task.name == "some updated name"
      assert task.status == "some updated status"
      assert task.when == ~D[2011-05-18]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
