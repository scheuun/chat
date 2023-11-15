<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LIST</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #04B4AE;
            padding: 20px;
            text-align: center;
        }

        .room-list {
            list-style-type: none;
            padding: 0;
            background-color: #A9F5F2;
            padding: 10px;
        }

        .room-list b {
            margin-bottom: 10px;
            color: #000000;
        }

        .modal {
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            display: none;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
<script>
    $(document).ready(function() {
        $(".delBtn").click(function() {
            var room_num = $(this).siblings(".room_num").val();

            console.log(room_num);

            var modal = document.querySelector('.modal');
            modal.style.display = 'block';

            $("#noBtn").click(function () {
                modal.style.display = 'none';
                location.reload();
            })

            $("#yesBtn").click(function () {
                $.ajax({
                    type:"POST",
                    url: "/room/delRoom",
                    data : {
                        room_num : room_num
                    },
                    success : function () {
                        modal.style.display = 'none';
                        location.reload();
                    },
                    error: function (data) {
                        result:data,
                            alert("실패")
                    },
                });
            })
        });
    });
</script>
<body>
<header>
    <h1>주거니받거니</h1>
</header>
<c:if test="${not empty sessionScope.id}">
    <div style="text-align: right">
        <h5>${id}님 <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/member/logout'>로그아웃</a>
        <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/room/list'>채팅 목록</a>
        <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/friend/frdList'>친구 목록</a>
        <a style='color:black' href = '<%=request.getContextPath() %>/member/myPage'>마이페이지</a></h5>
    </div>
</c:if>
<section>
    <label>채팅상대 찾기</label>
    <form method="post" action="/member/searchResult">
        <input type="text" name="keyword" placeholder="아이디를 입력하세요">
        <button type="submit">검색</button>
    </form>
</section><br>
<div class="room-container">
    <div class="room-sidebar">
        <h3>채팅방 목록</h3>
        <c:forEach var="rooms" items="${rooms}">
            <div class="room-list">
                <p>${none}</p>
                <a href="/chat/chat?room_num=${rooms.room_num}"><b style="margin-right: 50px">${rooms.room_name}</b></a>
                <button class="delBtn">채팅방 삭제</button>
                <input class="room_num" value="${rooms.room_num}" type="hidden">
            </div>
        </c:forEach>
        <div class="room-list">
            <p>${none}</p>
        </div>
    </div>
</div>
<div class="modal">
    <div class="modal-content"><br>
        <p id="modalMessage">채팅방 삭제 하시겠습니까?</p>
        <div class="modal-footer">
            <button id="noBtn">아니오</button>
            <button id="yesBtn">예</button>
        </div>
    </div>
</div>
</body>
</html>