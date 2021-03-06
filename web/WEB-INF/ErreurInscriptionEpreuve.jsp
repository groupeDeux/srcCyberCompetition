
﻿<%--
    Document   : admin
    Created on : 17 mars 2015
    Author     : oprisora
--%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Sportif"%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Equipe"%>
<%@page import="CyberComp_G2.Model.ConstituerEquipe.Delegation"%>
<%@page import="java.util.Date"%>
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
        <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
        <link rel="icon" href="./img/favicon.ico" type="image/x-icon">
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
                                <li><a href="GetListEpreuve" data-toggle="tooltip" data-placement="bottom" title="Acceder à la billetterie">Billetterie</a></li>
                                <li><a href="GetPanier" data-toggle="tooltip" data-placement="bottom" title="Acceder au panier">Panier</a></li>
                                <li  class='active'><a href='admin.jsp' data-toggle="tooltip" data-placement="bottom" title="Acceder aux fonctions d'administration">Admin</a></li>
                            </ul>
                        </nav>
                    </div>


                    <!-- 
                            TITRE DE LA PAGE 
                    --> 
                    <div class="page-header">
                        <!-- <h2 class="text-center">Erreur</h2> -->
                    </div> 


                    <% String messageErreur = (String) request.getAttribute("messErreur");%>
                    <div id='erreur' class="well row">
                        <h3 class="text-center">Erreur lors de l'exécution</h3>
                        <div class='col-xs-offset-3 col-xs-6 text-center'>
                            Une erreur est survenue: <%=messageErreur%>
                        </div>
                    </div>

                    <div class=' col-xs-offset-3 col-xs-6'>
                        <a type="button" class="btn btn-default btn-block" id="retour" href="GetListEpreuveInscription"> Retour sur Inscrire participants à des épreuves </a>
                    </div>
                </div>
                <footer class="footer">
                    <% Date dateDuJour;%>
                    <% dateDuJour = new Date();%>
                    <p class='text-muted pull-right'><i> Date de dernière mise à jour : <%= dateDuJour%></i></p>
                    <p class="text-muted">&copy; Master 2 CCI Grenoble : Groupe2</p>
                </footer>
            </div>
        </div>

        <script type="text/javascript" src="js/cyberCompetition.js"></script>
    </body>
</html>
