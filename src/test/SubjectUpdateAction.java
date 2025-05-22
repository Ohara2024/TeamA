package test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubjectUpdateAction")
public class SubjectUpdateAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cd = request.getParameter("cd");

        if (cd == null || cd.trim().isEmpty()) {
            request.setAttribute("error", "科目コードが指定されていません。");
            request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/exam;LOCK_TIMEOUT=10000", "sa", "");

            String sql = "SELECT CD, NAME FROM SUBJECT WHERE CD = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cd);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String currentCd = rs.getString("CD");
                String name = rs.getString("NAME");
                request.setAttribute("currentCd", currentCd);
                request.setAttribute("name", name);
            } else {
                request.setAttribute("error", "指定された科目（コード: " + cd + "）が見つかりません。");
            }

            request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "データベースエラー: " + e.getMessage());
            request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}