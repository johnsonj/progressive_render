# TODO: API for load missing content or binding to page events
$ ->
  setup_listener()
  load_missing_content()

setup_listener = ->
  $(document).on 'progressive_render:end', load_missing_content
  $(document).on 'ajax:end', load_missing_content
  $(document).on 'turbolinks:load', load_missing_content if window.Turbolinks

load_missing_content = ->
  $('[data-progressive-render-placeholder=true]').each ->
    $this = $(this)
    # Remove the designation on this partial from the DOM so we don't attempt to re-load it later.
    $this.attr('data-progressive-render-placeholder', false)

    # Start the load
    $.ajax url: $this.data('progressive-render-path'), cache: false, success: (response) -> 
      $this.html(response); 
      $(document).trigger('progressive_render:end')
