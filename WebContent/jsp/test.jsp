<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	bodyの中はこのようにしてください
	・最初にincludeでヘッダーとサイドバーをいれてください
		※必ず最初にヘッダー、その次にサイドバーを入れてください
	・メインコンテンツはdiv=contentで囲ってください
	・最後にincludeでフッターを入れてください
 -->
<%@ include file="../tool/header.jsp" %>
<%@ include file="../tool/sidebar.jsp" %>
	<div class="content">
		<h2>メニュー</h2>
		<p>これはテストケースです</p>
	</div>
<%@ include file="../tool/footer.jsp" %>

</body>
</html>