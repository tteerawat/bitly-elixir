# Bitly

[![Build Status](https://travis-ci.org/teerawat1992/bitly-elixir.svg?branch=master)](https://travis-ci.org/teerawat1992/bitly-elixir)
[![Hex.pm](https://img.shields.io/hexpm/v/bitly.svg?style=flat-square)](https://hex.pm/packages/bitly)
[![Coverage Status](https://coveralls.io/repos/github/teerawat1992/bitly-elixir/badge.svg)](https://coveralls.io/github/teerawat1992/bitly-elixir)

**An Elixir API for [bitly](http://bitly.com).**

## Installation

Add `bitly` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bitly, "~> 0.1"}
  ]
end
```

## Configuration

You can optionally set `access_token` value in your `config/config.exs` file:

```elixir
config :bitly, access_token: "ACCESS_TOKEN"
```

This will be used as a default `access_token` when making an API call to bitly.

## Examples

- Getting info with default client:

```elixir
iex(1)> Bitly.Link.shorten("http://google.com/")
```

- Getting info with defined client:

```elixir
iex(1)> client = Bitly.Client.new(access_token: "ACCESS_TOKEN")
iex(2)> Bitly.Link.shorten("http://google.com/", [], client)
```
