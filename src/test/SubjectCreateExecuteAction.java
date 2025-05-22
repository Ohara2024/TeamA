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

  @WebServlet("/SubjectCreateExecuteAction")
  public class SubjectCreateExecuteAction extends HttpServlet {
      private static final long serialVersionUID = 1L;

      @Override
      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          String schoolCd = "oom"; // 固定値
          String subjectCd = request.getParameter("cd");
          String subjectName = request.getParameter("name");

          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          try {
              Class.forName("org.h2.Driver");
              conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/exam", "sa", "");


              if (subjectCd == null || subjectCd.trim().isEmpty() || subjectName == null || subjectName.trim().isEmpty()) {
                  request.setAttribute("emptyError", "科目コードまたは科目名が入力されていません。");
                  request.getRequestDispatcher("/subject_create.jsp").forward(request, response);
                  return;
              }

              if (subjectCd.length() != 3) {
                  request.setAttribute("cdLengthError", "科目コードは3文字で入力してください。");
                  request.getRequestDispatcher("/subject_create.jsp").forward(request, response);
                  return;
              }

              String query = "SELECT COUNT(*) FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?";
              pstmt = conn.prepareStatement(query);
              pstmt.setString(1, schoolCd);
              pstmt.setString(2, subjectCd);
              rs = pstmt.executeQuery();
              if (rs.next() && rs.getInt(1) > 0) {
                  request.setAttribute("cdDuplicateError", "科目コードが重複しています。");
                  request.getRequestDispatcher("/subject_create.jsp").forward(request, response);
                  return;
              }

              pstmt.close();
              String insertQuery = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";
              pstmt = conn.prepareStatement(insertQuery);
              pstmt.setString(1, schoolCd);
              pstmt.setString(2, subjectCd);
              pstmt.setString(3, subjectName);
              pstmt.executeUpdate();

              request.getRequestDispatcher("/subject_create_done.jsp").forward(request, response);
          } catch (Exception e) {
              e.printStackTrace();
              request.setAttribute("emptyError", "データベースエラー: " + e.getMessage());
              request.getRequestDispatcher("/subject_create.jsp").forward(request, response);
          } finally {
              try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
              try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
              try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
          }
      }

      @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          response.sendRedirect(request.getContextPath() + "/SubjectCreateAction");
      }
  }