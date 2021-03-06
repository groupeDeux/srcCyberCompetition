/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CyberComp_G2.Ctrlers;

import CyberComp_G2.DAO.ConsulterEpreuve.GetConsulterEpreuveDAO;
import CyberComp_G2.DAO.ConsulterEpreuve.GetMedaillesDAO;
import CyberComp_G2.DAO.InscrireParticipantAEpreuve.GetParticipantsDAO;
import CyberComp_G2.Exceptions.CategorieException;
import CyberComp_G2.Exceptions.nbPlaceAcheterExeception;
import CyberComp_G2.Model.ConstituerEquipe.Equipe;
import CyberComp_G2.Model.ConstituerEquipe.Sportif;
import CyberComp_G2.Model.ConsulterEpreuve.Epreuve;
import CyberComp_G2.Model.ConsulterEpreuve.Resultat;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author fureta
 */
@WebServlet(name = "GetListParticipantDUneEpreuve", urlPatterns = {"/GetListParticipantDUneEpreuve"})
public class GetListParticipantDUneEpreuve extends HttpServlet {

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

        //HttpSession session = request.getSession(true);
        String idEpreuve = request.getParameter("idEpreuve");
  
        //boolean testFormeParEquipe = false;

        ArrayList<Equipe> listEquipesInscrites = new ArrayList();
        ArrayList<Sportif> listSportifsInscrits = new ArrayList();

        try {

            int idEpr = Integer.parseInt(idEpreuve);
            // RECUPERATION DES MEDAILLES
            Epreuve epreuveSelectionnee = new GetConsulterEpreuveDAO().getEpreuve(idEpr);
            Resultat resultatEpreuve = GetMedaillesDAO.getResultat(idEpr, epreuveSelectionnee.isIndividuelle());


            // RECUPERATION DES PARTICIPANTS
            /* ----- Participants de forme equipe ----- */
            if (! epreuveSelectionnee.isIndividuelle()) {
                CachedRowSet rowSetEquipesInscrites = GetParticipantsDAO.getEquipesInscrites(Integer.parseInt(idEpreuve));

                /* cree un objet Equipe pour chaque ligne du rowset parcouru
                 et le met dans l arrayList listEquipesInscrites */
                while (rowSetEquipesInscrites.next()) {
                    // recupereation les informations de  l'quipe
                    listEquipesInscrites.add(new Equipe(rowSetEquipesInscrites.getInt("idEquipe"), rowSetEquipesInscrites.getString("pays"), rowSetEquipesInscrites.getString("nomEquipe"), rowSetEquipesInscrites.getString("categorie"), rowSetEquipesInscrites.getInt("nbMembre")));
                }
                request.setAttribute("listParticipants", listEquipesInscrites);

            } /* ----- Participants de forme sportif ----- */ else {
                CachedRowSet rowSetSportifsInscrits = GetParticipantsDAO.getSportifInscritAEpreuve(Integer.parseInt(idEpreuve));

                /* cree un objet sportif  pour chaque ligne du rowset parcouru
                 et le met dans l arrayList listSportifsInscrits */
                while (rowSetSportifsInscrits.next()) {
                    // recupereation les informations de chaque Sportif
                    listSportifsInscrits.add(new Sportif(rowSetSportifsInscrits.getInt("idSportif"), rowSetSportifsInscrits.getString("pays"), rowSetSportifsInscrits.getString("prenom"), rowSetSportifsInscrits.getString("nom"), rowSetSportifsInscrits.getString("dateNaissance"), rowSetSportifsInscrits.getString("genre")));
                }
                request.setAttribute("listParticipants", listSportifsInscrits);
            }
            
            request.setAttribute("epreuveSelectionnee", epreuveSelectionnee);
            request.setAttribute("resultatEpreuve", resultatEpreuve);
            request.getRequestDispatcher("/WEB-INF/infoEpreuve.jsp").forward(request, response);
            
        } catch (SQLException | CategorieException | nbPlaceAcheterExeception ex) {
            log(ex.getMessage());
            ex.printStackTrace();
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
