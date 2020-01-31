<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Testing WebSocket</title>
</head>
<body>
    <fieldset>
        <textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
        <br/>
        <input id="inputMessage" type="text"/>
        <input type="submit" value="send" onclick="send()" />
    </fieldset>
</body>
    <script type="text/javascript">
        var textarea = document.getElementById("messageWindow");
        var webSocket = new WebSocket('ws://localhost:8080/CatchMind/broadcasting');
        var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
      onError(event)
    };

    webSocket.onopen = function(event) {
      onOpen(event)
    };

    webSocket.onmessage = function(event) {
      onMessage(event)
    };

    function onMessage(event) {
        textarea.value += "opponent : " + event.data + "\n";
    }

    function onOpen(event) {
        textarea.value += "connect success!\n";
    }

    function onError(event) {
      alert(event.data);
    }

    function send() {
        textarea.value += "Me : " + inputMessage.value + "\n";
        webSocket.send(inputMessage.value);
        inputMessage.value = ""; // ºñ¿öÁà¶ó 
    }
  </script>
</html>