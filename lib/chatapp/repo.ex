#This module is typically used as a way to centralize database interactions in an Elixir application. It uses the Ecto.Repo macro which generates functions and macros for interacting with a database.
defmodule Chatapp.Repo do
  use Ecto.Repo,
    otp_app: :chatapp,
    adapter: Ecto.Adapters.Postgres
end
