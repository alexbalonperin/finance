$ ->
  $table = $('#companies_table')
  utils = $.fn.bootstrapTable.utils

  operateFormatter = (value, row) ->
    [
      '<a class="show" href="/companies/' + row.id + '" title="show">Show</a> ',

    ].join('')
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
      title: ''
      align: 'center'
      sortable: false
      formatter: operateFormatter
    }
  ] ]

  sort_params = {
    industry: 'industries.name'
    sector: 'sectors.name'
  };
  utils.initTable($table, columns, sort_params)

  return


