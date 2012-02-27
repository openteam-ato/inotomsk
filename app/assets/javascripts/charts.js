$.fn.get_type = function(){
  var classes = this.attr('class');

  if (classes.indexOf('bar') != -1) {
    return 'BarChart';
  };

  if (classes.indexOf('column') != -1) {
    return 'ColumnChart';
  };

  if (classes.indexOf('line') != -1) {
    return 'LineChart';
  };

  if (classes.indexOf('pie') != -1) {
    return 'PieChart';
  };

  return 'unknown';
};

$.fn.get_data = function(){
  var chart = this;
  var data= [];

  chart.find('tbody tr').each(function(i, val){
    var collection = [];
    var row = $(val).find('td');

    row.each(function(index, item) {
      if (index > 0) {
        collection.push(parseFloat($(item).text())) ;
      } else {
        collection.push($(item).text());
      };
    });
    data.push(collection);
  });

  return data;
};

$.fn.get_label_title = function(){
  return this.find('th:nth-child(1)').text();
};

$.fn.get_values_title = function(){
  var chart = this;
  var collection = [];
  var head = chart.find('th');

  if (head.length < 1) {
    var col_count = chart.find('tr:first td').length;
    collection = new Array(col_count-1);
    return collection;
  };

  head.each(function(i, item) {
    if (i > 0) {
      collection.push($(item).text());
    };
  });

  return collection;
};


$.fn.get_properties = function(){
  var chart = this;
  var properties = {};

  properties['type'] = chart.get_type();
  properties['data'] = chart.get_data();
  properties['title'] = chart.find('caption').text();
  properties['labels_title'] = chart.get_label_title();
  properties['values_title'] = chart.get_values_title();

  return properties;
};

function drawChart(){
  var charts = $('.chart');

  charts.each(function(index, chart) {
    var chart_properties = $(chart).get_properties();

    var options = {
      'title':  chart_properties.title || '',
      'width':  '680',
      'height': '500',
      'fontName': 'Verdana',
      'backgroundColor': '#f7f7fa',
      'legend': { position: 'right', textStyle: { fontSize: '12' } },
      'chartArea': { width: '480' }
    };

    var data = new google.visualization.DataTable();

    data.addColumn('string', chart_properties.labels_title);

    $(chart_properties.values_title).each(function(i, val) {
      data.addColumn('number', val);
    });

    data.addRows(chart_properties.data);

    var chart_object = new google.visualization[chart_properties.type](chart);
    chart_object.draw(data, options);
  });
};

$(function(){
  var chart = $('.chart');
  if (chart.length > 0) {
    $.getScript('https://www.google.com/jsapi', function(script, textStatus, jqxhr){
      if (jqxhr.status == '200') {
        google.load('visualization', '1.0', {'packages':['corechart'], 'callback': 'drawChart'});
      };
    });
  };
});
