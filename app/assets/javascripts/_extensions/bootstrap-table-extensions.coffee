$ ->
  'use strict'
  $.extend $.fn.bootstrapTable.columnDefaults,
    align: 'center'
    class: 'nowrap'
    sortable: true
  $.extend $.fn.bootstrapTable.utils,
    toPercent: (value) ->
      value + '%'
    toCurrency: (value) ->
      value.toString().commify() + '円'
    commify: (value) ->
      value.toString().commify()
    initTable: (table, col, options = {}) ->
      pageSize = options.pageSize ? 100
      stickyHeader = options.stickyHeader ? true
      paginationVAlign = options.paginationVAlign ? 'both'

      table.bootstrapTable
        pageSize: pageSize
        stickyHeader: stickyHeader
        paginationVAlign: paginationVAlign
        columns: col
      # sometimes footer render error.
      setTimeout (->
        table.bootstrapTable 'resetView'
        return
      ), 200
      $(window).resize ->
        table.bootstrapTable 'resetView'
        return
      return
  return

