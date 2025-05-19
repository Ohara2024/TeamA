<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目登録</title>
</head>
<body>
    <h1>科目登録</h1>
    <form action="SubjectCreateServlet" method="post">
        <label>科目コード：<input type="text" name="code" required></label><br>
        <label>科目名：<input type="text" name="name" required></label><br>
        <input type="submit" value="登録">
    </form>
</body>
</html>
