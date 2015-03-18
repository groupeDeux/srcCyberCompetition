﻿<%--
    Document   : admin
    Created on : 17 mars 2015
    Author     : oprisora
--%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Sportif"%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Equipe"%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Delegation"%>
<%@page import = "java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CyberCompetition</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/cyberCompetition.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js" ></script>

    </head>
    <body>
        <div class="container">

            <!--   
                WRAPPER DU CONTENU DE LA PAGE 
                COL-XS-10 COL-XS-OFFSET-1
            -->

            <div class="col-xs-10 col-xs-offset-1">

                <!-- 
                        BARRE DE NAVIGATION
                -->
                <div class='row'>
                    <div class="masthead">
                        <h2 class="text-muted"><a href="index.jsp" data-toggle="tooltip" data-placement="right" title="Acceder à l'accueil">CyberCompetition</a></h2>
                        <nav>
                            <ul class="nav nav-justified">
                                <li><a href="index.jsp" data-toggle="tooltip" data-placement="bottom" title="Acceder à l'accueil">Accueil</a></li>
                                <li><a href="GetListDiscipline" data-toggle="tooltip" data-placement="bottom" title="Acceder aux disciplines">Disciplines</a></li>
                                <li><a href="GetListEpreuve" data-toggle="tooltip" data-placement="bottom" title="Acceder aux épreuves">Epreuves</a></li>
                                <li><a href='#' data-toggle="tooltip" data-placement="bottom" title="Acceder aux résultats des épreuves">Resultats</a></li>
                                <li><a href="#" data-toggle="tooltip" data-placement="bottom" title="Acceder au panier">Panier</a></li>
                                <li  class='active'><a href='admin.jsp' data-toggle="tooltip" data-placement="bottom" title="Acceder aux fonctions d'administration">Admin</a></li>
                            </ul>
                        </nav>
                    </div>


                    <!-- 
                            TITRE DE LA PAGE 
                    --> 
                    <div class="page-header">
                        <h2 class="text-center"> Validation </h2>
                    </div>
                    <% String etat = (String) request.getAttribute("etat"); 
                       if(etat.equals("creation")){
                         Equipe newEquipe = (Equipe) request.getAttribute("newEquipe"); 
                         int idEquipe = newEquipe.getIdEquipe();
                         String nomEquipe = newEquipe.getNomEquipe();
                         String pays = newEquipe.getPays();
                    %>   
                    
                    <div id='equipeInscrite' class="well row" >                   
                        <h3 class="text-center">L'équipe a été inscrite </h3> 
                        <div class='col-xs-6 text-center'>
                            <div> <strong>Equipe:</strong>  <%=idEquipe%> <%=nomEquipe%> </div>
                            <div> <strong>Pays:</strong>  <%=pays%></div>
                         </div>
                         <div class='col-xs-6 text-center'>
                             <div> <strong>Les sportifs :</strong> </div>
                                <% int i;
                                for(i=0;i<newEquipe.getNbMembre();i++){
                                  Sportif sportif =  newEquipe.getLesMembres().get(i);
                                  String desSportif = sportif.getIdSportif() +" : " + sportif.getNom() + " " + sportif.getPrenom() +"</br>"; %> 
                                  <%=desSportif%> 
                                  
                                <%}%>
                         </div>
                    </div>
                    <% }
                    if(etat.equals("modification")){
                         Equipe equipe = (Equipe) request.getAttribute("equipe"); 
                         int idEquipe = equipe.getIdEquipe();
                         String nomEquipe = equipe.getNomEquipe();
                         String pays = equipe.getPays();
                    %>   
                    
                    <div id='equipeInscrite' class="well row" >                   
                        <h3 class="text-center">L'équipe a été modifiée </h3> 
                        <div class='col-xs-6 text-center'>
                            <div> <strong>Equipe:</strong>  <%=idEquipe%> <%=nomEquipe%> </div>
                            <div> <strong>Pays:</strong>  <%=pays%></div>
                         </div>
                         <div class='col-xs-6 text-center'>
                             <div> <strong>Les sportifs :</strong> </div>
                                <% int i;
                                for(i=0;i<equipe.getNbMembre();i++){
                                  Sportif sportif =  equipe.getLesMembres().get(i);
                                  String desSportif = sportif.getIdSportif() +" : " + sportif.getNom() + " " + sportif.getPrenom() +"<br/>"; %> 
                                  <%=desSportif%> 
                                  
                                <%}%>
                         </div>
                    </div>
                    <% }
                    if(etat.equals("suppression")){
                         Equipe equipe = (Equipe) request.getAttribute("equipeSup");
                          int idEquipe = equipe.getIdEquipe();
                          String nomEquipe = equipe.getNomEquipe();
                         String pays = equipe.getPays();
                    %>
                    <div id='equipeSuppr' class="well row">
                         <h3 class="text-center">L'équipe a été supprimer </h3>
                         <div class='col-xs-offset-3 col-xs-6 text-center'>
                            <div> <strong>Equipe:</strong>  <%=idEquipe%> <%=nomEquipe%> </div>
                            <div> <strong>Pays:</strong>  <%=pays%></div>
                         </div>
                    </div>
                    <%}
                    if(etat.equals("erreur")){
                    String mesErreur = (String) request.getAttribute("mesErreur");%>
                    <div id='erreur' class="well row">
                             <h3 class="text-center">Erreur lors de l'execution</h3>
                         <div class='col-xs-offset-3 col-xs-6 text-center'>
                               <%=mesErreur%>
                         </div>
                    </div>
                    <% }%>
                    <div class=' col-xs-offset-3 col-xs-6'>
                        <a type="button" class="btn btn-default btn-block" id="retour" href="CloseSession"> Administrer Equipe </a>
                    </div>
                </div>
                <footer class="footer">
                    <p class='text-muted pull-right'><i>m.a.j: 10/03/2015</i></p>
                    <p class="text-muted">&copy; Master 2 CCI Grenoble : Groupe2</p>
                </footer>

            </div>
        </div>

        <script>
            $(document).ready(function () {
                $("#tabs").tabs();
            });

        </script>
        <script type="text/javascript" src="js/cyberCompetition.js"></script>
        <script src="js/FormAdmin.js" type="text/javascript"></script>
    </body>
</html>
