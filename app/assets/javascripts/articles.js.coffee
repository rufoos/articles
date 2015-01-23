object_size = (the_object) ->
  count = 0
  for key in the_object
    count++ if the_object.hasOwnProperty(key)
  return count

show_message = (message, type) ->
  $("#alert").show().removeClass("alert-success alert-error").addClass("alert-#{type}").html(message)

$ ->
  $("#search_articles").submit (e) ->
    $.ajax
      url: $(this).attr("action")
      data: $(this).serialize()
      dataType: "html"
      success: (data) ->
        $("#wrap_table").html(data)
        $("#wrap_article").empty()
    e.preventDefault()

  $(".load-article").click (e) ->
    $.ajax
      url: $(this).attr("href")
      dataType: "html"
      success: (data) ->
        $("#wrap_article").html(data)
    e.preventDefault()

  $("#article_category_title").each ->
    $(this).autocomplete
      source: $(this).data("autocomplete-path")

  $(".datepicker").datepicker()

  $(".edit-article").click (e) ->
    $.ajax
      url: $(this).attr("href")
      dataType: "html"
      success: (data) ->
        $("#main_container").html(data)
    e.preventDefault()

  $("form").on "ajax:success", (xhr, data, status) ->
    if object_size(data.errors) != 0
      html_errors = "<ul>"
      for field, errors of data.errors
        html_errors += "<li>#{error}</li>" for error in errors
      html_errors += "</ul>"
      show_message(html_errors, "error")
    else
      for type, msg of data.flash
        show_message(msg, type)
  .on "ajax:error", (xhr, data, status) ->
    console.log status