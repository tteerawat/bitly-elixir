defmodule Bitly.Client do
  @moduledoc false

  use Tesla

  @type t :: Tesla.Client.t()

  @default_base_url "https://api-ssl.bitly.com/v3"

  @spec new(keyword) :: Tesla.Client.t()
  def new(attrs \\ []) do
    base_url = attrs[:base_url] || @default_base_url
    access_token = attrs[:access_token] || Application.get_env(:bitly, :access_token)

    Tesla.build_client([
      {Tesla.Middleware.Headers, %{"User-Agent" => "Bitly-Elixir"}},
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.Query, [access_token: access_token]}
    ])
  end
end
