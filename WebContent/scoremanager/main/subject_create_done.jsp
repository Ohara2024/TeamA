<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>科目情報登録完了 | 得点管理システム</title>

  <!-- ────── ページ専用スタイル ────── -->
  <style>
    /* 完了メッセージ */
    .done-message{
      background:#79c19c;     /* グリーン帯 */
      color:#fff;
      padding:8px;
      margin:12px 0 24px;
      border-radius:2px;
      text-align:center;
    }
    /* 戻る・一覧リンク */
    .link-area a{
      margin-right:24px;
      color:#007bff;
      text-decoration:none;
    }
    .link-area a:hover{ text-decoration:underline; }
  </style>
</head>

<body>

<!-- 共通ヘッダー -->
<%@ include file="/tool/header.jsp" %>


  <!-- サイドバー -->
  <%@ include file="/tool/sidebar.jsp" %>

  <!-- コンテンツ領域 -->
  <div class="content-area">

    <!-- ページ見出し -->
    <h2>科目情報登録</h2>

    <!-- ★ ここが my-section ★ -->
    <div class="my-section">

      <!-- 完了メッセージ -->
      <p class="done-message">登録が完了しました</p>

      <!-- 戻る／一覧リンク -->
      <div class="link-area">
        <a href="SubjectCreate.action">戻る</a>
        <a href="SubjectList.action">科目一覧</a>
      </div>

    </div><!-- /.my-section -->

  </div><!-- /.content-area -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
