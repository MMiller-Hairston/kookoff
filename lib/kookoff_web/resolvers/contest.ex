defmodule KookoffWeb.Resolvers.Contest do
  require Logger

  alias KookoffWeb.Aws
  alias Kookoff.Contests

  def list_contests(_parent, _args, _resolution) do
    {:ok, Contests.list_contests()}
  end

  defp create_key(filename) do
    ext = Path.extname(filename)

    current_time = DateTime.utc_now()

    (:crypto.hash(
       :md5,
       DateTime.to_string(current_time) <>
         "_" <>
         (filename
          |> Path.basename(ext))
     )
     |> Base.encode16()
     |> String.downcase()) <> ext
  end

  def create_contest(_parent, args, _resolution) do
    bucket = Application.get_env(:aws, :contest_bucket)

    key = create_key(args.contest.image.filename)

    file = File.read!(args.contest.image.path)

    case Aws.put_object(bucket, key, file) do
      {:ok, _, _} ->
        Contests.create_contest(%{
          state: "Pending",
          description: args.contest.description,
          title: args.contest.title,
          start_time: args.contest.start_time,
          image_url: bucket <> "/" <> key
        })

      error ->
        Logger.error("Unable to insert image into bucket: #{inspect(error)}")
        {:error, message: "Unable to create contest"}
    end
  end
end
