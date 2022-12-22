#The router is responsible for defining the routes for the application and mapping them to specific controllers and actions.
defmodule ChatappWeb.Router do
  use ChatappWeb, :router
  #The browser pipeline is used for routes that return HTML content
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ChatappWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
#the api pipeline is used for routes that return JSON data.
  pipeline :api do
    plug :accepts, ["json"]
  end

  #The scope block defines a scope for the router, with a path prefix of "/" and a pipe through the :browser pipeline.
  #Within this scope, there is a single route defined, a GET request to the root path ("/") is mapped to the index action in the PageController
  scope "/", ChatappWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatappWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).

  #There are also a few additional routes defined that are conditionally included based on the current environment (development or testing).
  #live dashboard for monitoring the application
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ChatappWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.

  #mailbox preview for previewing emails sent through the application.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
