ExUnit.start()

{:ok, _} = Application.ensure_all_started(:inets)
ExVCR.Config.filter_sensitive_data("access_token=[^\&]+", "access_token=ACCESS_TOKEN")
