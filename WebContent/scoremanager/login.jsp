<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../tool/header.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        background-color: #f0f2f5; /* 全体的な背景色 */
        display: flex; /* Flexboxを使って中央寄せ */
        flex-direction: column; /* 縦方向に配置 */
        min-height: 100vh; /* ビューポートの高さを埋める */
    }

    /* ヘッダーとフッターを除くコンテンツエリア */
    .login-container {
        flex-grow: 1; /* 残りのスペースを埋める */
        display: flex;
        justify-content: center; /* 水平方向中央寄せ */
        align-items: center; /* 垂直方向中央寄せ */
        padding: 20px; /* 内側の余白 */
    }

    /* ログインフォームのカード */
    .login-card {
        background-color: #ffffff;
        padding: 40px 30px; /* 内側の余白を少し多めに */
        border-radius: 8px; /* 角丸を少し大きめに */
        box-shadow: 0 4px 10px rgba(0,0,0,0.1); /* 影を少し強めに */
        width: 100%;
        max-width: 400px; /* フォームの最大幅を制限 */
        text-align: center; /* タイトルとボタンを中央寄せ */
    }

    .login-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin-bottom: 30px; /* 下部に間隔 */
    }

    .form-group {
        margin-bottom: 20px; /* 各入力グループ間の間隔 */
        text-align: left; /* ラベルと入力フィールドのテキストを左寄せ */
    }

    .form-label { /* ID: や パスワード: のラベル */
        display: block;
        font-size: 14px;
        color: #555;
        margin-bottom: 8px;
        font-weight: bold;
    }

    .form-input {
        width: 100%;
        padding: 12px 15px; /* パディングを調整 */
        border: 1px solid #ccc;
        border-radius: 5px; /* 入力フィールドの角丸 */
        font-size: 16px;
        box-sizing: border-box; /* パディングとボーダーを幅に含める */
        background-color: #F0F8FF;
    }

    .form-input::placeholder {
        color: #aaa; /* プレースホルダーの色 */
    }

    .checkbox-group {
        margin-top: 15px;
        margin-bottom: 25px; /* ログインボタンとの間隔 */
        text-align: center; /* チェックボックスを左寄せ */
    }

    .checkbox-input {
        margin-right: 8px; /* チェックボックスとラベルの間隔 */
        vertical-align: middle; /* ラベルと縦方向中央揃え */
    }

    .checkbox-label {
        font-size: 14px;
        color: #555;
        vertical-align: middle; /* チェックボックスと縦方向中央揃え */
        cursor: pointer; /* クリック可能であることを示す */
    }

    .login-button {
        background-color: blue; /* 青系の色 */
        color: white;
        padding: 12px 30px; /* ボタンのパディング */
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 18px; /* 少し大きめのフォントサイズ */
        font-weight: bold;
        width: 100%; /* 幅いっぱいに広げる */
        transition: background-color 0.3s ease; /* ホバー時のアニメーション */
    }

    .login-button:hover {
        background-color: #286090; /* ホバー時の色 */
    }
</style>

<div class="login-container">
    <div class="login-card">
        <h2 class="login-title">ログイン</h2>
        <form action="LoginExecute.action" method="POST">
            <div class="form-group">
                <label for="id" class="form-label">ID</label>
                <input type="text" id="id" name="id" class="form-input" placeholder="ID" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">パスワード</label>
                <input type="password" id="password" name="password" class="form-input" placeholder="パスワード" required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="chk_d_ps" name="chk_d_ps" onclick="togglePassword()" class="checkbox-input">
                <label for="chk_d_ps" class="checkbox-label">パスワードを表示</label>
            </div>

            <button type="submit" class="login-button">ログイン</button>
        </form>
    </div>
</div>

<script>
function togglePassword() {
    var pwd = document.getElementById("password");
    var chk = document.getElementById("chk_d_ps");
    if (chk.checked) {
        pwd.type = "text";
    } else {
        pwd.type = "password";
    }
}
</script>

<%@ include file="../tool/footer.jsp" %>