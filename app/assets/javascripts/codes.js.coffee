#
# JavaScript for editing Scheme codes
#

$ ->
  #
  # Variables
  #

  # Editor by Ace
  editor = null

  # A String represents HTML of initial content of iframe
  emptyIframe = null

  # iframe object 
  # Note: this is not the iframe tag, which is $("#stage")[0]
  iframe_obj = window["stage"]

  isOwned = $("#owned").length != 0

  #
  # Utilities
  #

  # Returns current content of the editor.
  get_program = ->
    editor.getSession().getValue()

  # Evalates javascript in iframe.
  eval_in_iframe = (iframe_obj, program) ->
    # Hack needed for old IE?
    # http://www.thismuchiknow.co.uk/?p=25
    if (!iframe_obj.eval && iframe_obj.execScript)
      iframe_obj.execScript("null")

    iframe_obj.eval(program)

  # Setup Ace text editor.
  setup_editor = (name) ->
    editor = ace.edit(name)
    # Theme
    editor.setTheme("ace/theme/cobalt")
    # Mode
    clojureMode = require("ace/mode/clojure").Mode
    editor.getSession().setMode(new clojureMode())
    # OnChange
    editor.getSession().on 'change', ->
      $('#save-as-new').fadeIn()
      editor.getSession().on('change', ->{})

  #
  # Event handlers
  #

  $('#run').click ->
    # Enable reset button
    $('#reset').removeClass("disabled")
    
    # Reset iframe content
    if emptyIframe
      $("#stage").contents().find('body').html(emptyIframe)
    else
      emptyIframe = $("#stage").contents().find('body').html()

    # Evaluate Scheme program
    $(iframe_obj.window["program"]).val(get_program())
    eval_in_iframe iframe_obj, '''
      (function(){
        var on_error = function(e){
          console.error(e);
          puts(e);
          throw e;
        };
        var intp = new BiwaScheme.Interpreter(on_error);
        intp.evaluate($('#program').val());
      })();
      '''

  $('#reset').click ->
    # Reload iframe to stop every setInterval() timers
    iframe_obj.location.reload()

  $('#save').click ->
    $.ajax(
      url: "/users/signed_in"
      dataType: "json"
      success: (signedIn) ->
        if signedIn
          if $("#save").val() == "Save"
            # Save
            $("#code-body").val(get_program())
            $("#editor-form").submit()
          else
            # Save as new
            $("#code-body").val(get_program())
            $("#editor-form")[0].action = "/codes/new"
            console.log(["form", $("#editor-form")])
            $("#editor-form").submit()
        else
          $("#modal-please-sign-in").modal(keyboard: true)
    )

    false

  # Modal for asking sign in
  $("#close-please-sign-in").click ->
    $("#modal-please-sign-in").modal('hide')

  #
  # Main
  #

  if $("#editor").length != 0
    setup_editor("editor")
