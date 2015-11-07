# Main navigation handling
$(document).ready ->
  nav_toggler = $("header .toggle-nav")
  nav = $("#main-nav")
  content = $("#content")
  body = $("body")
  click_event = (if jQuery.support.touch then "tap" else "click")

  $("#main-nav .dropdown-collapse").on click_event, (e) ->
    e.preventDefault()
    link = $(this)
    list = link.parent().find("> ul")

    if list.is(":visible")
      if body.hasClass("main-nav-closed") && link.parents("li").length == 1
        false
      else
        link.removeClass("in")
        list.slideUp 300, ->
          $(this).removeClass("in")
    else
      $(document).trigger("nav-open") if list.parents("ul.nav.nav-stacked").length == 1
      link.addClass("in")
      list.slideDown 300, ->
        $(this).addClass("in")
    false

  if jQuery.support.touch
    nav.on "swiperight", (e) ->
      $(document).trigger("nav-open")
    nav.on "swipeleft", (e) ->
      $(document).trigger("nav-close")

  nav_toggler.on click_event, ->
    if nav_open()
      $(document).trigger("nav-close")
    else
      $(document).trigger("nav-open")
    false

  # callbacks
  $(document).bind "nav-close", (event, params) ->
    body.removeClass("main-nav-opened").addClass("main-nav-closed")
    nav_open = false

  $(document).bind "nav-open", (event, params) ->
    body.addClass("main-nav-opened").removeClass("main-nav-closed")
    nav_open = true

@nav_open = ->
  return $("body").hasClass("main-nav-opened") || $("#main-nav").width() > 50

# JS plugins initializations
$(document).ready ->
  setTimeAgo()
  setScrollable()
  setSortable($(".sortable"))
  setSelect2()
  setAutoSize()
  setCharCounter()
  setMaxLength()
  setValidateForm()

  # --------------------------------------------------------------------------------------------------------------------
  # removes .box after click on .box-remove button
  $(".box .box-remove").live "click", (e) ->
    $(this).parents(".box").first().remove()
    e.preventDefault()
    return false

  # hides .box after click on .box-collapse
  $(".box .box-collapse").live "click", (e) ->
    box = $(this).parents(".box").first()
    box.toggleClass("box-collapsed")
    e.preventDefault()
    return false
  # --------------------------------------------------------------------------------------------------------------------

  $('.pwstrength').pwstrength(showVerdicts: false) if jQuery().pwstrength

  # --------------------------------------------------------------------------------------------------------------------
  # check all checkboxes in table with class only-checkbox
  $(".check-all").live "click", (e) ->
    $(this).parents("table:eq(0)").find(".only-checkbox :checkbox").attr "checked", @checked
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up responsive tabs
  $('.nav-responsive.nav-pills, .nav-responsive.nav-tabs').tabdrop() if jQuery().tabdrop
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up datatables
  setDataTable($(".data-table"))
  setDataTable($(".data-table-column-filter"))
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up basic wysiwyg
  $('.wysihtml5').wysihtml5() if jQuery().wysihtml5
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up sortable list
  $('.dd-nestable').nestable() if jQuery().nestable
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # affixing main navigation
  unless $("body").hasClass("fixed-header")
    if jQuery().affix
      $('#main-nav.main-nav-fixed').affix
        offset: 40
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up bootstrap popovers
  touch = false
  if window.Modernizr
    touch = Modernizr.touch
  unless touch
    $("body").on "mouseenter", ".has-popover", ->
      el = $(this)
      if el.data("popover") is `undefined`
        el.popover
          placement: el.data("placement") or "top"
          container: "body"
      el.popover "show"

    $("body").on "mouseleave", ".has-popover", ->
      $(this).popover "hide"
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting up bootstrap tooltips
  touch = false
  if window.Modernizr
    touch = Modernizr.touch
  unless touch
    $("body").on "mouseenter", ".has-tooltip", ->
      el = $(this)
      if el.data("tooltip") is `undefined`
        el.tooltip
          placement: el.data("placement") or "top"
          container: "body"
      el.tooltip "show"

    $("body").on "mouseleave", ".has-tooltip", ->
      $(this).tooltip "hide"
  # --------------------------------------------------------------------------------------------------------------------

  if window.Modernizr && Modernizr.svg == false
    $("img[src*=\"svg\"]").attr "src", ->
      $(this).attr("src").replace ".svg", ".png"

  # --------------------------------------------------------------------------------------------------------------------
  # color pickers
  if jQuery().colorpicker
    $(".colorpicker-hex").colorpicker format: "hex"
    $(".colorpicker-rgb").colorpicker format: "rgb"
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # datetimepickers
  if jQuery().datetimepicker
    $(".datetimepicker").datetimepicker()

    $(".datepicker").datetimepicker
      pickTime: false

    $(".timepicker").datetimepicker
      pickDate: false
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # setting bootstrap file input
  $('input[type=file]').bootstrapFileInput() if jQuery().bootstrapFileInput
  # --------------------------------------------------------------------------------------------------------------------

  # --------------------------------------------------------------------------------------------------------------------
  # modernizr fallbacks
  if window.Modernizr
    unless Modernizr.input.placeholder
      $("[placeholder]").focus(->
        input = $(this)
        if input.val() is input.attr("placeholder")
          input.val ""
          input.removeClass "placeholder"
      ).blur(->
        input = $(this)
        if input.val() is "" or input.val() is input.attr("placeholder")
          input.addClass "placeholder"
          input.val input.attr("placeholder")
      ).blur()
      $("[placeholder]").parents("form").submit ->
        $(this).find("[placeholder]").each ->
          input = $(this)
          input.val ""  if input.val() is input.attr("placeholder")
  # --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# character counter
@setMaxLength = (selector = $(".char-max-length")) ->
  selector.maxlength() if jQuery().maxlength
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# character counter
@setCharCounter = (selector = $(".char-counter")) ->
  if jQuery().charCount
    selector.charCount
      allowed: selector.data("char-allowed")
      warning: selector.data("char-warning")
      cssWarning: "text-warning"
      cssExceeded: "text-error"
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# autosize feature for expanding textarea elements
@setAutoSize = (selector = $(".autosize")) ->
  selector.autosize() if jQuery().autosize
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# timeago feature converts static time to dynamically refreshed
@setTimeAgo = (selector = $(".timeago")) ->
  if jQuery().timeago
    jQuery.timeago.settings.allowFuture = true
    jQuery.timeago.settings.refreshMillis = 60000
    selector.timeago();
    selector.addClass("in")
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# scrollable boxes
@setScrollable = (selector = $(".scrollable")) ->
  if jQuery().slimScroll
    selector.each (i, elem) ->
      $(elem).slimScroll
        height: $(elem).data("scrollable-height")
        start: $(elem).data("scrollable-start") || "top"
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# jquery-ui sortable
@setSortable = (selector = null) ->
  if selector
    selector.sortable
      axis: selector.data("sortable-axis")
      connectWith: selector.data("sortable-connect")
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# select2
@setSelect2 = (selector = $(".select2")) ->
  if jQuery().select2
    selector.each (i, elem) ->
      $(elem).select2()
# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# datatables
@setDataTable = (selector) ->
  if jQuery().dataTable
    selector.each (i, elem) ->
      if $(elem).data("pagination-top-bottom") == true
        sdom = "<'row datatables-top'<'col-sm-6'l><'col-sm-6 text-right'pf>r>t<'row datatables-bottom'<'col-sm-6'i><'col-sm-6 text-right'p>>"
      else if $(elem).data("pagination-top") == true
        sdom = "<'row datatables-top'<'col-sm-6'l><'col-sm-6 text-right'pf>r>t<'row datatables-bottom'<'col-sm-6'i><'col-sm-6 text-right'>>"
      else
        sdom = "<'row datatables-top'<'col-sm-6'l><'col-sm-6 text-right'f>r>t<'row datatables-bottom'<'col-sm-6'i><'col-sm-6 text-right'p>>"

      dt = $(elem).dataTable
        sDom: sdom
        sPaginationType: "bootstrap"
        "iDisplayLength": $(elem).data("pagination-records") || 10
        oLanguage:
          sLengthMenu: "_MENU_ records per page"
      dt.columnFilter() if $(elem).hasClass("data-table-column-filter")
      dt.closest('.dataTables_wrapper').find('div[id$=_filter] input').css("width", "200px");
      dt.closest('.dataTables_wrapper').find('input').addClass("form-control input-sm").attr('placeholder', 'Search')

# --------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------
# form validation
@setValidateForm = (selector = $(".validate-form")) ->
  if jQuery().validate
    selector.each (i, elem) ->
      $(elem).validate
        errorElement: "span"
        errorClass: "help-block has-error"
        errorPlacement: (e, t) ->
          t.parents(".controls").first().append e

        highlight: (e) ->
          $(e).closest('.form-group').removeClass("has-error has-success").addClass('has-error');

        success: (e) ->
          e.closest(".form-group").removeClass("has-error")
# --------------------------------------------------------------------------------------------------------------------