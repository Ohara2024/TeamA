package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class LoginAction extends Action {

    @Override

    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // login.jsp へフォワード

        request.getRequestDispatcher("/scoremanager/main/login.jsp").forward(request, response);

    }

}

