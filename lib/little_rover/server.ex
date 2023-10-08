defmodule LittleRover.Server do
  @moduledoc """
  An http server that returns html.
  """
  @compile {:no_warn_undefined, [:http_server]}

  def start() do
    pid = spawn(&server_wait_for_connection_loop/0)
    {:ok, pid}
  end

  defp server_wait_for_connection_loop() do
    router = [{"*", __MODULE__, []}]

    receive do
      :connected ->
        :erlang.display(:connected)

      {:ok, ip_info} ->
        :erlang.display(ip_info)
        :http_server.start_server(8080, router)

      :diconnected ->
        :erlang.display(:disconnected)
    after
      15000 -> :ok
    end

    server_wait_for_connection_loop()
  end

  def handle_req(method, path, conn) do
    :erlang.display(conn)
    :erlang.display({method, path})

    body = """
    <!DOCTYPE html>
    <html>
      <body>
        <h1>Not Found</h1>
      </body>
    </html>
    """

    :http_server.reply(200, body, conn)
  end
end
