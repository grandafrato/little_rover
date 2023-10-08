import Config

config :little_rover,
  ssid: System.get_env("WIFI_SSID", ""),
  psk: System.get_env("WIFI_PSK", "")
