# TODO: API for load missing content or binding to page events
$ ->
  setup_listener()
  load_missing_content()

setup_listener = ->
  $(document).on 'progressive_load:end', load_missing_content
  $(document).on 'ajax:end', load_missing_content

load_missing_content = ->
  $('[data-progressive-load-placeholder=true]').each ->
    $this = $(this)
    # Don't re-process div's we've already seen
    return if $this.data('progressive-load-setup')
    $this.data('progressive-load-setup', true)

    # Start the load
    $.ajax url: $this.data('progressive-load-path'), cache: false, success: (response) -> 
      $this.html(response); 
      $(document).trigger('progressive_load:end')