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
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
<script>

</script>
<body>
<header>
    <h1>깨깨오똑</h1>
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
        <div class="resultList">
            <p>${none}</p>
        <c:forEach var="result" items="${result}">
            <b style="margin-right: 50px">${result.id}</b><button id="frdBtn">친구 추가</button><button id="chatBtn">대화하기</button>
            <p>${result.nickname}</p>
        </c:forEach>
        </div>
    </div>
</div>
</body>
</html>