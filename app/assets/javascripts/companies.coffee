$ ->
  $table = $('#table')
  utils = $.fn.bootstrapTable.utils

  columns = [ [
    {
      field: 'symbol'
      title: 'Symbol'
    }
    {
      field: 'name'
      title: 'Name'
      align: 'left'
    }
    {
      field: 'industry'
      title: 'Industry'
      align: 'left'
    }
    {
      field: 'sector'
      title: 'Sector'
      align: 'left'
    }
    {
      title: 'Actions'
      align: 'center'
#      events: actionEvents
    }
  ] ]
  utils.initTable($table, columns)
  return


