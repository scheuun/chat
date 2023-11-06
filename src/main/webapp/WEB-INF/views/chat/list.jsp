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

        .room-list {
            list-style-type: none;
            padding: 0;
            background-color: #A9F5F2;
            padding: 10px;
        }

        .room-list li {
            margin-bottom: 10px;
            color: #fff;
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
<script>
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
<section>
    <label>대화상대 찾기</label>
    <form method="post" action="/member/searchResult">
        <input type="text" name="keyword" placeholder="아이디를 입력하세요">
        <button type="submit">검색</button>
    </form>
</section><br>
<div class="chat-container">
    <div class="chat-sidebar">
        <h3>채팅방 목록</h3>
        <ul class="room-list">
            <li><a href="#">방 1</a></li>
            <li><a href="#">방 2</a></li>
            <li><a href="#">방 3</a></li>
        </ul>
    </div>
</div>
</body>
</html>