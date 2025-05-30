package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            res.sendRedirect("../Login.action");
            return;  // 処理終了
        } else {
            School school = teacher.getSchool();

            String cd = req.getParameter("cd");

            SubjectDao dao = new SubjectDao();
            Subject subject = dao.get(cd, school);

            if (subject != null) {
                dao.delete(subject);
            }

            req.getRequestDispatcher("subject_delete_done.jsp").forward(req, res);
        }
    }
}
