/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CyberComp_G2.Ctrlers.AdministrerEquipe;

import CyberComp_G2.DAO.ConsituerEquipe.ModifierEquipeDAO;
import CyberComp_G2.Model.ConstituerEquipe.Equipe;
import CyberComp_G2.Model.ConstituerEquipe.Sportif;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author vivi
 */
@WebServlet(name = "CreerEquipe", urlPatterns = {"/CreerEquipe"})
public class CreerEquipe extends HttpServlet {
    
    @Resource (name="jdbc/BDCyberCompetition")
    private  DataSource dataSource;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       HttpSession session = request.getSession(true);
        Equipe newEquipe = (Equipe) session.getAttribute("newEquipe");
        ArrayList<Sportif> lesSportifs =  (ArrayList<Sportif>) session.getAttribute("lesSportifs");        
        int i,j;
        for(i=1;i<=newEquipe.getNbDeSportif();i++){
            for(j=0;j<lesSportifs.size();j++){
                if(lesSportifs.get(j).getIdSportif()==Integer.parseInt(request.getParameter("sportifSelect"+i))){
                   newEquipe.addMembre(lesSportifs.get(j));
                }
            }
        }
        try{
         ModifierEquipeDAO.addEquipe(dataSource,newEquipe);   
        }catch(SQLException ex){
            log(ex.getMessage());
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
