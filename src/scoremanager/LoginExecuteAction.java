package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class LoginExecuteAction extends Action {

    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        try {

            String id = request.getParameter("id");

            String password = request.getParameter("password");

            TeacherDao dao = new TeacherDao();

            Teacher teacher = dao.login(id, password);

            if (teacher != null) {

                HttpSession session = request.getSession();

                session.setAttribute("user", teacher);

                request.getRequestDispatcher("main/menu.jsp").forward(request, response);

            } else {

            	 request.getRequestDispatcher("/error.jsp").forward(request, response);

            }

        } catch (Exception e) {

            e.printStackTrace();

            request.getRequestDispatcher("/error.jsp").forward(request, response);

        }

    }

}

