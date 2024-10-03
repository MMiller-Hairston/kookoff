defmodule Kookoff.ContestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kookoff.Contests` context.
  """

  @doc """
  Generate a contest.
  """
  def contest_fixture(attrs \\ %{}) do
    {:ok, contest} =
      attrs
      |> Enum.into(%{
        description: "some description",
        start_time: ~U[2024-10-02 03:53:00Z],
        state: "some state",
        title: "some title"
      })
      |> Kookoff.Contests.create_contest()

    contest
  end
end
