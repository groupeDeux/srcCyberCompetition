
<%-- 
    Document   : admin
    Created on : 6 mars 2015, 14:22:31
    Author     : Gato
--%>
<%@page import="java.util.Date"%>
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
                </div>

                <!-- 
                        TITRE DE LA PAGE 
                --> 
                <div class="page-header">
                    <h2 class="text-center"><small>Administration des</small><span id="titreAdmin"> Equipes</span></h2>
                </div>
                <!-- 
                        DEBUT DE LA PAGINATION DU TABLEAU 
                -->
                <div class="row">
                    <div id="tabs">
                        <ul class="nav nav-tabs">
                            <%-- recupère le tab: si différent de null ça affiche le bon tab --%>
                            <% int tab = 0;
                                if (session.getAttribute("tabs") != null) {
                                    tab = (Integer) session.getAttribute("tabs") - 1;
                                }
                            %>
                            <li role="presentation" <%if (tab == 0) {%>class="active"<%}%>  id ="presentation1"><a href="#tab1">Créer</a></li>
                            <li role="presentation" <%if (tab == 1) {%>class="active"<%}%>   id ="presentation2"><a href="#tab2">Modifier</a></li>
                            <li role="presentation"<%if (tab == 2) {%>class="active"<%}%> ><a href="#tab3">Supprimer</a></li>

                        </ul>

                        <div class="row">
                            <br/>
                        </div>
                        <!--
 -------------------------------------------------------------ID TAB1 : CREER UNE EQUIPE---------------------------------------------------------------------------
                        -->
                        <div id='tab1'>
                            <form class="form-horizontal">
                                <div class="well">
                                    Cette page vous permet de créer une équipe.
                                </div>
                                <h4><strong>Entrer une équipe : </strong></h4>
                                <div class="row">
                                    <div class="form-group">
                                        <%  Equipe newEquipe = (Equipe) session.getAttribute("newEquipe");
                                            String categorie = "";
                                            String nomEquipe = null;
                                            if (newEquipe != null) {
                                                categorie = newEquipe.getCategorie();
                                                nomEquipe = newEquipe.getNomEquipe();
                                            }
                                        %>
                                        <label class='col-xs-3 control-label'>Délégation :</label>
                                        <div class='col-xs-6'>
                                            <select  <%if (newEquipe != null) {%> disabled="true" <%}%> class="form-control" id='selectionDelegationCreer' name='listDeleg'>
                                                <%-- affiche la liste des délégations: si pas d'équipes dans une délégation, affichage de Choix dans le menu déroulant --%>
                                                <%
                                                    int i = 0;
                                                    ArrayList<Delegation> lesDelegations = (ArrayList<Delegation>) session.getAttribute("listDelegations");
                                                    ArrayList<Sportif> lesSportifs = (ArrayList<Sportif>) session.getAttribute("lesSportifs");
                                                    if (newEquipe == null) {
                                                %> <option value=''>Choix</option>
                                                
                                                <%
                                                    for (i = 0; i < lesDelegations.size(); i++) {
                                                        String pays = lesDelegations.get(i).getPays();
                                                %>          <option value='<%=pays%>'><%=pays%></option>
                                                <%
                                                    }
                                                } else {
                                                %> <option value='<%=newEquipe.getPays()%>'><%=newEquipe.getPays()%></option>
                                                <%}
                                                %>

                                            </select>
                                        </div>
                                        <div class='col-xs-1 control-label erreurForm'id="verifDelegationCreer"></div>    
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group">
                                        <label class='col-xs-3 control-label'>Nom :</label>
                                        <div class='col-xs-6'>
                                            <input type='text'   <%if (newEquipe != null) {%> disabled="true" <%}%>class='form-control' placeholder="Nom de l'équipe" id="nomEquipeCreer" <%if (nomEquipe != null) {%> value="<%= nomEquipe%>" <%}%>></input>
                                        </div>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class='form-group'>
                                        <label class='col-xs-3 control-label'>Catégorie :</label>
                                        <div class="col-xs-6 " id="radioboutons" >
                                            <%-- bouttons radio "check" et "disabled" en fonction de la catégorie précédemment sélectionnée --%>
                                            <div class='radio-inline'>
                                                <label>
                                                    <input <%if (newEquipe != null) {%> disabled="true" <% }%> type="radio" name="radioType" value="masculin" <%if (categorie.equals("masculin") || categorie.equals("")) {%>checked<% }%> >
                                                    Masculin
                                                </label>
                                            </div>
                                            <div class="radio-inline">
                                                <label>
                                                    <input <%if (newEquipe != null) {%> disabled="true" <%}%>type="radio" name="radioType" value="feminin" <%if (categorie.equals("feminin")) {%>checked<% }%> >
                                                    Feminin
                                                </label>  
                                            </div>
                                            <div class="radio-inline">
                                                <label>
                                                    <input <%if (newEquipe != null) {%> disabled="true" <%}%> type="radio" name="radioType" value="mixte" <%if (categorie.equals("mixte")) {%>checked<% }%>>
                                                    Mixte
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%  if (newEquipe == null) { %>          
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-xs-6 col-xs-offset-3">
                                            <button type="button" class="btn btn-default btn-block" id="valCreer" >Valider</button>
                                        </div>
                                    </div>
                                </div>
                                <%
                                } else {
                                %>
                                <h4><strong>Sélectionner les sportifs : </strong></h4>

                                <div id="ajout">
                                    <% for (i = 1; i <= newEquipe.getNbDeSportif(); i++) {
                                    %> <div id='divAjoutSportif1' class="form-group">
                                        <label class='col-xs-3 control-label'>Sportif <%=i%> :</label>
                                        <div class='col-xs-5'>
                                            <select  class="form-control"  name ="selectNomAjouter" id='selectNomAjouter<%=i%>'>
                                                <option value="">Choix</option>
                                                <%-- affiche la liste des sportifs de la délégation et sélectionne un sportif de la liste présentée par le menu déroulant --%>
                                                <%int j;
                                                    int idASelectinner;
                                                    if (newEquipe.getLesMembres().size() >= i) {
                                                        idASelectinner = newEquipe.getLesMembres().get(i - 1).getIdSportif();
                                                    } else {
                                                        idASelectinner = 0;
                                                    }
                                                    for (j = 0; j < lesSportifs.size(); j++) {
                                                        int idSportif = lesSportifs.get(j).getIdParticipant();
                                                        String affichage = idSportif + " : " + lesSportifs.get(j).getNom() + " " + lesSportifs.get(j).getPrenom();

                                                %>
                                                <option value="<%=idSportif%>"<%if (idSportif == idASelectinner) {%>selected="selected"<%}%> ><%=affichage%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                            <%-- boutton permettant la suppression d'un sportif : active ssi le nombre de membres et supérieure à 2--%>
                                        <div class='col-xs-1'> <button   <% if (newEquipe.getNbDeSportif() == 2) {%>disabled="true"<%}%> type="button" class="btn btn-danger btn-block " id="valSupprimerSportif<%=i%>" name='valSupprimerSportif' value='<%=i%>'data-toggle='tooltip' data-placement='right' title='Supprimer ce sportif' style="margin-left:6px;"><span class="glyphicon glyphicon-minus"></span></button></div>    
                                    </div>
                                    <%}%>
                                </div>
                                <div class="row">
                                    <div class="form-group">
                                        <%-- div permettant le contrôle d'erreur --%>
                                        <div class="col-xs-offset-5 col-xs-2 erreurForm" id="ControlValAjouterSportif">

                                        </div>
                                        <div class="col-xs-1 col-xs-offset-1">
                                             <%-- boutton permettant l'ajout d'un sportif--%>
                                            <button  type="button" class="btn btn-primary btn-block " id="valAjouterSportif" data-toggle='tooltip' data-placement='right' title='Ajouter un sportif'><span class="glyphicon glyphicon-plus"></span></button>
                                        </div>
                                    </div>
                                </div>
                                <%-- bouttons permettant la création de l'équipe ou l'annulation des actions précédentes --%>
                                <div class="row" id="ValCreationEquipe">
                                    <div class="form-group">
                                        <div class="col-xs-2 col-xs-offset-3 ">
                                            <button type="button" class="btn btn-danger btn-block "  id="annulerCreerSpoptif" >Annuler</button>
                                        </div>
                                        <div class="col-xs-4">
                                            <button  type="button" class="btn btn-primary btn-block " id="validerCreerEquipe">Valider l'équipe&nbsp;<span class='glyphicon glyphicon-ok'></span></button>
                                        </div>
                                    </div>
                                </div> 
                                <%}%>

                            </form>
                        </div>

                        <!--
----------------------------------------------ID TAB2 : MODIFIER UNE EQUIPE---------------------------------------------------------------------
                        -->
                        <% Equipe equipeModif = (Equipe) session.getAttribute("modifEquipe");
                            ArrayList<Sportif> lesSportifsModif = (ArrayList<Sportif>) session.getAttribute("lesSportifsModif");
                            ArrayList<Equipe> lesEquipes = (ArrayList<Equipe>) session.getAttribute("lesEquipes");
                            String paysSelecte = "";
                            int equipeSelecte = 0;
                            if (equipeModif != null) {
                                paysSelecte = equipeModif.getPays();
                                equipeSelecte = equipeModif.getIdEquipe();
                            }
                        %>
                        <div id='tab2'>
                            <form class="form-horizontal" id="formModifierEquipe">
                                <div class="well">
                                    Cette page vous permet de modifier les membres d'une équipe : 
                                    ajouter ou supprimer un sportif.
                                </div>
                                
                                    <h4><strong>Sélectionner l'équipe : </strong></h4>
                                
                                <div class="row">
                                    <div class="form-group">
                                        <label class='col-xs-3 control-label'>Délégation :</label>
                                        <div class='col-xs-6'>
                                             <%-- affiche la liste des délégations et sélectionne la délégation voulue--%>
                                            <select class="form-control" name='selectDelegationModifier' id='selectDelegationModifier'>
                                                <option value="1">Choix</option>
                                                <%
                                                    for (i = 0; i < lesDelegations.size(); i++) {
                                                        String pays = lesDelegations.get(i).getPays();
                                                %><option value='<%=pays%>' <% if (pays.equals(paysSelecte) || pays.equals(request.getAttribute("delegation"))) {%> selected<%}%>><%=pays%></option>
                                                <%
                                                    };
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group">
                                        <label class='col-xs-3 control-label'>Equipe :</label>
                                        <div class='col-xs-6'>
                                            <%-- affiche la liste des equipes de la délégation et sélectionne celle précédemment choisie--%>
                                            <select class="form-control" id='selectEquipeModifier' name="selectEquipeModifier"  <% if (lesEquipes == null) {%>disabled="true"<%}%>>
                                                <option value="">Choix</option>
                                                <%
                                                    if (lesEquipes != null) {
                                                        for (i = 0; i < lesEquipes.size(); i++) {
                                                            String nomEquipetemp= "";
                                                            if(lesEquipes.get(i).getNomEquipe()!=null){
                                                                nomEquipetemp=lesEquipes.get(i).getNomEquipe();
                                                            }
                                                            int idEquipetemp = lesEquipes.get(i).getIdEquipe();
                                                %>          <option value='<%=idEquipetemp%>' <% if (idEquipetemp == equipeSelecte) {%> selected<%}%>><%=idEquipetemp%> : <%=nomEquipetemp%> </option>
                                                <%
                                                        }
                                                    }
                                                %>

                                                <div id="choixEquipeModifier">
                                                </div>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                               <!--AJOUTER UN SPORTIF DANS UNE EQUIPE-->
                                <div id="ajoutModif">                         
                                    <%if (equipeModif != null) {
                                        for (i = 1; i <= equipeModif.getNbDeSportif(); i++) {%> 
                                            <div id='divAjoutSportif2' class="form-group">
                                            <label class='col-xs-3 control-label'>Sportif <%=i%> :</label>
                                            <div class='col-xs-5'>
                                             <%-- affiche la liste des sportifs de l'équipe sélectionnée--%>
                                                <select  class="form-control"  name ="selectModifier" id='selectNomModifier<%=i%>'>
                                                    <option value="">Choix</option>
                                                    <%int idASelectinner;
                                                    int j;
                                                    if (equipeModif.getLesMembres().size() >= i) {
                                                        idASelectinner = equipeModif.getLesMembres().get(i - 1).getIdSportif();
                                                    } else {
                                                        idASelectinner = 0;
                                                    }
                                                    for (j = 0; j < lesSportifsModif.size(); j++) {
                                                        int idSportif = lesSportifsModif.get(j).getIdParticipant();
                                                        String affichage = idSportif + " : " + lesSportifsModif.get(j).getNom() + " " + lesSportifsModif.get(j).getPrenom();
                                                    %>
                                                    <option value="<%=idSportif%>"<%if (idSportif == idASelectinner) {%>selected="selected"<%}%> ><%=affichage%></option>
                                                    <%}%>
                                                </select>    
                                            </div>
                                       <%-- boutton permettant la suppression: active que si le nombre de membres et supérieure à 2--%>
                                        <div class='col-xs-1'> <button   <% if (equipeModif.getNbDeSportif() == 2) {%>disabled="true"<%}%> type="button" class="btn btn-danger btn-block " id="valSupprimerSportifModif<%=i%>" name='valSupprimerSportifModif' value='<%=i%>' data-toggle='tooltip' data-placement='right' title='Supprimer ce sportif' style="margin-left:6px;"><span class="glyphicon glyphicon-minus"></span></button></div>    
                                    </div>
                                    <%}%> 
                                    <div class="row">
                                        <div class="form-group">
                                              <%-- div permettant le contrôle d'erreur --%>
                                            <div class="col-xs-offset-5 col-xs-2 erreurForm" id="ControlValAjouterSportifModif">

                                            </div>
                                              <%-- boutton permettant l'ajout d'un sportif --%>
                                            <div class="col-xs-1 col-xs-offset-1">
                                                <button  type="button" class="btn btn-primary btn-block " id="valAjouterSportifModif" data-toggle='tooltip' data-placement='right' title='Ajouter un sportif'><span class="glyphicon glyphicon-plus"></span></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" id="ValCreationEquipe">
                                        <div class="form-group">
                                            <div class="col-xs-2 col-xs-offset-3 ">
                                                <button type="button" class="btn btn-danger btn-block "  id="annulerEquipeModif" >Annuler</button>
                                            </div>
                                            <div class="col-xs-4">
                                                <button  type="button" class="btn btn-primary btn-block " id="validerEquipeModif">Valider la modification&nbsp;<span class='glyphicon glyphicon-ok'></span></button>
                                            </div>
                                        </div>
                                    </div> 
                                    <%}%> 
                                </div>
                            </form>

                        </div>

                        <!--
------------------------------------------------------------ID TAB3 : SUPPRIMER UNE EQUIPE------------------------------------------------------------------------
                        -->
                        <div id='tab3'>
                            <form class="form-horizontal">
                                <div class="well">
                                    Cette page vous permet de supprimer une équipe. Attention ! Toute modification est irréversible.
                                </div>
                                <h4><strong>Sélectionner l'équipe : </strong></h4>
                                <div class="row">
                                    <div class="form-group">
                                        
                                        <label class='col-xs-3 control-label'>Délégation :</label>
                                        <div class='col-xs-6'>
                                             <%-- affiche la liste des délégations et sélectionne la délégation voulue--%>
                                            <select class="form-control" id='selectDelegationSupp'>
                                                <option value="">Choix</option>
                                                <%
                                                    for (i = 0; i < lesDelegations.size(); i++) {
                                                        String pays = lesDelegations.get(i).getPays();
                                                %>      <option value='<%=pays%>' <% if (pays.equals(request.getAttribute("delegationSup"))) {%> selected<%}%>><%=pays%></option>
                                                <%
                                                    };
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group">
                                        <label class='col-xs-3 control-label'>Equipe :</label>
                                        <div class='col-xs-6'>
                                             <%-- affiche la liste des équipes de la délégation supprimable (qui ne sont pas inscrites à une épreuve terminée)--%>
                                            <% ArrayList<Equipe> lesEquipesSup =(ArrayList<Equipe>) session.getAttribute("lesEquipesSup");%>
                                            <select class="form-control" id='selectEquipeSupp'<%if(lesEquipesSup ==null){%>disabled="true"<%}%>>
                                                <option value="">Choix</option>
                                                <%
                                                
                                                if(lesEquipesSup !=null){
                                                    for(i=0;i<lesEquipesSup.size();i++){
                                                        String nomEquipetemp= "";
                                                            if(lesEquipesSup.get(i).getNomEquipe()!=null){
                                                                nomEquipetemp=lesEquipesSup.get(i).getNomEquipe();
                                                            }
                                                       int idEquipetemp = lesEquipesSup.get(i).getIdEquipe();
                                                %>          <option value='<%=idEquipetemp%>'><%=idEquipetemp%> : <%=nomEquipetemp%> </option> 
                                                    <%}
                                                }
                                                 %>
                                                
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class="form-group">
                                        <div class='col-xs-offset-3 col-xs-6'>
                                            <button type="button" class="btn btn-danger btn-block" id="supprimerEquipe">Supprimer l'équipe&nbsp;<span class="glyphicon glyphicon-trash"></span></button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>        
                </div>
                                                 
                                                 
                                                 

                 <footer class="footer">
                            <%! Date dateDuJour;%>
                            <% dateDuJour = new Date();%>
                            <p class='text-muted pull-right'><i> Date de dernière mise à jour : <%= dateDuJour%></i></p>
                            <p class="text-muted">&copy; Master 2 CCI Grenoble : Groupe2</p>
                        </footer>
            </div>
        </div>
        <script>

            $(document).ready(function () {
                $("#tabs").tabs();
                <%--permet d'afficher le bon tab --%>
                $("#tabs").tabs({
                    active: <%=tab%>
                });
            });
        </script>
        <script type="text/javascript" src="js/cyberCompetition.js"></script>
        <script src="js/jsAdministreEquipe.js" type="text/javascript"></script>
    </body>
</html>
