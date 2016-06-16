$(function() {
      $('#advcalendar').multiDatesPicker({
                                             dateFormat: 'yy-mm-dd',
                                             firstDay: 1,
                                             minDate: 0,
                                             numberOfMonths: [2,1],
                                             altField: '#dates'
                                         });

      $('.description').css("display", "none");
      $('.toggle-description').click(function () {
                                         $(this).next(".description").slideToggle(400);
                                     });

      $('.play').css("display", "none");
      $('.toggle-play').click(function () {
                                  $(this).next(".play").slideToggle(400);
                              });

      $('[id*=cfg_]').css('display', 'none');

      $('[id*=sel_]').change(function () {
                                 $('#cfg_' + this.id.substring(this.id.indexOf('_') + 1)).css('display', this.checked ? 'block' : 'none');
                             });

      $('#setall').click(function () {
                             $('[id*=start_hour_]').val($('#start_hour').val());
                             $('[id*=start_min_]').val($('#start_min').val());
                             $('[id*=end_hour_]').val($('#end_hour').val());
                             $('[id*=end_min_]').val($('#end_min').val());
                             $('[id*=interval_]').val($('#interval').val());
                         });

      $(':checkbox[id*=sel_]').click(function(){
                                         generate_options_checkbox(this.id);
                                     });

      generate_options_select($('#start_hour').attr('id'),0,23,2,8);
      generate_options_select($('#start_min').attr('id'),0,59,2,0);
      generate_options_select($('#end_hour').attr('id'),0,23,2,22);
      generate_options_select($('#end_min').attr('id'),0,59,2,0);
      generate_options_select($('#interval').attr('id'),1,1440,2,10);
      hide_options($('#start_hour'), $('#end_hour'), $('#start_min'), $('#end_min'));
      $('#start_hour').hover(function(){
                                 hide_options($('#start_hour'),$('#end_hour'), $('#start_min'), $('#end_min'));
                                 if ($("#start_hour").val() == $("#end_hour").val()){
                                     if ($("#start_min").val() > $("#end_min").val()){
                                         $("#start_min").val($("#end_min").val());
                                     }
                                 }
                             });
      $('#end_hour').hover(function(){
                               hide_options($('#start_hour'),$('#end_hour'), $('#start_min'), $('#end_min'));
                               if ($("#start_hour").val() == $("#end_hour").val()){
                                   if ($("#start_min").val() > $("#end_min").val()){
                                       $("#end_min").val($("#start_min").val());
                                   }
                               }
                           });
      $('#start_min').hover(function(){
                                hide_options($('#start_hour'),$('#end_hour'), $('#start_min'), $('#end_min'));
                            });
      $('#end_min').hover(function(){
                              hide_options($('#start_hour'),$('#end_hour'), $('#start_min'), $('#end_min'));
                          });
      

      $("ul.actions li")
          .mouseenter(function() {
                          $(this).addClass("ui-state-hover");
                      })
          .mouseleave(function() {
                          $(this).removeClass("ui-state-hover");
                      });

  });

function generate_options_checkbox(num){
    var id = num.substring(4);
    generate_options_select("start_hour_" + id,0,23,2,$('#start_hour').val());
    generate_options_select("start_min_" + id,0,59,2,$('#start_min').val());
    generate_options_select("end_hour_" + id,0,23,2,$('#end_hour').val());
    generate_options_select("end_min_" + id,0,59,2,$('#end_min').val());
    generate_options_select("interval_" + id,1,1440,2,$('#interval').val());
    hide_options($("#start_hour_" + id), $("#end_hour_" + id), $("#start_min_" + id), $("#end_min_" + id));
    $("#start_hour_" + id).unbind("hover");
    $("#start_hour_" + id).hover(function(){
                                     hide_options($("#start_hour_" + id), $("#end_hour_" + id), $("#start_min_" + id), $("#end_min_" + id));
                                     if ($("#start_hour_" + id).val() == $("#end_hour_" + id).val()){
                                         if ($("#start_min_" + id).val() > $("#end_min_" + id).val()){
                                             $("#start_min_" + id).val($("#end_min_" + id).val());
                                         }
                                     }
                                 });
    $("#end_hour_" + id).unbind("hover");
    $("#end_hour_" + id).hover(function(){
                                   hide_options($("#start_hour_" + id), $("#end_hour_" + id), $("#start_min_" + id), $("#end_min_" + id));
                                   if ($("#start_hour_" + id).val() == $("#end_hour_" + id).val()){
                                       if ($("#start_min_" + id).val() > $("#end_min_" + id).val()){
                                           $("#end_min_" + id).val($("#start_min_" + id).val());
                                       }
                                   }
                               });
    $("#start_min_" + id).unbind("hover");
    $("#start_min_" + id).hover(function(){
                                    hide_options($("#start_hour_" + id), $("#end_hour_" + id), $("#start_min_" + id), $("#end_min_" + id));
                                });
    $("#end_min_" + id).unbind("hover");
    $("#end_min_" + id).hover(function(){
                                  hide_options($("#start_hour_" + id), $("#end_hour_" + id), $("#start_min_" + id), $("#end_min_" + id));
                              });
}

function hide_options(start_hour, end_hour, start_min, end_min){
    var opt_hour = $(end_hour).children();
    $.each(opt_hour,function(index, value){
               if($(value).val() < $(start_hour).val()){
                   $(value).hide();
               } else {
                   $(value).show();
               }
           });
    opt_hour = $(start_hour).children();
    $.each(opt_hour,function(index, value){
               if($(value).val() > $(end_hour).val()){
                   $(value).hide();
               } else { 
                   $(value).show();
               }
           });
    if ($(start_hour).val() == $(end_hour).val()){
        var opt_min = $(end_min).children();
        $.each(opt_min,function(i, v){
                   if($(v).val() < $(start_min).val()){
                       $(v).hide();
                   } else {
                       $(v).show();
                   }
               });
        opt_min = $(start_min).children();
        $.each(opt_min,function(i, v){
                   if($(v).val() > $(end_min).val()){
                       $(v).hide();
                   } else {
                       $(v).show();
                   }
               }); 
    } else {
        $(start_min).children().show();
        $(end_min).children().show();
    }
}

function generate_options_select(id,min,max,long,def){
    if($("#" + id).attr('data-generated') == "0"){
        var i=min;
        var opciones;
        for (i=min;i<=max;i++) {
            opciones = opciones + "<option>" + format(i,long) + "</option>";
        }
        $("#" + id).html(opciones);
        $("#" + id).attr('data-generated','1');
    }
    $("#" + id).val(format(def,long));
}

function format(number, length) {
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }
    return str;
}

function check_days_and_audio() {
    if ($('#dates').val() == ""){
        var dialogDate = $('<div id="dialog-dates" title="No dates"  style="display: none;"><p>Please, choose some dates for the advertisements campaign</p></div>');
        dialogDate.dialog({ modal: true, resizable: false, buttons: [ { text: "Close", click: function() { $( this ).dialog( "close" ); } } ] });
        return false;
    } else {
        if ($(':checked[id*=sel_]').length){
            return true;
        } else {
            var dialogAudio = $('<div id="dialog-audio" title="No audio files"  style="display: none;"><p>Please, choose some audio files for the advertisements campaign</p></div>');
            dialogAudio.dialog({ modal: true, resizable: false, buttons: [ { text: "Close", click: function() { $( this ).dialog( "close" ); } } ] });
            return false;
        }
    }
}
