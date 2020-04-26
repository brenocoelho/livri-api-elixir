defmodule LivriApp.Users.AuthErrorHandler do
    import Plug.Conn
  
    @behaviour Guardian.Plug.ErrorHandler
  
    @impl Guardian.Plug.ErrorHandler
    def auth_error(conn, {type, _reason}, _opts) do
      body = Jason.encode!(%{error: to_string(type)})
      conn
      |> send_resp(401, body)
    end
end