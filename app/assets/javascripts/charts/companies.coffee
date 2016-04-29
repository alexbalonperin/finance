createChart = undefined
seriesOptions = []
seriesCounter = 0

createChart = ->
  $('#company_chart').highcharts 'StockChart',
    rangeSelector: selected: 4
    yAxis:
      labels: formatter: ->
        (if @value > 0 then ' + ' else '') + @value + '%'
      plotLines: [ {
        value: 0
        width: 2
        color: 'silver'
      } ]
    plotOptions: series: compare: 'percent'
    tooltip:
      pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>'
      valueDecimals: 2
    series: seriesOptions
  return

$ ->
  $chart = $('#company_chart')
  url = $chart.data('url')
  name = $chart.data('name')
  $.getJSON url, (data) ->
    seriesOptions[0] =
      name: name
      data: data
    createChart()
    return
  return