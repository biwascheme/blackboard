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
  setup_editor = (name, isReadOnly) ->
    editor = ace.edit(name)
    editor.setTheme("ace/theme/cobalt")
    clojureMode = require("ace/mode/clojure").Mode
    editor.getSession().setMode(new clojureMode())

    if isReadOnly
      editor.setReadOnly(true)

  #
  # Event handlers
  #

  $('#run').click ->
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

  $('#stop').click ->
    # Reload iframe to stop every setInterval() timers
    iframe_obj.location.reload()

  $('#save').click ->
    userNotSignedIn = ->
      $("#modal-please-sign-in").modal(keyboard: true)

    userSignedIn = ->
      $("#code-body").val(get_program())
      $("#editor-form").submit()
    
    $("#close-please-sign-in").click ->
      $("#modal-please-sign-in").modal('hide')

    $.ajax(
      url: "/users/signed_in"
      success: (x) ->
        if x then userSignedIn() else userNotSignedIn()
      dataType: "json"
    )

    false

  #
  # Main
  #

  if $("#editor").length != 0
    setup_editor("editor", $("#editor").hasClass("read-only"))
