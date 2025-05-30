<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>科目情報登録 | 得点管理システム</title>


  <!-- ────── ページ専用スタイル ────── -->
  <style>
    /* フォームレイアウト */
    .form-group{display:flex;align-items:center;margin:12px 0;}
    .form-group label{width:120px;font-weight:bold;}
    .form-group input[type="text"]{
      flex:1;padding:6px 8px;border:1px solid #ccc;border-radius:4px;
    }
    /* エラー */
    .error-message{
      color:#ff6600;font-size:0.9em;margin:4px 0 0 120px;
    }
    /* ボタン／リンク */
    .actions{margin-top:18px;}
    .actions input[type="submit"]{
      width:100px;padding:8px 0;background:#007bff;color:#fff;
      border:none;border-radius:4px;cursor:pointer;
    }
    .actions input[type="submit"]:hover{background:#0069d9;}
    .actions .back-link{margin-top:10px;}
    .actions .back-link a{color:#007bff;text-decoration:none;}
    .actions .back-link a:hover{text-decoration:underline;}
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

      <form action="SubjectCreateExecute.action" method="post">
        <!-- 科目コード -->
        <div class="form-group">
          <label for="cd">科目コード</label>
          <input type="text"
                 id="cd" name="cd"
                 value="${cd}"
                 placeholder="科目コードを入力してください"
                 maxlength="3" required>
        </div>

        <!-- エラーメッセージ -->
        <c:if test="${not empty cdError}">
          <div class="error-message">${cdError}</div>
        </c:if>

        <!-- 科目名 -->
        <div class="form-group">
          <label for="name">科目名</label>
          <input type="text"
                 id="name" name="name"
                 value="${name}"
                 placeholder="科目名を入力してください"
                 maxlength="20" required>
        </div>

        <!-- アクション -->
        <div class="actions">
          <input type="submit" value="登録">
          <div class="back-link"><a href="SubjectList.action">戻る</a></div>
        </div>
      </form>

    </div><!-- /.my-section -->

  </div><!-- /.content-area -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
