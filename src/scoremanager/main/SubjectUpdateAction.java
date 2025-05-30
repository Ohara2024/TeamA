package scoremanager.main;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateAction extends Action {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher)session.getAttribute("user");

        if (teacher == null) {
            res.sendRedirect("../Login.action");
        } else {
            School school = teacher.getSchool();

            String cd = req.getParameter("cd");
            SubjectDao dao = new SubjectDao();
            Subject subject = dao.get(cd, school);

            if (subject == null) {
                req.setAttribute("cd", cd);
                req.setAttribute("cdError", "科目が存在していません");
                req.getRequestDispatcher("subject_update.jsp").forward(req, res);
            } else {
                req.setAttribute("cd", subject.getCd());
                req.setAttribute("name", subject.getName());
                req.getRequestDispatcher("subject_update.jsp").forward(req, res);
            }
        }
    }
}
