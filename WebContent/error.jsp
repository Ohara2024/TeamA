<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error</title>
</head>
<body>
<h1>Error</h1>
<%
    List<String> errorMsgList = (List<String>) request.getAttribute("errorMsg");
    if (errorMsgList != null && !errorMsgList.isEmpty()) {
        for (String msg : errorMsgList) {
%>
            <p><%= msg %></p>
<%
        }
    } else {
%>
        <p>An unexpected error occurred.</p>
<%
    }
%>
</body>
</html>