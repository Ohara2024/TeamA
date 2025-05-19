package scoremanager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tool.Action;

public class LoginExecute extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        String jdbcUrl = "jdbc:h2:tcp://localhost/~/exam";
        String dbUser = "sa";
        String dbPassword = "";

        try (
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM users WHERE id = ? AND password = ?"
            )
        ) {
            stmt.setString(1, id);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // 認証成功
                HttpSession session = request.getSession();
                session.setAttribute("user", id);
                return "/home.jsp";
            } else {
                // 認証失敗
                request.setAttribute("error", "IDまたはパスワードが正しくありません");
                return "/login.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました");
            return "/error.jsp";
        }
    }
}
