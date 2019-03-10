defmodule MarmTrackerWeb.Router do
  use MarmTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarmTrackerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/player", PlayerController, :index
    get "/update", PlayerController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", MarmTrackerWeb do
  #   pipe_through :api
  # end
end
