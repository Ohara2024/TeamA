<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>科目情報削除 | 得点管理システム</title>


  <!-- ────── ページ専用スタイル ────── -->
  <style>
    .confirm-message{margin:24px 0 12px 120px;}
    .actions{margin-left:120px;}
    .actions input[type="submit"]{
      width:100px;padding:8px 0;background:#dc3545;color:#fff;
      border:none;border-radius:4px;cursor:pointer;
    }
    .actions input[type="submit"]:hover{background:#c82333;}
    .back-link{margin-top:14px;}
    .back-link a{color:#007bff;text-decoration:none;}
    .back-link a:hover{text-decoration:underline;}
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
    <h2>科目情報削除</h2>

    <!-- ★ ここが my-section ★ -->
    <div class="my-section">

      <!-- 確認メッセージ -->
      <p class="confirm-message">
        「${subject_name}（${subject_cd}）」を削除してもよろしいですか
      </p>

      <!-- 削除ボタン（hidden でキー送信） -->
      <form action="SubjectDeleteExecute.action" method="post" class="actions">
        <input type="hidden" name="cd"   value="${subject_cd}">
        <input type="hidden" name="name" value="${subject_name}">
        <input type="submit" value="削除">
      </form>

      <!-- 戻るリンク -->
      <div class="back-link">
        <a href="SubjectList.action">戻る</a>
      </div>

    </div><!-- /.my-section -->

  </div><!-- /.content-area -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
