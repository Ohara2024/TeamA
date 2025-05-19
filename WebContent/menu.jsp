<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ホーム</title>
</head>
<body>
    <h2>ようこそ、${sessionScope.user}さん！</h2>

    <!-- ログアウトリンク -->
    <a href="logout.action">ログアウト</a>
</body>
</html>
