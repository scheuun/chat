<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>CHAT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .msgArea {
            background-color: #007bff;
            color: #fff;
            border-radius: 5px;
            padding: 10px;
            margin: 10px 0;
        }

        .input-container {
            display: flex;
        }

        .content {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
        }

        .sendBtn {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
<script>
    let socket = new WebSocket("ws://localhost:8080/chat/chat");
    var urlParams = new URLSearchParams(window.location.search);
    var room_num = urlParams.get('room_num');

    console.log(room_num)

    socket.onopen = function () {
        console.log('open server!')
    };

    socket.onerror = function (e){
        console.log(e);
    };

    /*onmessage 함수는 메시지가 오면 자동실행됨*/
    socket.onmessage = function (event) {
        console.log("Received message: " + event.data);

        try {
            var content = JSON.parse(event.data);
            console.log("Parsed message: ", content);

            // 이제 content 객체를 사용하여 메시지를 처리할 수 있습니다.
            var type = content.type;
            var message = content.content;

            if (type === "SEND") {
                console.log("Received SEND type message");
                var msgArea = document.querySelector('.msgArea');
                var newMsg = document.createElement('div');
                newMsg.innerText = message;
                msgArea.appendChild(newMsg);
            }
        } catch (error) {
            console.error("Error parsing message:", error);
        }
    };

    function sendMsg() {
        let content = document.querySelector('.content').value;
        console.log("content: " + content);
        socket.send(JSON.stringify({ room_num: room_num, type: "SEND", content: content}));

        $.ajax({
            type: "POST",
            url: "/chat/insertMsg",
            dataType: "json",
            data: {
                room_num: room_num,
                message: content,
            },
            success: function (data) {
                console.log("성공:", data);
            },
            error: function (data) {
                console.error("실패:", data);
                alert("실패");
            },
        });
    };

</script>
<body>
<div class="container">
    <div class="msgArea"></div>
    <div class="input-container">
        <input id="msg" type="text" placeholder="메세지를 입력하세요" class="content">
        <button type="button" class="sendBtn" onclick="sendMsg()">전송</button>
    </div>
</div>
</body>
</html>