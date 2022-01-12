defmodule GotikWeb.PageController do
  use GotikWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
