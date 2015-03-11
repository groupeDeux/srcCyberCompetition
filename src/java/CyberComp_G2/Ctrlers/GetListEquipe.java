/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CyberComp_G2.Ctrlers;

import CyberComp_G2.DAO.ConsituerEquipe.GetConsulterEquipeDAO;
import CyberComp_G2.DAO.InscrireParticipantAEpreuve.GetParticipantsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import static java.rmi.server.LogStream.log;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.CachedRowSet;

/**
 * Renvoi une liste d'objets java de classe Equipes
 * pour toutes les equipes de la competition
 * @author agathe
 */

/*  ATTENTION MEME NOM QUE POUR GETLISTDUNEDELAGATION.JAJA !!!!!!!
---->  A MODIFIER */

@WebServlet(name = "GetListEquipe", urlPatterns = {"/GetListEquipe"})
public class GetListEquipe {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        StringBuilder rep = new StringBuilder(); // On en a besoin ici?  
        String categorie = request.getParameter("categorie"); // qu'est ce que la request  ??
        
        try(PrintWriter out = response.getWriter()){
            
            // recuperation des donnees BD chargees avec DAO dans un rowSet
            CachedRowSet rowSetEquipes=GetParticipantsDAO.getEquipes();
            /*Parcours du rowSet pour creer la liste deroulante 
             * au format html    ?? 
             * rowSetEquipe.getString("pays") --> le row set connait le nom des colonnes ??
             */
           
            while(rowSetEquipes.next()){
                String pays = rowSetEquipes.getString("pays");
                String idEquipe = rowSetEquipes.getString("idEquipe");
                rep.append("<option value='").append(rowSetEquipes.getString("idEquipe")).append("'>").append(pays).append(" ").append(idEquipe);
            }
            out.println(rep);
        }catch (SQLException ex){
            log(ex.getMessage());
        }
    } 
    
}
