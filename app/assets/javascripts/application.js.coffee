#= require jquery
#= require jquery-ui
#= require jquery-ui/datepicker-ru
#= require jquery_ujs
#= require twitter/bootstrap
# require_tree .

$.ajaxSetup
	dataType: "json"

$ ->
	$("#top_menu a").click (e) ->
		$("#top_menu li").removeClass("active")
		$(this).closest("li").addClass("active")
		$.ajax
			url: $(this).attr("href")
			dataType: "html"
			success: (data) ->
				$("#main_container").html(data)
		e.preventDefault()