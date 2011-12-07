# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # Editor by Ace
  editor = null

  # Setup editor if #editor exists
  if $("#editor").length != 0
    editor = ace.edit("editor")
    editor.setTheme("ace/theme/cobalt")
    clojureMode = require("ace/mode/clojure").Mode
    editor.getSession().setMode(new clojureMode())

    if $("#editor").hasClass("read-only")
      editor.setReadOnly(true)

  # On #eval clicked
  if $("#eval").length != 0
    $("#eval").click ->
      iframe_obj = window["stage"]
      program = editor.getSession().getValue()
      $(iframe_obj.window["program"]).val(program)

      # Hack needed for old IE?
      # http://www.thismuchiknow.co.uk/?p=25
      if (!iframe_obj.eval && iframe_obj.execScript)
        iframe_obj.execScript("null")

      iframe_obj.eval '''
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


