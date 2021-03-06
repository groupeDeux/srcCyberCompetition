/* Cette page contient le code permettant de filtrer les epreuves dans la page epreuve */

/* Création des variables pour la recherche de tags */
var $epreuves = $('div.row.rowEpreuve');
var $buttons = $('#buttonsTags');
var tagged = {};

/* Recherche de tag dans les epreuves:
 * Les epreuves contiennent des 'tags' : data-tags
 * La recherche ce fait dans ces data-tags qui sont contenu dans la
 * row qui entoure chaque épreuve.
 * */
$epreuves.each(function () {
    var epreuve = this;
    var tags = $(this).data('tags');

    if (tags) {
        tags.split(',').forEach(function (tagName) {
            if (tagged[tagName] == null) {
                tagged[tagName] = [];
            }
            tagged[tagName].push(epreuve);
        });
    }
});



/* Creation du bouton 'Tout' dans l'id 'buttonsTags' */
$('<li role="presentation" id="toutTag" class="active"><a href="#">Tout<span class="badge"></span></a></li>').appendTo($buttons);

/* Creation des autres boutons en fonction des tags */
$.each(tagged, function (tagName) {
    $('<li role="presentation" id="' + tagName + '"><a href="#">' + tagName + '&nbsp;<span class="badge">' +
            tagged[tagName].length + '</span></a></li>').appendTo($buttons);
});

$("#toutTag").click(function () {
    $epreuves.show();
});

/* Fonction qui permet de faire une recherche dans les filtres quand
 * on clique sur un des boutons contenant un "tagName"
 * Attention, les boutons ont un ID : qui correspond à la catégorie*/
$('li[role="presentation"]').click(function () {
    if ($(this).attr("id") !== null && $(this).attr("id") !=="toutTag") {
        $epreuves.hide().filter(tagged[$(this).attr("id")]).show();
    }
});

/*
 * Fonction qui permet de changer la classe du bouton en active quand on clique dessus
 */
$("li[role='presentation']").click(function () {
    $(this).addClass('active').siblings().removeClass('active');
});



