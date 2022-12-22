#This code defines a module Chatapp.Chat.Message which represents a message in a chat application. It uses the Ecto.Schema module to define a database schema for the messages table, with fields for the body and name of the message, as well as timestamps for when the message was created and last updated.
defmodule Chatapp.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :name, :string
    timestamps()
  end

  #This function is used to track changes to a message. It takes a message and a set of attributes (attrs) as inputs and can be used to update or delete the message in the database
  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
