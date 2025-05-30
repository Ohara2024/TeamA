<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>成績登録完了</title>
  <style>
    /* ===== 共通レイアウト ===== */
    .wrapper { display: flex; }
    .sidebar { width: 180px; padding: 10px; }
    .main { flex: 1; padding: 20px; margin-bottom: 120px; }

    .title-bar {
      background: #f0f0f0;
      font-weight: bold;
      font-size: 18px;
      padding: 10px;
      margin-bottom: 16px;
    }

    /* ===== 完了メッセージ ===== */
    .done-message {
      background: #79c19c;
      color: #fff;
      padding: 12px;
      margin: 20px auto;
      text-align: center;
      border-radius: 4px;
      width: 60%;
      font-size: 16px;
    }

    /* ===== リンクエリア ===== */
    .link-area {
      margin-top: 24px;
      text-align: center;
    }

    .link-area a {
      display: inline-block;
      margin: 0 20px;
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
    }

    .link-area a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<!-- 共通ヘッダー -->
<%@ include file="/tool/header.jsp" %>

  <!-- 共通サイドバー -->
  <div class="sidebar">
    <%@ include file="/tool/sidebar.jsp" %>
  </div>

  <!-- メイン -->
  <div class="main">

    <!-- ① 画面タイトル -->
    <div class="title-bar">成績管理</div>

    <!-- ② 完了メッセージ -->
    <p class="done-message">登録が完了しました</p>

    <!-- ③ 戻る／④ 成績参照 -->
    <div class="link-area">
      <a href="TestRegist.action">戻る</a>
      <a href="TestList.action">成績参照</a>
    </div>

  </div><!-- /.main -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
