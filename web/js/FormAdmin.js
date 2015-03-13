/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$("#valCreer").on('click', function () {
    
    var delegation = document.getElementById("selectionDelegationCreer").value;
    var nomEquipe = document.getElementById("nomEquipeCreer").value;
    var categorie = $('input:radio[name=radioType]:checked').val();
    if(delegation === "") { 
         document.getElementById("verifDelegationCreer").innerHTML="<span class='glyphicon glyphicon-remove'></span>";
    }else{
       document.getElementById("verifDelegationCreer").innerHTML="";
       document.location.href="GetListDelegation?delegation="+delegation+"&nomEquipe="+nomEquipe+"&categorie="+categorie;
    }
    
});

$("#validerCreerEquipe").on('click', function () {
   var nbSportif=1;
   var sportifsSontSelectionner= true;
   var url ="CreerEquipe?";
   $("select[name='selectNomAjouter']").each(function (){
       if($(this).val()===""){
            sportifsSontSelectionner = false ; 
       }else{
           if (nbSportif ===1){
                url = url + "sportifSelect"+nbSportif+"="+$(this).val();
           }else{
                url = url + "&sportifSelect"+nbSportif+"="+$(this).val();   
           }
           nbSportif++;
       }
   });
   
   if (sportifsSontSelectionner === false){
       document.getElementById("ControlValAjouterSportif").innerHTML="Selectionner tout les sportifs";
   }else{
        document.location.href=url;
   }
});


$("select[name='selectNomAjouter']").on('change',function (){
    var nbDeSportifIdentique =0;
    if($(this).val()!==""){
       var idSprotifChange =$(this).val();
      $("select[name='selectNomAjouter']").each(function (){
         if(idSprotifChange === $(this).val()){
             nbDeSportifIdentique++;
         }
      }); 
    }
    if (nbDeSportifIdentique >1){
        $(this).val("");
        document.getElementById("ControlValAjouterSportif").innerHTML="Sportif deja present";
    }else{
        document.getElementById("ControlValAjouterSportif").innerHTML="";
    }
});


$("#annulerCreerSpoptif").on('click', function () {
    document.location.href="GetListDelegation";
});

$("#valAjouterSportif").on('click', function () {
   var nbSportif=1;
   var sportifsSontSelectionner= true;
   var url ="AddSportif?";
   $("select[name='selectNomAjouter']").each(function (){
       if($(this).val()===""){
            sportifsSontSelectionner = false ; 
       }else{
           if (nbSportif ===1){
                url = url + "sportifSelect"+nbSportif+"="+$(this).val();
           }else{
                url = url + "&sportifSelect"+nbSportif+"="+$(this).val();   
           }
           nbSportif++;
       }
   });
   
   if (sportifsSontSelectionner === false){
       document.getElementById("ControlValAjouterSportif").innerHTML="Selectionner tout les sportifs";
   }else{
        document.location.href=url;
   }
});

$("button[name='valSupprimerSportif']").on('click', function () {
    var nbSportif=1;
    var idSportifASuprimer = $("#selectNomAjouter"+$(this).val()).val();
    var url = "SupSportif?idSportifASuprimer="+idSportifASuprimer;
    $("select[name='selectNomAjouter']").each(function (){
       if($(this).val()===""){
       }else{
            url = url + "&sportifSelect"+nbSportif+"="+$(this).val();
            nbSportif++;
       }
   });
    document.location.href=url;
});

$("#selectionDelegationCreer").on('change', function () {
    var delegation = document.getElementById("selectionDelegationCreer").value;
    if(delegation === "") {
        document.getElementById("verifDelegationCreer").innerHTML="<span class='glyphicon glyphicon-remove'></span>";
    }else{
        document.getElementById("verifDelegationCreer").innerHTML="";
    }
});



/* Chargement des informations dans listequipe et listeAjoutSportif */
$("select[name='selectDelegationModifier']").on('change', function () {
    var delegation = document.getElementById("selectDelegationModifier").value;
    if (delegation !== "") {
        document.getElementById('selectEquipeModifier').options.length=1;
        $("#selectEquipeModifier").load("GetListEquipeDUneDelegation?delegation="+delegation);
        document.getElementById("selectEquipeModifier").disabled = false;
    }
    if (delegation !== "") {
        document.getElementById('selectNomAjouter').options.length=1;
        $("#selectNomAjouter").load("GetListSportifParDelgation?delegation="+delegation);
        
    }
});


/* Chargement des informations dans listeSuprSportif */
$("#selectEquipeModifier").on('change', function (){
    var idEquipe = document.getElementById("selectEquipeModifier").value;
    if (idEquipe !== "") {
        //document.getElementById('selectNomASuprimer').options.length=1;
        $("#selectNomASuprimer").load("GetListSportifParEquipe?idEquipe="+idEquipe);
        document.getElementById("selectNomAjouter").disabled = false;
        document.getElementById("selectNomASuprimer").disabled = false;
    }
});


    
/* Chargement des informations dans listequipe    */      
$("#selectDelegationSupp").on('change', function () {
   var delegation = document.getElementById("selectDelegationSupp").value;
   if (delegation !== "") {
         document.getElementById('selectEquipeSupp').options.length=1;
         $("#selectEquipeSupp").load("GetListEquipeDUneDelegation?delegation="+delegation);
         document.getElementById("selectEquipeSupp").disabled = false;
    }
});

//$("select[name='selectDelegationModifier']").on('change', function () {
//    var delegation = document.getElementById("selectDelegationModifier").value;
//    if (delegation !== "") {
//        $("#selectEquipeModifier").load("GetListEquipeDUneDelegation?delegation="+delegation);
//        document.getElementById("selectEquipeModifier").disabled = false;
//    }
//    if (delegation !== "") {
//        $("#selectNomAjouter").load("GetListSportifParDelgation?delegation="+delegation);
//    }
//});