<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
<title>MYPAGE</title>
<script>
</script>
<style>
    header {
        background-color: #04B4AE;
        padding: 20px;
        text-align: center;
    }

    nav {
        height: 75px;
        padding: 1rem;
        color: white;
        background: #EBFBFF;
        display: flex;
        flex-flow: row nowrap;
        justify-content: space-between;
        align-items: center;
    }
</style>
</head>
<body>
<header>
    <h1>깨깨오똑</h1>
</header>
<div style="text-align: right">
    <a style='color:black' href = '<%=request.getContextPath() %>/'>메인</a>
</div>
<h4 style='text-align:center;'><b>마이페이지</b></h4><hr><br>
<c:if test="${not empty sessionScope.id}">
    <div style="text-align: right">
        <h5>${id}님 <a style='color:black' href = '<%=request.getContextPath() %>/member/logout'>로그아웃</a></h5>
    </div>
</c:if>
<div class='row'>
    <table id="view1" class="table table-striped table-bordered base-style" style="text-align:center;">
        <thead>
            <tr>
                <th style="width: 300px; vertical-align: middle;">아이디</th>
                <th> <input type='text' id='id' name='id' class="form-control" value="${member.id}" readonly/></th>
            </tr>
                <th style="width: 300px; vertical-align: middle;">이메일</th>
                <th><input type="text" id="email" name="email" class="form-control" value="${member.email}" readonly></th>
            </tr>
        </thead>
    </table>
</div>
</body>
</html>