package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class LoginExecute extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        TeacherDao dao = new TeacherDao();
        Teacher teacher = dao.login(id, password);

        if (teacher != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", teacher);
            return "/menu.jsp";
        } else {
            request.setAttribute("error", "IDまたはパスワードが正しくありません");
            return "/login.jsp";
        }
    }
}
