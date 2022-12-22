//We define our ChatRoom object that is used to set up a chat room in a web app using the phoenix framework
let ChatRoom = {
  //Init method is called when the chat room is first set up. It takes a socket object as argument
    init(socket) {
    //create a channel with the chat_room:lobby toppic
      let channel = socket.channel('chat_room:lobby', {})
      //join the channel
      channel.join()
      //After that we have to listen for events on that channel.
      this.listenForMessages(channel)
    },
  
    //Method used to listen for messages on the channel and handel them.
    listenForMessages(channel) {
        //We acces the chatform by id and add an eventlistener on the submit button
      document.getElementById('chat-form').addEventListener('submit', function(e){
        //When the form is submittet we prevent any further action
        e.preventDefault()
        //getting username and message inserted in the form
        let userName = document.getElementById('user-name').value
        let userMsg = document.getElementById('user-msg').value

        //Then we want to push with the pushmessage string and a payload consisting of the inserted username and message
        //This will send it to the server and picked up by the chat_room channel
        channel.push('pushmessage', {name: userName, body: userMsg})
  
   
        //Then we're resetting the fields in the form
        // Switch this on to not store username anymore document.getElementById('user-name').value = ''
        document.getElementById('user-msg').value = ''
      })
      //If we send events we also have to be able to receive them.
      //Subscribe channel events matchin on "pushmessage"
      channel.on('pushmessage', payload => {
        //Select the div element of the html file with the id chat-box. It is connected to a part of the css file
        let chatBox = document.querySelector('#chat-box')
        //Then we create our message block
        let msgBlock = document.createElement('p')
  
        //Then we build up our message with the name and body which is in the payload. 
        //the method inserst HTML code into a specific position and we define the position with beforeend
        msgBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)
        //we then append the message to the chatbox
        chatBox.appendChild(msgBlock)
        //this one here is needed so that the most recent message is shown when a new one was sent:
	      var textarea = document.getElementById('chat-box');
	      textarea.scrollTop = textarea.scrollHeight;
      })
    }
  }
  
   
  
  export default ChatRoom