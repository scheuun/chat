<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>LIST</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
        }

        .room-list {
            list-style-type: none;
            padding: 0;
            background-color: #3498db;
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
    <h1>깨깨오똑</h1>
</header>
<div class="chat-container">
    <div class="chat-sidebar">
        <h2>채팅방 목록</h2>
        <ul class="room-list">
            <li><a href="#">방 1</a></li>
            <li><a href="#">방 2</a></li>
            <li><a href="#">방 3</a></li>
        </ul>
    </div>
</div>
</body>
</html>