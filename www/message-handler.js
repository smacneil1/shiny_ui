// This recieves messages of type "testmessage" from the server.
Shiny.addCustomMessageHandler("missingFiles",
  function(message) {
    alert(JSON.stringify(message));
  }
);