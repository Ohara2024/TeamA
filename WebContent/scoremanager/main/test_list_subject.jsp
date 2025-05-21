<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.Subject" %>
<%@ page import="bean.TestListSubject" %>
<%-- このJSPはtest_list.jspからincludeされるため、html, head, bodyタグは不要です --%>

<h1>成績一覧 (科目)</h1>

<%
    Subject subject = (Subject) request.getAttribute("subject");
    List<TestListSubject> testListSubject = (List<TestListSubject>) request.getAttribute("testList");

    if (subject != null && testListSubject != null) {
%>
    <p>科目：<%= subject.getName() %></p>

    <% if (testListSubject.isEmpty()) { %>
        <p>該当する成績情報は見つかりませんでした。</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>入学年度</th>
                    <th>クラス</th>
                    <th>学生番号</th>
                    <th>氏名</th>
                    <th>1回</th>
                    <th>2回</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (TestListSubject test : testListSubject) {
                %>
                        <tr>
                            <td><%= test.getEntYear() %></td>
                            <td><%= test.getClassNum() %></td>
                            <td><%= test.getStudentNo() %></td>
                            <td><%= test.getStudentName() %></td>
                            <td><%= test.getPoint(1) %></td>
                            <td><%= test.getPoint(2) %></td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <% } %>
<%
    } else {
%>
    <p>科目情報が見つからないか、成績データの取得に失敗しました。</p>
<%
    }
%>