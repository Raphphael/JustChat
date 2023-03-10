defmodule Chatapp.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chatapp.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        name: "some name"
      })
      |> Chatapp.Chat.create_message()

    message
  end
end
