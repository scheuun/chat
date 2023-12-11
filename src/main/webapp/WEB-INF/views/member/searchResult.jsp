<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SEARCHRESULT</title>
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

        .resultList {
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
        $(".frdBtn").click(function() {
            var my_id = "<%=(String)session.getAttribute("id")%>";
            var your_id = $(this).siblings(".your_id").val();

            console.log(your_id);
            console.log(${dup});

            var modal = document.querySelector('.modal');
            modal.style.display = 'block';

            $.ajax({
                type:"POST",
                url: "/friend/chkFrd",
                data : {
                    my_id : my_id,
                    your_id : your_id
                },
                success : function (data) {
                    modal.style.display = 'none';
                    console.log(data)

                    if (data > 0 || your_id == my_id) {
                        const modalMessage = document.getElementById("modalMessage");
                        const yesBtn = document.getElementById("yesBtn");
                        const noBtn = document.getElementById("noBtn");

                        modalMessage.textContent = "이미 등록된 친구입니다.";
                        yesBtn.textContent = "확인";
                        noBtn.style.display = "none"
                        modal.style.display = 'block';

                        $("#yesBtn").click(function () {
                            modal.style.display = 'none';
                            location.reload();
                        })
                    } else {
                        modal.style.display = 'block';

                        $("#noBtn").click(function () {
                            modal.style.display = 'none';
                            location.reload();
                        })

                        $("#yesBtn").click(function () {
                            $.ajax({
                                type:"POST",
                                url: "/friend/insertFrd",
                                data : {
                                    your_id : your_id
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
<div class="result-container">
    <div class="result-sidebar">
        <h3>검색 결과 목록</h3>
        <c:forEach var="result" items="${result}">
            <div class="resultList">
                <p>${none}</p>
                <b style="margin-right: 50px">${result.id}</b>
                <input class="your_id" value="${result.id}" type="hidden">
                <button class="frdBtn">친구 추가</button>
                <p>${result.nickname}</p>
            </div>
        </c:forEach>
        <div class="resultList">
            <p>${none}</p>
        </div>
    </div>
    <div class="modal">
        <div class="modal-content"><br>
            <p id="modalMessage">친구 추가 하시겠습니까?</p>
            <div class="modal-footer">
                <button id="noBtn">아니오</button>
                <button id="yesBtn">예</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>