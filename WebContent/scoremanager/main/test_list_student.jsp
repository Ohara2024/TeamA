<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.Student" %>
<%@ page import="bean.TestListStudent" %>
<h1>成績一覧 (学生)</h1>

<%
    Student student = (Student) request.getAttribute("student");
    List<TestListStudent> testListStudent = (List<TestListStudent>) request.getAttribute("testListStudent");

    if (student != null && testListStudent != null) {
%>
    <p>氏名：<%= student.getName() %>(<%= student.getNo() %>)</p>

    <%
        if (testListStudent.isEmpty()) {
    %>
        <p>成績情報が存在しませんでした</p>
    <%
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>科目名</th>
                    <th>科目コード</th>
                    <th>回数</th>
                    <th>点数</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (TestListStudent test : testListStudent) {
                %>
                        <tr>
                            <td><%= test.getSubjectName() %></td>
                            <td><%= test.getSubjectCd() %></td>
                            <td><%= test.getNum() %></td>
                            <td><%= test.getPoint() %></td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
<%
    } else {
%>
    <p>学生情報が見つからないか、成績データの取得に失敗しました。</p>
<%
    }
%>