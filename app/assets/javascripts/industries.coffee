# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

chart = undefined
$ ->
  options = ({
    chart: {
      backgroundColor: 'transparent'
      type: 'pie'
    }
    title: {
      text: null
    }
    colors: [@blue, @green, @yellow, @red, @blue_green]
    series: [{}]
  })

  $chart = $('#industry_chart')
  url = $chart.data('url')
  $.getJSON url, (data) ->
    options.series[0].data = data
    chart = $('#industry_chart').highcharts(options)
    return
