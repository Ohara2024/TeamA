<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.Subject" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>科目管理 | 得点管理システム</title>

  <!-- ────── ページ専用スタイル ────── -->
  <style>
    /* 新規登録リンク */
    .new-link{
      text-align:right;
      margin:10px 0;
    }

    /* 一覧テーブル */
    table{
      width:100%;
      border-collapse:collapse;
    }
    th{
      text-align:left;
      font-weight:bold;
      padding:6px;
      border-bottom:1px solid #aaa;
    }
    td{
      padding:6px;
      border-bottom:1px solid #ccc;
    }
    td.subject-name{
      padding-left:0;  /* 科目名をやや左寄せ */
      width:40%;
    }
    td.actions{
      white-space:nowrap;
    }
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
    <h2>科目管理</h2>

    <!-- ★ ここが my-section ★ -->
    <div class="my-section">

      <!-- 新規登録リンク -->
      <div class="new-link">
        <a href="SubjectCreate.action">新規登録</a>
      </div>

      <!-- 一覧テーブル -->
      <table>
        <thead>
          <tr>
            <th>科目コード</th>
            <th>科目名</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="subject" items="${subjects}">
            <tr>
              <td>${subject.cd}</td>
              <td class="subject-name">${subject.name}</td>
              <td class="actions">
                <a href="SubjectUpdate.action?cd=${subject.cd}">変更</a>
              </td>
              <td class="actions">
                <a href="SubjectDelete.action?cd=${subject.cd}">削除</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

    </div><!-- /.my-section -->

  </div><!-- /.content-area -->

<!-- 共通フッター -->
<%@ include file="/tool/footer.jsp" %>
</body>
</html>
