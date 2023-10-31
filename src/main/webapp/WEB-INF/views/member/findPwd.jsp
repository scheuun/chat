<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>FINDPWD</title>
    <style>
        header {
            background-color: #04B4AE;
            padding: 20px;
            text-align: center;
        }
    </style>
    <script>
        $(document).ready(function (){
            $('#id').blur(
                function (){
                    var id = document.getElementById('id').value;

                    if(id == "" || id.length == 0) {
                        $('.idMsg').css("display", "block");
                    } else {
                        $('.idMsg').css("display", "none");
                    }
                });

            $('#email').blur(
                function (){
                    var email = document.getElementById('email').value;

                    if(email== "" || email.length == 0) {
                        $('.emailMsg').css("display", "block");
                    } else {
                        $('.emailMsg').css("display", "none");
                    }
                });

            $('#findBtn').click(function (){
                var id  = $('#id').val();
                var email = $('#email').val();

                $.ajax({
                    type:"POST",
                    url: "/member/findPwd",
                    data : {
                        id : id,
                        email : email
                    },
                    success : function (data) {
                        result:data
                        if (data == 0 || id.length == 0|| email.length == 0){
                            document.getElementById("view1").style.display = "none";
                            document.getElementById("view2").style.display = "none";
                            $('.msg').text("아이디 또는 이메일을 다시 확인해 주세요.");
                            document.getElementById("view3").style.display = "block";
                        } else {
                            document.getElementById("view1").style.display = "none";
                            document.getElementById("view2").style.display = "block";
                            $('#pwd').blur(
                                function (){
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

                                        $('#changeBtn').click(function (){
                                            $.ajax({
                                                type:"POST",
                                                url: "/updatePwd",
                                                data : {
                                                    id : $('#id').val(),
                                                    pwd : $('#pwd').val(),
                                                    email : $('#email').val()
                                                },
                                                success : function (data) {
                                                    result:data
                                                    document.getElementById("view1").style.display = "none";
                                                    document.getElementById("view2").style.display = "none";
                                                    document.getElementById("view3").style.display = "block";
                                                },
                                                error: function (data) {
                                                    result:data,
                                                        alert("실패")
                                                    document.getElementById("view1").style.display = "none";
                                                    document.getElementById("view2").style.display = "block";
                                                },
                                            });
                                        });
                                    }
                                }
                            });
                        }
                    },
                    error: function (data) {
                        result:data,
                        alert("실패")
                        document.getElementById("view1").style.display = "none";
                        document.getElementById("view2").style.display = "block";
                    },
                });
            });
        });
    </script>
</head>
<body>
<header>
    <h1>깨깨오똑</h1>
</header>
<div style="text-align: right">
    <a style='color:black' href = '<%=request.getContextPath() %>/'>메인</a>
</div>
<h4 style='text-align:center;'><b>비밀번호 찾기</b></h4><hr><br>
<div class='row'>
    <div class='col' id='view1' style='text-align:center;'>
        <label>아이디&emsp;</label>
        <input type='text' id='id' name='id'/><br>
        <span class="idMsg" style ="color:red;display:none;">필수 정보입니다.</span>
        <label>이메일&emsp;</label>
        <input type='text' id='email' name='email'/><br>
        <span class="emailMsg" style ="color:red;display:none;">필수 정보입니다.</span><br><br>
        <div  style="display: flex; justify-content: center;">
              <button type='button' class='btn btn-secondary btn-block'
                        id='findBtn' style="width:120">비밀번호 찾기</button>
        </div>
    </div>
    <div class='col' id='view2'  style ="display:none;text-align:center" >
        <label>비밀번호 재설정</label><br>
        <input type='password' id='pwd' name='pwd'/><br>
        <span class="pwdMsg" style ="color:red;display:none;">필수 정보입니다.</span>
        <label>비밀번호 확인</label><br>
        <input type='password' id='pwdChk' name='pwdChk'/><br>
        <span class="pwdChkMsg" style ="color:red;display:none;">필수 정보입니다.</span><br>
        <div  style="display: flex; justify-content: center;">
            <button type='button' class='btn btn-secondary btn-block'
                    id='changeBtn' style="width: 120" >비밀번호 변경</button>
        </div>
    </div>
    <div class='col' id='view3'  style ="display:none;text-align:center" >
        <span class="msg">비밀번호 변경 완료</span><br><br><br>
        <div  style="display: flex; justify-content: center;">
            <button type='button' class='btn btn-secondary btn-block'
                    id='mainBtn' style="width: 120" onclick="location.href='/'">메인으로</button>
        </div>
    </div>
</div>
</body>
</html>