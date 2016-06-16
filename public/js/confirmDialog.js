function confirmDialog(message, options) {
    var dialogDate = $('<div title="Confirm action" style="display: none;"><p>'+message+'</p></div>');
    dialogDate.dialog({
                          modal: true,
                          resizable: false,
                          buttons: [
                              { text: "No", click: function(){
                                    if (typeof options['action_no'] !== 'undefined')
                                        options['action_no']();
                                    $( this ).dialog( "close" );
                                }
                              },
                              { text: "Yes", click: function(){
                                    if (typeof options['action_yes'] !== 'undefined')
                                        options['action_yes']();
                                    $(this).dialog("close");
                                }
                              }
                          ]
                      });
}
