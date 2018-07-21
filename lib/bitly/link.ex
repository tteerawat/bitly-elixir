defmodule Bitly.Link do
  @moduledoc """
  Bitly Links API

  <https://dev.bitly.com/links.html>
  """

  alias Bitly.Client

  defstruct [:data, :status_code, :status_txt]

  @type t :: %__MODULE__{
          data: map | list,
          status_code: integer,
          status_txt: String.t()
        }

  @doc """
  Given a bitly URL or hash (or multiple), returns the target (long) URL.

  ## Example

      Bitly.Client.expand("http://bit.ly/ze6poY")

  """
  @spec expand(String.t(), keyword, Client.t()) :: t | String.t()
  def expand(short_url, opts \\ [], client \\ Client.new()) do
    get_response_body(client, "/expand", Keyword.merge([shortUrl: short_url], opts))
  end

  @doc """
  This is used to return the page title for a given Bitlink.

  ## Example

      Bitly.Link.info("http://bit.ly/ze6poY")

  """
  @spec info(String.t(), keyword, Client.t()) :: t
  def info(short_url, opts \\ [], client \\ Client.new()) do
    get_response_body(client, "/info", Keyword.merge([shortUrl: short_url], opts))
  end

  @doc """
  This is used to query for a Bitlink based on a long URL.

  ## Example

      Bitly.Link.lookup("http://www.google.com/")

  """
  @spec lookup(String.t(), Client.t()) :: t
  def lookup(url, client \\ Client.new()) do
    get_response_body(client, "/link/lookup", url: url)
  end

  @doc """
  Given a long URL, returns a Bitlink.

  ## Example

      Bitly.Link.shorten("http://google.com/")

  """
  @spec shorten(String.t(), keyword, Client.t()) :: t | String.t()
  def shorten(long_url, opts \\ [], client \\ Client.new()) do
    get_response_body(client, "/shorten", Keyword.merge([longUrl: long_url], opts))
  end

  defp get_response_body(client, path, query) do
    client
    |> Client.get!(path, query: query)
    |> handle_response_body()
  end

  defp handle_response_body(%{body: body}) do
    case Poison.decode(body, as: %__MODULE__{}) do
      {:ok, result} -> result
      {:error, _} -> body
    end
  end
end
