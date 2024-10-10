defmodule KookoffWeb.Resolvers.Contest do
  require Logger

  alias KookoffWeb.Aws
  alias Kookoff.Contests

  def list_contests(_parent, _args, _resolution) do
    {:ok, Contests.list_contests()}
  end

  def create_contest(_parent, args, _resolution) do
    bucket = Application.get_env(:aws, :contest_bucket)
    ext = Path.extname(args.contest.image.filename)

    key =
      (:crypto.hash(
         :md5,
         args.contest.image.filename
         |> Path.basename(ext)
       )
       |> Base.encode16()
       |> String.downcase()) <> ext

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
        error
    end
  end
end
