<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="bean.Subject,bean.School,dao.SubjectDao" %>

<%
    request.setCharacterEncoding("UTF-8");

    String cd = request.getParameter("cd");
    String name = request.getParameter("name");

    School school = new School();
    school.setCd("S001");

    Subject subject = new Subject();
    subject.setCd(cd);
    subject.setName(name);
    subject.setSchool(school);

    SubjectDao dao = new SubjectDao();
    dao.save(subject);
%>
 <h2>科目情報変更</h2>
<p>変更が完了しました。</p>
<a href="subject_list.jsp">科目一覧</a>
