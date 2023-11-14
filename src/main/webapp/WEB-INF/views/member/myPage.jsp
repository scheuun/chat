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
    function modify () {
        $('#pwd').blur(function (){
            var pwd = document.getElementById('pwd').value;
            pwd== "" || pwd.length == 0 ? $('.pwdMsg').css("display", "block") : $('.pwdMsg').css("display", "none")
        });

        $('#pwdChk').blur(function (){
            var pwd = document.getElementById('pwd').value;
            var pwdChk = document.getElementById('pwdChk').value;

            if(pwdChk == "") {
                $('.pwdChkMsg').css("display", "block");
            } else {
                if( pwd != pwdChk ) {
                    $('.pwdChkMsg').text("비밀번호가 일치하지 않습니다.");
                    $('.pwdChkMsg').css("display", "block");
                } else{
                    $('.pwdChkMsg').text("비밀번호가 일치합니다.");
                    $('.pwdChkMsg').css("display", "block");
                }
            }
        });

        $('#modBtn').click(function (){
            var pwd = document.getElementById('pwd').value;
            var pwdChk = document.getElementById('pwdChk').value;

            if(pwd == "" || pwdChk == "") {
                $('.pwdMsg').css("display", "block");
                $('.pwdChkMsg').css("display", "block");
            } else {
                if( pwd != pwdChk ) {
                    $('.pwdChkMsg').text("비밀번호가 일치하지 않습니다.");
                    $('.pwdChkMsg').css("display", "block");
                } else{
                    var id  = $('#id').val();
                    var pwd  = $('#pwd').val();
                    var nickname  = $('#nickname').val();
                    var email  = $('#email').val();
                    var language  = $('#language').val();

                    $.ajax({
                        type:"POST",
                        url: "/updateMem",
                        data : {
                            id : id,
                            pwd : pwd,
                            nickname : nickname,
                            email : email,
                            language : language,
                        },
                        success : function () {
                            location.href="<%=request.getContextPath() %>/room/list";
                        },
                        error: function () {
                                alert("실패")
                        },
                    });
                }
            }


        });
    }

    $(modify)
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
    <h1>주거니받거니</h1>
</header><br>
<h4 style='text-align:center;'><b>마이페이지</b></h4><hr>
<c:if test="${not empty sessionScope.id}">
    <div style="text-align: right">
        <h5>${id}님 <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/member/logout'>로그아웃</a>
        <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/room/list'>채팅 목록</a>
        <a style='color:black; margin-right: 10px' href = '<%=request.getContextPath() %>/friend/frdList'>친구 목록</a>
        <a style='color:black' href = '<%=request.getContextPath() %>/member/myPage'>마이페이지</a></h5>
    </div>
</c:if>
<div class='row'>
    <table id="view1" class="table table-striped table-bordered base-style" style="text-align:center;">
        <thead>
            <tr>
                <th style="width: 300px; vertical-align: middle;">아이디</th>
                <th> <input type='text' id='id' name='id' class="form-control" value="${member.id}" readonly/></th>
            </tr>
            <tr>
                <th style="width: 300px; vertical-align: middle;">닉네임</th>
                <th><input type="text" id="nickname" name="nickname" class="form-control" value="${member.nickname}"></th>
            </tr>
            <tr>
                <th style="width: 300px; vertical-align: middle;">비밀번호</th>
                <th><input type="password" id="pwd" name="pwd" class="form-control">
                    <span class="pwdMsg" style ="color: red; display: none">필수 정보입니다.</span></th>

            </tr>
            <tr>
                <th style="width: 300px; vertical-align: middle;">비밀번호 확인</th>
                <th><input type="password" id="pwdChk" name="pwdChk" class="form-control">
                    <span class="pwdChkMsg" style ="color: red; display: none">필수 정보입니다.</span</th>
            </tr>
            <tr>
                <th style="width: 300px; vertical-align: middle;">이메일</th>
                <th><input type="text" id="email" name="email" class="form-control" value="${member.email}"></th>
            </tr>
            <tr>
                <th>언어</th>
                <th>
                    <select name="language" id="language">
                        <option value="ko">한국어</option>
                        <option value="en">English</option>
                        <option value="ja">日本語</option>
                        <option value="zh-CN">简体中文</option>
                        <option value="zh-TW">繁體中文</option>
                        <option value="es">Español</option>
                        <option value="fr">Français</option>
                        <option value="de">Deutsch</option>
                        <option value="it">Italiano</option>
                        <option value="pt">Português</option>
                        <option value="ru">Русский</option>
                    </select>
                </th>
            </tr>
        <tr>
            <th colspan="2">
                <button type='button' class='btn btn-secondary btn-block'
                        id='modBtn' style="width:120; margin-left: 50%">수정</button>
            </th>
        </tr>
        </thead>
    </table>
</div>
</body>
</html>