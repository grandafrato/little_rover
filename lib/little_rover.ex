defmodule LittleRover do
  @compile {:no_warn_undefined, [:network]}

  @ssid Application.compile_env!(:little_rover, :ssid)
  @psk Application.compile_env!(:little_rover, :psk)

  def start() do
    {:ok, server_pid} = LittleRover.Server.start()

    network_config = [
      sta: [
        ssid: @ssid,
        psk: @psk,
        connected: fn -> send(server_pid, :connected) end,
        got_ip: fn ip_info -> send(server_pid, {:got_ip, ip_info}) end,
        disconnected: fn -> send(server_pid, :disconnected) end
      ]
    ]

    case :network.start(network_config) do
      :ok ->
        Process.sleep(:infinity)

      error ->
        :erlang.display(error)
    end
  end
end
