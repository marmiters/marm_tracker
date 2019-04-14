defmodule MarmTrackerWeb.IndexController do
  use MarmTrackerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
