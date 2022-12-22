#a module in the Phoenix web framework that defines a controller and its associated actions. Controllers are responsible for handling HTTP requests and returning responses to the client.
defmodule ChatappWeb.PageController do
  use ChatappWeb, :controller
  alias Chatapp.Chat
  #The action fetches a list of messages from the Chatapp.Chat module using the list_messages/0 function. It then renders the index.html template and passes the list of messages as the messages parameter.
  #The rendered template and the data will be returned as the HTTP response to the client.
  def index(conn, _params) do
    messages = Chat.list_messages
    render(conn, "index.html", messages: messages)
  end
end
