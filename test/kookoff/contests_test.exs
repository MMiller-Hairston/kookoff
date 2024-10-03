defmodule Kookoff.ContestsTest do
  use Kookoff.DataCase

  alias Kookoff.Contests

  describe "contests" do
    alias Kookoff.Contests.Contest

    import Kookoff.ContestsFixtures

    @invalid_attrs %{state: nil, description: nil, title: nil, start_time: nil}

    test "list_contests/0 returns all contests" do
      contest = contest_fixture()
      assert Contests.list_contests() == [contest]
    end

    test "get_contest!/1 returns the contest with given id" do
      contest = contest_fixture()
      assert Contests.get_contest!(contest.id) == contest
    end

    test "create_contest/1 with valid data creates a contest" do
      valid_attrs = %{state: "some state", description: "some description", title: "some title", start_time: ~U[2024-10-02 03:53:00Z]}

      assert {:ok, %Contest{} = contest} = Contests.create_contest(valid_attrs)
      assert contest.state == "some state"
      assert contest.description == "some description"
      assert contest.title == "some title"
      assert contest.start_time == ~U[2024-10-02 03:53:00Z]
    end

    test "create_contest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contests.create_contest(@invalid_attrs)
    end

    test "update_contest/2 with valid data updates the contest" do
      contest = contest_fixture()
      update_attrs = %{state: "some updated state", description: "some updated description", title: "some updated title", start_time: ~U[2024-10-03 03:53:00Z]}

      assert {:ok, %Contest{} = contest} = Contests.update_contest(contest, update_attrs)
      assert contest.state == "some updated state"
      assert contest.description == "some updated description"
      assert contest.title == "some updated title"
      assert contest.start_time == ~U[2024-10-03 03:53:00Z]
    end

    test "update_contest/2 with invalid data returns error changeset" do
      contest = contest_fixture()
      assert {:error, %Ecto.Changeset{}} = Contests.update_contest(contest, @invalid_attrs)
      assert contest == Contests.get_contest!(contest.id)
    end

    test "delete_contest/1 deletes the contest" do
      contest = contest_fixture()
      assert {:ok, %Contest{}} = Contests.delete_contest(contest)
      assert_raise Ecto.NoResultsError, fn -> Contests.get_contest!(contest.id) end
    end

    test "change_contest/1 returns a contest changeset" do
      contest = contest_fixture()
      assert %Ecto.Changeset{} = Contests.change_contest(contest)
    end
  end
end
