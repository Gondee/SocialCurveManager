$(document).ready ->
  unless localStorage.getItem("content") == null
    $("#color-settings-body-color").attr("href", localStorage.getItem("content"))

  if (localStorage.getItem("contrast") isnt null) and not $("body").hasClass("contrast-background")
    $("body")[0].className = $("body")[0].className.replace(/(^|\s)contrast.*?(\s|$)/g, " ").replace(/\s\s+/g, " ").replace(/(^\s|\s$)/g, "")
    $("body").addClass localStorage.getItem("contrast")

  $(".color-settings-body-color > a").hover ->
    $("#color-settings-body-color").attr("href", $(this).data("change-to"))
    localStorage.setItem("content", $(this).data("change-to"))

  $(".color-settings-contrast-color > a").hover ->
    $('body')[0].className = $('body')[0].className
      .replace(/(^|\s)contrast.*?(\s|$)/g, ' ')
      .replace(/\s\s+/g, ' ')
      .replace(/(^\s|\s$)/g, '');
    $('body').addClass($(this).data("change-to"))
    localStorage.setItem("contrast", $(this).data("change-to"))