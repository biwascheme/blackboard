# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  editor = null

  escape_program = (program) ->


  # Setup editor if #editor exists
  if $("#editor").length != 0
    editor = ace.edit("editor")
    editor.setTheme("ace/theme/cobalt")
    clojureMode = require("ace/mode/clojure").Mode
    editor.getSession().setMode(new clojureMode())

  # On #eval clicked
  if $("#eval").length != 0
    $("#eval").click ->
      program = editor.getSession().getValue()
      $(window["stage"].window["program"]).val(program)

      # Hack needed for IE?
      # http://www.thismuchiknow.co.uk/?p=25
      #   if (!iframe.eval && iframe.execScript) {
      #       iframe.execScript("null");
      #         }

      window["stage"].eval "
        (function(){
          var on_error = function(e){
            console.error(e);
            puts(e);
            throw e;
          };
          var intp = new BiwaScheme.Interpreter(on_error);
          intp.evaluate($('#program').val());
        })();
      "


