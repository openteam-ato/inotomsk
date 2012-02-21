$.fn.get_properties = function(){
  var chart = $(this);
  var classes = chart.attr('class');
  var data = [];
  var properties = {};

 chart.find('tbody tr').each(function(i, val){
    var collection = [];
    var row = $(val).find('td');
    var key = $(row[0]).text();
    var value = $(row[1]).text();
    collection.push(key);
    collection.push(parseFloat(value));
    data.push(collection);
  });

  properties['title'] = chart.find('caption').text();
  properties['labels_title'] = chart.find('th:nth-child(1)').text();
  properties['values_title'] = chart.find('th:nth-child(2)').text();
  properties['data'] = data;

  if (classes.indexOf('bar') != -1) {
    properties['type'] = 'BarChart';
  };

  if (classes.indexOf('line') != -1) {
    properties['type'] = 'LineChart';
  };

  if (classes.indexOf('pie') != -1) {
    properties['type'] = 'PieChart';
  };

  return properties;
};

function drawChart(){
  var chart = $('.chart');
  var chart_properties = chart.get_properties();

  var options = {
    'title':  chart_properties.title || '',
    'width':  680,
    'height': 520,
    'backgroundColor': '#f7f7fa'
  };

  var data = new google.visualization.DataTable();
  data.addColumn('string', chart_properties.labels_title);
  data.addColumn('number', chart_properties.values_title);
  data.addRows(chart_properties.data);

  var chart_object = new google.visualization[chart_properties.type](chart[0]);

  chart_object.draw(data, options);
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
