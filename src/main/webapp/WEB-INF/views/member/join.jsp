<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>JOIN</title>
    <style>
        header {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
        }
    </style>
    <script>
        function join (){

            $('#id').blur(function () {
                console.log($('#id').val())
                $.ajax({
                    type:"POST",
                    url:"/idCheck",
                    data:{
                        id: $('#id').val()
                    },
                    success:function(cnt){
                        if(document.getElementById('id').value== "") {
                            $('.idMsg').css("display","block");
                        }else {
                            if(cnt==0){
                                $('.idMsg').text("사용 가능한 아이디 입니다.");
                                $('.idMsg').css("display","block");
                            }else{
                                $('.idMsg').text("이미 사용중인 아이디 입니다.");
                                $('.idMsg').css("display","block");
                            }
                        }
                    },
                    error: function (data) {
                        result:data
                        alert("회원가입 에러");

                    },
                });
            });

            $('#pwd').blur(function (){
                var pwd = document.getElementById('pwd').value;

                if(pwd== "" || pwd.length == 0) {
                    $('.pwdMsg').css("display", "block");
                } else {
                    if(pwd.length < 6 || pwd.length > 12) {
                        $('.pwdMsg').text("비밀번호는 6글자 이상, 12글자 이하만 이용 가능합니다.");
                        $('.pwdMsg').css("display", "block");
                    } else {
                        $('.pwdMsg').css("display", "none");
                    }
                }
            });

            $('#pwdChk').blur(function (){
                var pwd = document.getElementById('pwd').value;
                var pwdChk = document.getElementById('pwdChk').value;


                if(pwdChk== "") {
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

            $('#email').blur(function (){
                if(document.getElementById('email').value== "") {
                    $('.emailMsg').css("display", "block");

                }
            });

            $('#country').blur(function (){
                if(document.getElementById('country').value== "") {
                    $('.countryMsg').css("display", "block");

                }
            });

            $('#joinBtn').click(function (){
                var id = $('#id').val();
                var pwd = $('#pwd').val();
                var email = $('#email').val();
                var lang = $('#lang').val();


                if(id.length == 0 || pwd.length == 0 || email.length == 0 || lang.length == 0) {
                    $('.idMsg').css("display","block");
                    $('.pwdMsg').css("display", "block");
                    $('.pwdChkMsg').css("display", "block");
                    $('.emailMsg').css("display", "block");
                } else {
                    $.ajax({
                        type:"POST",
                        url: "/join",
                        dataType:"json",
                        data: {id: id,
                            pwd: pwd,
                            email: email},
                        success : function (data) {
                            result:data,
                                document.getElementById("view1").style.display = "none";
                            document.getElementById("view2").style.display = "block";
                        },
                        error: function (data) {
                            result:data
                            alert("회원가입 실패");

                        },
                    });
                }
            });

        };
        $(join)
    </script>
</head>
<body>
<header>
    <h1>깨깨오똑</h1>
</header>
<div style="text-align: right">
    <a style='color:black' href = '<%=request.getContextPath() %>/'>메인</a>
</div>
<h4 style='text-align:center;'><b>회원가입</b></h4><hr><br>
<div class='row'>
    <div class='col' id='view1' style='text-align:center;'>
        <label>아이디&emsp;</label><br>
        <input type='text' id='id' name='id'/><br>
        <span class="idMsg" style ="color:red;display:none;">필수 정보입니다.</span>
        <label>비밀번호</label><br>
        <input type='password' id='pwd' name='pwd'/><br>
        <span class="pwdMsg" style ="color:red;display:none;">필수 정보입니다.</span>
        <label>비밀번호 확인</label><br>
        <input type='password' id='pwdChk' name='pwdChk'/><br>
        <span class="pwdChkMsg" style ="color:red;display:none;">필수 정보입니다.</span>
        <label>이메일</label><br>
        <input type='text' id='email' name='email'/>
        <span class="emailMsg" style ="color:red;display:none;">필수 정보입니다.</span><br>
        <label>언어</label><br>
        <select name="lang" id="lang">
            <option value=""></option>
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
        <span class="langMsg" style ="color:red;display:none;">필수 정보입니다.</span><br><br><br>
        <div  style="display: flex; justify-content: center;">
            <button type='button' class='btn btn-secondary btn-block'
                    id='joinBtn' style="width:120">회원가입</button>
        </div>
    </div>
    <div class='col' id='view2'  style ="display:none;text-align:center" >
        <h6>회원가입 완료</h6><br><br><br>
        <div  style="display: flex; justify-content: center;">
            <button type='button' class='btn btn-secondary btn-block'
                    id='mainBtn' style="width: 120" onclick="location.href='/'">메인으로</button>
        </div>
    </div>
</div>
</body>
</html>