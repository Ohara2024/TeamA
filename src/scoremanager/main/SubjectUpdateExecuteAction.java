package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            res.sendRedirect("../Login.action");
            return; // 処理終了
        } else {
            School school = teacher.getSchool();

            String cd = req.getParameter("cd");
            String name = req.getParameter("name");

            if (name != null && !name.trim().isEmpty()) {
                SubjectDao dao = new SubjectDao();
                Subject subject = dao.get(cd, school);

                if (subject == null) {
                    req.setAttribute("cd", cd);
                    req.setAttribute("name", name);
                    req.setAttribute("cdError", "科目が存在していません");
                    req.getRequestDispatcher("subject_update.jsp").forward(req, res);
                } else {
                    subject.setName(name.trim());
                    dao.save(subject);
                    req.getRequestDispatcher("subject_update_done.jsp").forward(req, res);
                }
            } else {
                req.setAttribute("cd", cd);
                req.setAttribute("name", name);
                req.setAttribute("cdError", "科目名を入力してください");
                req.getRequestDispatcher("subject_update.jsp").forward(req, res);
            }
        }
    }
}
