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
            var yourNumValue = $(this).siblings(".your_num").val();
            console.log(yourNumValue);

            var modal = document.querySelector('.modal');
            modal.style.display = 'block';

            noBtn.addEventListener('click', closeModal);
            yesBtn.addEventListener('click', insertFrd());

            function closeModal() {
                modal.style.display = 'none';
            }

            function insertFrd() {
                $.ajax({
                    type:"POST",
                    url: "/friend/insertFrd",
                    data : {
                        your_num : $('#your_num').val()
                    },
                    success : function (data) {
                        result:data;
                        alert("성공")
                    },
                    error: function (data) {
                        result:data,
                            alert("실패")
                    },
                });
            }

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
            <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/chat/list'>채팅 목록</a>
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
                <button class="frdBtn">친구 추가</button>
                <p>${result.nickname}</p>
                <input class="your_num" value="${result.member_num}">
            </div>
        </c:forEach>
        <div class="resultList">
            <p>${none}</p>
        </div>
    </div>
    <div class="modal">
        <div class="modal-content"><br>
            <p>친구 추가 하시겠습니까?</p>
            <div class="modal-footer">
                <button id="noBtn">아니오</button>
                <button id="yesBtn">예</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>