package test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubjectUpdateExecuteAction")
public class SubjectUpdateExecuteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newCd = request.getParameter("cd").trim();
        String name = request.getParameter("name").trim();

        if (newCd == null || newCd.isEmpty() || name == null || name.isEmpty()) {
            request.setAttribute("error", "科目コードまたは科目名が入力されていません。");
            request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/exam;LOCK_TIMEOUT=10000", "sa", "");

            // トランザクション開始
            conn.setAutoCommit(false);

            // 既存の科目を削除
            String deleteSql = "DELETE FROM SUBJECT WHERE CD = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setString(1, request.getParameter("cd")); // 更新前のコードを削除
            pstmt.executeUpdate();
            pstmt.close();

            // 新しい科目を挿入（SCHOOL_CD を固定値で挿入）
            String insertSql = "INSERT INTO SUBJECT (CD, NAME, SCHOOL_CD) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, newCd);
            pstmt.setString(2, name);
            pstmt.setString(3, "01"); // SCHOOL_CD を固定（必要に応じて変更可能）

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit();
                request.getRequestDispatcher("/subject_update_done.jsp").forward(request, response);
            } else {
                conn.rollback();
                request.setAttribute("error", "更新に失敗しました。");
                request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            request.setAttribute("error", "データベースエラー: " + e.getMessage());
            request.getRequestDispatcher("/subject_update.jsp").forward(request, response);
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
}
