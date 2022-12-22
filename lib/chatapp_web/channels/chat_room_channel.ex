defmodule ChatappWeb.ChatRoomChannel do
  use ChatappWeb, :channel

  alias Chatapp.Chat
#The join function is used when a client connects to the "chat_room:lobby" topic. It returns {:ok, socket} to indicate that the client has successfully joined the topic.
  @impl true
  def join("chat_room:lobby", _payload, socket) do
      {:ok, socket}
  end

  #The handle_in function is used when a message with the "pushmessage" event is received from the client.
  # It creates a new message using the Chat.create_message function and broadcasts the message payload to all clients connected to the "chat_room:lobby" topic using the broadcast function.

  @impl true
  def handle_in("pushmessage", payload, socket) do
    Chat.create_message(payload)
    broadcast(socket, "pushmessage", payload)
    #Finally, it returns {:noreply, socket} to indicate that no reply is expected from the server.
    {:noreply, socket}
  end
end
