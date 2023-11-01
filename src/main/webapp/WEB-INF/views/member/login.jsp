<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>LOGIN</title>
</head>
<style>
    header {
        background-color: #04B4AE;
        padding: 20px;
        text-align: center;
    }
</style>
<script>
    $('#id').blur(
        function (){
            var id = document.getElementById('id').value;

            if(id== "" || id.length == 0) {
                $('.idMsg').css("display", "block");
            } else {

                $('.idMsg').css("display", "none");
            }
        });

    $('#pwd').blur(
        function (){
            var pwd = document.getElementById('pwd').value;

            if(pwd== "" || pwd.length == 0) {
                $('.pwdMsg').css("display", "block");
            } else {
                $('.pwdMsg').css("display", "none");
            }
        });
</script>
<body>
<header>
    <h1>깨깨오똑</h1>
</header><br>
<h4 style='text-align:center;'><b>로그인</b></h4><hr><br>
<div class='row'>
    <div class='col' style='text-align:center;'>
    <form method="post">
        <label>아이디&emsp;</label>
        <input type='text' id='id' name='id' value=${id}><br>
        <span class="idMsg" style ="color:red;display:none;">아이디를 입력해 주세요.</span>
        <label>비밀번호</label>
        <input type='password' id='pwd' name='pwd'/><br>
        <span class="pwdMsg" style ="color:red;display:none;">비밀번호를 입력해 주세요.</span><br>
        <span class="msg" style ="color:red;display:block;">${msg}</span><br>
        <div  style="display: flex; justify-content: center;">
              <button type='submit' class='btn btn-secondary btn-block'
                        id='loginBtn' style="width:120">로그인</button>
        </div><br>
        <input id="rememberId" name="rememberId" type="checkbox"/> 아이디저장
    </form>
    </div>
</div>
<div class='row'>
    <div class='col' style='text-align:center;'>
        <a style='color:black' href = '<%=request.getContextPath() %>/member/findId'>아이디 찾기&emsp;</a>
        <a style='color:black' href = '<%=request.getContextPath() %>/member/findPwd'>비밀번호 찾기&emsp;</a>
        <a style='color:black' href = '<%=request.getContextPath() %>/member/join'>회원 가입 </a>
    </div>
</div>
</body>
</html>