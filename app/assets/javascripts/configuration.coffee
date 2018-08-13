# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

del_field_with_button =(buttonId) ->
  delId = buttonId.substr(4)
  $("tr#" + delId).remove();
$(document).on 'turbolinks:load', ->
  $(".del-btn").on "click", ->
    del_field_with_button($(this).attr("id"))

  $(".add-cfg-btn").on "click", ->
    $("#edit-configs").append($("<tr id=\"field-" + tr_idx + "\">")
      .append("<td><input type=\"text\" name=\"key-" + tr_idx + "\"></td>")
      .append("<td><input type=\"text\" name=\"value-" + tr_idx + "\"></td>")
      .append($("<td class=\"del-span\">")
        .append($("<button type=\"button\" id=\"btn-field-" + tr_idx + "\" class=\"btn btn-danger del-btn\"><i class=\"glyphicon glyphicon-trash\"></i>").on "click", ->
          del_field_with_button($(this).attr("id"))
        .append("</button>")
      .append("</td>"))
    ).append("</tr>"));
    tr_idx += 1;
    