defmodule Bitly.LinkTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  alias Bitly.{Client, Link}

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/link")

    :ok
  end

  ## Expand

  describe "expand/1" do
    test "expands short url" do
      use_cassette "expand" do
        assert Link.expand("http://bit.ly/ze6poY") ==
                 %Link{
                   data: %{
                     expand: [
                       %{
                         global_hash: "900913",
                         long_url: "http://google.com/",
                         short_url: "http://bit.ly/ze6poY",
                         user_hash: "ze6poY"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  describe "expand/2" do
    test "expands short url with options" do
      use_cassette "expand_with_options" do
        options = [format: "txt"]

        assert Link.expand("http://bit.ly/ze6poY", options) == "http://google.com/\n"
      end
    end
  end

  describe "expand/3" do
    test "expands short url with custom client" do
      use_cassette "expand_with_custom_client" do
        access_token = Application.get_env(:bitly, :access_token)
        client = Client.new(access_token: access_token)

        assert Link.expand("http://bit.ly/ze6poY", [], client) ==
                 %Link{
                   data: %{
                     expand: [
                       %{
                         global_hash: "900913",
                         long_url: "http://google.com/",
                         short_url: "http://bit.ly/ze6poY",
                         user_hash: "ze6poY"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  ## Info

  describe "info/1" do
    test "gets info of short url" do
      use_cassette "info" do
        assert Link.info("http://bit.ly/ze6poY") ==
                 %Link{
                   data: %{
                     info: [
                       %{
                         created_at: 1_331_569_103,
                         global_hash: "900913",
                         short_url: "http://bit.ly/ze6poY",
                         title: "Google",
                         user_hash: "ze6poY"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  describe "info/2" do
    test "gets info of short url with options" do
      use_cassette "info_with_options" do
        options = [hash: "2bYgqR"]

        assert Link.info("http://bit.ly/ze6poY", options) ==
                 %Link{
                   data: %{
                     info: [
                       %{
                         created_at: 1_212_926_400,
                         global_hash: "2bYgqR",
                         hash: "2bYgqR",
                         title: "CNN - Breaking News, Latest News and Videos",
                         user_hash: "2bYgqR"
                       },
                       %{
                         created_at: 1_331_569_103,
                         global_hash: "900913",
                         short_url: "http://bit.ly/ze6poY",
                         title: "Google",
                         user_hash: "ze6poY"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  describe "info/3" do
    test "gets info of short url with custom client" do
      use_cassette "info_with_custom_client" do
        access_token = Application.get_env(:bitly, :access_token)
        client = Client.new(access_token: access_token)

        assert Link.info("http://bit.ly/ze6poY", [format: "json"], client) ==
                 %Link{
                   data: %{
                     info: [
                       %{
                         created_at: 1_331_569_103,
                         global_hash: "900913",
                         short_url: "http://bit.ly/ze6poY",
                         title: "Google",
                         user_hash: "ze6poY"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  ## lookup

  describe "lookup/1" do
    test "gets bitly url with long url" do
      use_cassette "lookup" do
        assert Link.lookup("http://www.google.com/") ==
                 %Link{
                   data: %{
                     link_lookup: [
                       %{
                         aggregate_link: "http://bit.ly/2V6CFi",
                         url: "http://www.google.com/"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  describe "lookup/2" do
    test "gets bitly url with long url and custom client" do
      use_cassette "lookup_with_custom_client" do
        access_token = Application.get_env(:bitly, :access_token)
        client = Client.new(access_token: access_token)

        assert Link.lookup("http://www.google.com/", client) ==
                 %Link{
                   data: %{
                     link_lookup: [
                       %{
                         aggregate_link: "http://bit.ly/2V6CFi",
                         url: "http://www.google.com/"
                       }
                     ]
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  ## Shorten

  describe "shorten/1" do
    test "shortens long url" do
      use_cassette "shorten" do
        assert Link.shorten("http://google.com/") ==
                 %Link{
                   data: %{
                     global_hash: "3j4ir4",
                     hash: "2iHe1Wi",
                     long_url: "http://google.com/",
                     new_hash: 0,
                     url: "http://bit.ly/2iHe1Wi"
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end

  describe "shorten/2" do
    test "shortens long url with options" do
      use_cassette "shorten_with_options" do
        options = [format: "txt", domain: "j.mp"]

        assert Link.shorten("http://google.com/", options) == "http://j.mp/2iHe1Wi\n"
      end
    end
  end

  describe "shorten/3" do
    test "shortens long url with custom client" do
      use_cassette "shorten_with_custom client" do
        access_token = Application.get_env(:bitly, :access_token)
        client = Client.new(access_token: access_token)

        assert Link.shorten("http://google.com/", [], client) ==
                 %Link{
                   data: %{
                     global_hash: "3j4ir4",
                     hash: "2iHe1Wi",
                     long_url: "http://google.com/",
                     new_hash: 0,
                     url: "http://bit.ly/2iHe1Wi"
                   },
                   status_code: 200,
                   status_txt: "OK"
                 }
      end
    end
  end
end
