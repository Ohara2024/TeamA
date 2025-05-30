<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>科目情報削除完了 | 得点管理システム</title>


  <!-- ────── ページ専用スタイル ────── -->
  <style>
    .done-message{
      background:#79c19c;   /* グリーン帯 */
      color:#fff;
      padding:8px;
      margin:12px 0 24px;
      text-align:center;
      border-radius:2px;
    }
    .link-area{
      margin-left:120px;     /* ラベル幅と揃える場合 */
    }
    .link-area a{
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

    <!-- 見出しバー -->
    <h2>科目情報削除</h2>

    <!-- ★ ここが my-section ★ -->
    <div class="my-section">

      <!-- 完了メッセージ -->
      <p class="done-message">削除が完了しました</p>

      <!-- 戻りリンク -->
      <div class="link-area">
        <a href="SubjectList.action">科目一覧</a>
      </div>

    </div><!-- /.my-section -->

  </div><!-- /.content-area -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
