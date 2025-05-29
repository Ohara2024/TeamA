package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Student;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	//jspかたのものをGetする
        String no =request.getParameter("No");
        try {
        	HttpSession session = request.getSession();
        	StudentDao dao = new StudentDao();
            Student student = dao.get(no);

            request.setAttribute("student", student);
            request.getRequestDispatcher("/scoremanager/main/student_update.jsp").forward(request, response);

        	} catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "システムエラーが発生しました。");
        	}
    }
 }
