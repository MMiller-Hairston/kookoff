defmodule KookoffWeb.Aws do
  require Logger

  defp client do
    access_key = Application.get_env(:aws, :access_key)
    secret_key = Application.get_env(:aws, :secret_key)
    region = Application.get_env(:aws, :region)

    %AWS.Client{
      access_key_id: access_key,
      secret_access_key: secret_key,
      region: region,
      endpoint: "localhost",
      proto: "http",
      port: 4566
    }
  end

  def put_object(bucket, key, file) do
    AWS.S3.put_object(client(), bucket, key, %{"Body" => file})
  end

  def get_object(bucket, key) do
    AWS.S3.get_object(client(), bucket, key)
  end
end
