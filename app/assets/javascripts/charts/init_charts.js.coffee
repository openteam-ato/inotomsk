@init_charts = ->
  $.getScript "https://www.google.com/jsapi", (script, textStatus, jqxhr) ->
    if jqxhr.status is "200"
      google.load "visualization", "1.0",
        packages: [ "corechart" ]
        callback: "drawChart"

drawChart = ->
  charts = $(".chart")
  charts.each (index, chart) ->
    chart_properties = $(chart).get_properties()
    options =
      title: chart_properties.title or ""
      width: "680"
      height: "500"
      fontName: "Verdana"
      backgroundColor: "#f7f7fa"
      legend:
        position: "right"
        textStyle:
          fontSize: "12"
      chartArea:
        width: "480"

    data = new google.visualization.DataTable()
    data.addColumn "string", chart_properties.labels_title
    $(chart_properties.values_title).each (i, val) ->
      data.addColumn "number", val

    data.addRows chart_properties.data
    chart_object = new google.visualization[chart_properties.type](chart)
    chart_object.draw data, options

$.fn.get_type = ->
  classes = @attr("class")
  return "BarChart"  unless classes.indexOf("bar") is -1
  return "ColumnChart"  unless classes.indexOf("column") is -1
  return "LineChart"  unless classes.indexOf("line") is -1
  return "PieChart"  unless classes.indexOf("pie") is -1
  "unknown"

$.fn.get_data = ->
  chart = this
  multi = $(chart).hasClass("multi")
  data = []
  chart.find("tbody tr").each (i, val) ->
    collection = []
    row = $(val).find("td")
    row.each (index, item) ->
      if index > 0
        collection.push parseFloat($(item).text())
      else
        collection.push $(item).text()
      return false  if index is 1 and not multi

    data.push collection

  data

$.fn.get_label_title = ->
  @find("th:nth-child(1)").text()

$.fn.get_values_title = ->
  chart = this
  multi = $(chart).hasClass("multi")
  collection = []
  head = chart.find("th")
  if head.length < 1
    if multi
      collection = []
    else
      col_count = chart.find("tr:first td").length
      collection = new Array(col_count - 1)
    return collection
  head.each (i, item) ->
    collection.push $(item).text()  if i > 0
    return false  if i is 1 and not multi

  collection

$.fn.get_properties = ->
  chart = this
  properties = {}
  properties["type"] = chart.get_type()
  properties["data"] = chart.get_data()
  properties["title"] = chart.find("caption").text()
  properties["labels_title"] = chart.get_label_title()
  properties["values_title"] = chart.get_values_title()
  properties
