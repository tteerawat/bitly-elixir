defmodule Bitly.ClientTest do
  use ExUnit.Case

  alias Bitly.Client

  describe "new/1" do
    test "sets headers correctly" do
      client = Client.new()

      {_, _, [headers]} =
        Enum.find(client.pre, fn {middleware, _, _} -> middleware == Tesla.Middleware.Headers end)

      assert headers == %{"User-Agent" => "Bitly-Elixir"}
    end

    test "sets base_url correctly" do
      client = Client.new()

      {_, _, [base_url]} =
        Enum.find(client.pre, fn {middleware, _, _} -> middleware == Tesla.Middleware.BaseUrl end)

      assert base_url == "https://api-ssl.bitly.com/v3"
    end

    test "sets default query correctly" do
      client = Client.new(access_token: "abc")

      {_, _, [[access_token: access_token]]} =
        Enum.find(client.pre, fn {middleware, _, _} -> middleware == Tesla.Middleware.Query end)

      assert access_token == "abc"
    end
  end
end
