<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報登録</title>
</head>
<body>
    <h2>科目情報登録</h2>
    <form action="subject_create_done.jsp" method="post">
        科目コード：<input type="text" name="cd"><br>
        科目名：<input type="text" name="name"><br>
        <input type="submit" value="登録">
        <button onclick="history.back()">戻る</button>

    </form>
</body>
</html>
