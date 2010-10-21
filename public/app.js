var ANIMATION_TIME = 50;

$(function() {
   $("#tux a").bind("click", function() {
     
     var tux = $(this).children("img");
     var url = $(this).attr("href");
     
     tux.animate({ width: "+=10", height: "+=10", top: "-=5", left: "-=5"}, ANIMATION_TIME);
     tux.animate({ width: "-=10", height: "-=10", top: "+=5", left: "+=5"}, ANIMATION_TIME);
     
     $.ajax({
       type: 'GET',
       url: url,
       success: function(msg) {
         $("#clicks span").html(msg);
       },
       error: function(msg) {
         alert("— Stop insane clicking!\nTerron Gorefiend");
       }
     });
     return false;
   });
   
   $("#why").bind("click", function() {
     $("#fun").fadeIn("fast");
     setTimeout("hideFun()", 2000);
     return false;
   });
   
   var hits = [];
   var max = min = 0;
   var maxWidth = 310;
   $(".hits").each(function() {
     hits.push( parseInt($(this).html()) );
   });
   
   for( var i = 0; i < hits.length; i++) {
     max = Math.max(max, hits[i]);
     min = Math.min(min, hits[i]);
   }
   
   var i = 0;
   $(".line").each(function() {
     var w = hits[i] * maxWidth / max;
     i++;
     $(this).animate({width: w}, 1000);
   });
   
})

function hideFun() {
  $("#fun").fadeOut("fast");
}