# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #
  # Variables
  #

  # Editor by Ace
  editor = null

  #
  # Utilities
  #

  # Evalate javascript in iframe.
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
  onEvalClicked = ->
    iframe_obj = window["stage"]
    program = editor.getSession().getValue()
    $(iframe_obj.window["program"]).val(program)

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

  #
  # Main
  #

  if $("#editor").length != 0
    setup_editor("editor", $("#editor").hasClass("read-only"))

  if $("#eval").length != 0
    $("#eval").click(onEvalClicked)
