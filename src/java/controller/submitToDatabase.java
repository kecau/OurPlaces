/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import static database.common.driver;
import static database.common.password;
import static database.common.url;
import static database.common.username;
import database.iconnectionpool;
import database.simpleconnectionpool;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.getFromDatabase;
import model.insertToDatabase;

/**
 *
 * @author VUONG NGUYEN
 */
public class submitToDatabase extends HttpServlet {
    private static String getClientIp(HttpServletRequest request) {

        String remoteAddr = "";

        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        return remoteAddr;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            ServletContext application=getServletContext();
            HttpSession sesion=request.getSession();
            iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getTourism");
               if (connectionPool == null) {
                  try {
                    Class.forName(driver);
                  } catch (Exception e) {
                    out.println(e);
                  }
               connectionPool = new simpleconnectionpool(url, username, password);
               application.setAttribute("getTourism", connectionPool);
            }
            request.setCharacterEncoding("utf-8");
            //get data from url
            String action=request.getParameter("action");
            String iduser=request.getParameter("iduser");
            String ipclients=getClientIp(request);       
            insertToDatabase submit = new insertToDatabase();
            
            //Insert Place from User activity
            if(action.equals("place")){                
                String id_place=request.getParameter("id");            
                String type=request.getParameter("type");
                String code=request.getParameter("code");
                getFromDatabase info = new getFromDatabase();
                if(info.Check_Place(connectionPool, iduser, id_place).equals("true")){}else{
                    submit.InsertPlace(connectionPool, iduser, id_place, ipclients);}
                response.sendRedirect("similarplace.jsp?type="+type+"&id="+id_place+"&code="+code);
            }
            
            //Update Similar Place from User activity
            if(action.equals("similarplace")){                
                String id_place=request.getParameter("idplace");  
                String id_similar_place=request.getParameter("idsimilarplace");
                submit.UpdatePlace(connectionPool, iduser, id_place, ipclients, id_similar_place);
                response.sendRedirect("index.jsp?search");
            }
            
            //Delete from User activity
            if(action.equals("deleteactivity")){
                String id=request.getParameter("id");
                String pages=request.getParameter("pages");
                String edit=request.getParameter("edit");
                submit.DeleteActivity(connectionPool, id);
                response.sendRedirect("profile.jsp?edit="+edit+"&pages="+pages);
            }
            
            //Delete user and all activities of user
            if(action.equals("deleteuser")){
                String id=request.getParameter("id");                
                //delete all activities of user
                submit.DeleteAllActivityUser(connectionPool, id);
                //delete user information
                submit.DeleteUser(connectionPool, id);
                response.sendRedirect("statistic.jsp");
            }
            
            //Delete user and all activities of user
            if(action.equals("updateprofile")){
                String uname = request.getParameter("uname");
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");                
                String country_code = request.getParameter("country");               
                
                submit.UpdateUser(connectionPool, iduser, uname, email, pass, country_code);
                
                //Remove session and create new session
                sesion.removeAttribute("userlogin");                
                getFromDatabase newuser = new getFromDatabase();
                container.user sessionuser=newuser.checkLogin(connectionPool, email, pass);
                sesion.setAttribute("userlogin",sessionuser);
                //Call back HTML JSP
                response.sendRedirect("profile.jsp?edit=ok&pages=0");
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
