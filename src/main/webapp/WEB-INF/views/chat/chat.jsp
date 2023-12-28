<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            /*background-color: #007bff;*/
            color: #fff;
            border-radius: 5px;
            padding: 10px;
            margin: 10px 0;
        }

        .input-container {
            display: flex;
        }

        .message {
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
            var message = JSON.parse(event.data);
            console.log("Parsed message: ", message);

            // 이제 message 객체를 사용하여 메시지를 처리할 수 있습니다.
            var type = message.type;
            var message = message.message;

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
        let message = document.querySelector('.message').value;
        console.log("message: " + message);
        socket.send(JSON.stringify({ room_num: room_num, type: "SEND", message: message}));

        $.ajax({
            type: "POST",
            url: "/chat/insertMsg",
            data: {
                room_num: room_num,
                sender_id: '<%= (String)session.getAttribute("id") %>',
                message: message,
            },
            success: function (data) {
                console.log("성공:", data);
            },
            error: function (xhr, status, error) {
                console.log("실패:", xhr.responseText); // 실제 서버 응답 내용을 확인
                alert("실패: " + error);
            },
        })

        document.getElementById('msg').value = '';
    };

</script>
<body>
<p class="container">
<%--    <div class="msgArea"></div>--%>
    <c:forEach var="messages" items="${messages}">
        <c:if test="${messages.sender_id eq sessionScope.id}">
            <div class="msgArea" style="background-color: #007bff">${messages.message}<div style="font-size: 10px">${messages.time}</div></div>
        </c:if>
        <c:if test="${messages.sender_id ne sessionScope.id}">
            <div class="msgArea" style="background-color: darkolivegreen">${messages.message}<div style="font-size: 10px">${messages.time}</div></div>
        </c:if>
    </c:forEach>
    <div class="input-container">
        <input id="msg" type="text" placeholder="메세지를 입력하세요" class="message">
        <button type="button" class="sendBtn" onclick="sendMsg()">전송</button>
    </div>
</div>
</body>
</html>