# TODO: API for load missing content or binding to page events
$ ->
  setup_listener()
  load_missing_content()

setup_listener = ->
  $(document).on 'progressive_render:end', load_missing_content
  $(document).on 'ajax:end', load_missing_content

load_missing_content = ->
  $('[data-progressive-render-placeholder=true]').each ->
    $this = $(this)
    # Don't re-process div's we've already seen
    return if $this.data('progressive-render-setup')
    $this.data('progressive-render-setup', true)

    # Start the load
    $.ajax url: $this.data('progressive-render-path'), cache: false, success: (response) -> 
      $this.html(response); 
      $(document).trigger('progressive_render:end')