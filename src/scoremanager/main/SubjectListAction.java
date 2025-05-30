package scoremanager.main;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectListAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        Teacher teacher = (Teacher)session.getAttribute("user");

        if (teacher == null) {
            response.sendRedirect("../Login.action");
        } else {
            School school = teacher.getSchool();

            SubjectDao dao = new SubjectDao();
            List subjectList = dao.filter(school);

            request.setAttribute("subjects", subjectList);

            request.getRequestDispatcher("subject_list.jsp").forward(request, response);
        }
    }
}
