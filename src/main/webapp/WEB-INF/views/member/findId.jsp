<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>FINDID</title>
    <style>
        header {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
        }
    </style>
    <script>
        $(document).ready(function (){
            $('#email').blur(function () {
                if(document.getElementById('email').value== "") {
                    $('.emailMsg').css("display","block");
                }else {
                    $('#findBtn').click(function (){
                        $.ajax({
                            type:"POST",
                            url: "/member/findId",
                            data : {
                                email : $('#email').val()
                            },
                            success : function (data) {
                                result:data,
                                    document.getElementById("view1").style.display = "none";
                                $('.msg').text(data);
                                document.getElementById("view2").style.display = "block";
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
            })
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
<h4 style='text-align:center;'><b>아이디 찾기</b></h4><hr><br>
<div class='row'>
    <div class='col' id='view1' style='text-align:center;'>
        <label>이메일&emsp;</label>
        <input type='text' id='email' name='email'/><br>
        <span class="emailMsg" style ="color:red;display:none;">필수 정보입니다.</span><br><br>
        <div  style="display: flex; justify-content: center;">
              <button type='button' class='btn btn-secondary btn-block'
                        id='findBtn' style="width:120">아이디 찾기</button>
        </div>
    </div>
    <div class='col' id='view2'  style ="display:none;text-align:center" >
        <span class="msg"></span><br><br><br>
        <div  style="display: flex; justify-content: center;">
            <button type='button' class='btn btn-secondary btn-block'
                    id='mainBtn' style="width: 120" onclick="location.href='/'">메인으로</button>
        </div>
    </div>
</div>
</body>
</html>