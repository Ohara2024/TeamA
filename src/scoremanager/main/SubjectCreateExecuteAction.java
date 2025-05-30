package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            res.sendRedirect("../Login.action");
            return;
        }

        School school = teacher.getSchool();
        if (school == null) {
            res.sendRedirect(req.getContextPath() + "/Login.action");
            return;
        }

        String cdError = null;

        if (cd == null || cd.trim().isEmpty()) {
            cdError = "科目コードを入力してください";
        } else if (cd.trim().length() != 3) {
            cdError = "科目コードは3文字で入力してください";
        } else if ((new SubjectDao()).get(cd.trim(), school) != null) {
            cdError = "科目コードが重複しています";
        }

        if (cdError != null) {
            req.setAttribute("cdError", cdError);
            req.setAttribute("cd", cd);
            req.setAttribute("name", name);
            req.getRequestDispatcher("subject_create.jsp").forward(req, res);
        } else {
            Subject subject = new Subject();
            subject.setCd(cd.trim());
            subject.setName(name != null ? name.trim() : "");
            subject.setSchool(school);

            if (!(new SubjectDao()).save(subject)) {
                req.setAttribute("cdError", "登録に失敗しました。再試行してください。");
                req.setAttribute("cd", cd);
                req.setAttribute("name", name);
                req.getRequestDispatcher("subject_create.jsp").forward(req, res);
            } else {
                req.getRequestDispatcher("subject_create_done.jsp").forward(req, res);
            }
        }
    }
}
