<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .frd-list {
            list-style-type: none;
            padding: 0;
            background-color: #A9F5F2;
            padding: 10px;
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
            var friend_num = $(this).siblings(".friend_num").val();

            console.log(friend_num);

            var modal = document.querySelector('.modal');
            modal.style.display = 'block';

            $("#noBtn").click(function () {
                modal.style.display = 'none';
                location.reload();
            })

            $("#yesBtn").click(function () {
                $.ajax({
                    type:"POST",
                    url: "/friend/delFrd",
                    data : {
                        friend_num : friend_num
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

        $(".chatBtn").click(function() {
            var room_name = $(this).siblings(".nickname").val();
            var creator_id = "<%=(String)session.getAttribute("id")%>";
            var invitee_id = $(this).siblings(".invitee_id").val();
            var invitee_nn = $(this).siblings(".nickname").val();

            var modal = document.querySelector('.modal');
            const modalMessage = document.getElementById("modalMessage");

            modal.style.display = 'block';
            modalMessage.textContent = "채팅을 시작하시겠습니까?";

            console.log(creator_id)
            console.log(invitee_id)
            $.ajax({
                type:"POST",
                url: "/room/chkRoom",
                data : {
                    creator_id: creator_id,
                    invitee_id: invitee_id
                },
                success : function (data) {
                    console.log(data)
                    if (data > 0) {
                        const modalMessage = document.getElementById("modalMessage");
                        const yesBtn = document.getElementById("yesBtn");
                        const noBtn = document.getElementById("noBtn");

                        modalMessage.textContent = "이미 생성된 채팅방입니다.";
                        yesBtn.textContent = "확인";
                        noBtn.style.display = "none"
                        modal.style.display = 'block';

                        $("#yesBtn").click(function () {
                            modal.style.display = 'none';
                            location.reload();
                        })
                    } else {
                        $("#noBtn").click(function () {
                            modal.style.display = 'none';
                            location.reload();
                        })

                        $("#yesBtn").click(function () {
                            $.ajax({
                                type:"POST",
                                url: "/room/insertRoom",
                                data : {
                                    room_name: room_name,
                                    creator_id: creator_id,
                                    invitee_id: invitee_id,
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
                    }
                },
                error: function (data) {
                    result:data,
                        alert("실패")
                },
            });
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
<div class="frd-container">
    <div class="frd-sidebar">
        <h3>친구 목록</h3>
        <c:forEach var="friends" items="${friends}">
            <div class="frd-list">
                <p>${none}</p>
                <b style="margin-right: 50px">${friends.your_id}</b>
                <button class="chatBtn">채팅 하기</button>
                <button class="delBtn">친구 삭제</button>
                <p>${friends.nickname}</p>
                <input class="friend_num" value="${friends.friend_num}" type="hidden">
                <input class="nickname" value="${friends.nickname}" type="hidden">
                <input class="invitee_id" value="${friends.your_id}" type="hidden">
            </div>
        </c:forEach>
        <div class="frd-list">
            <p>${none}</p>
        </div>
    </div>
    <div class="modal">
        <div class="modal-content"><br>
            <p id="modalMessage">친구 삭제 하시겠습니까?</p>
            <div class="modal-footer">
                <button id="noBtn">아니오</button>
                <button id="yesBtn">예</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>