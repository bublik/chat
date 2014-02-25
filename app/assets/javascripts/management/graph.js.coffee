drawChart = ->
  
  # Create the data table.
  data = new google.visualization.DataTable()
  data.addColumn "string", "Date"
  data.addColumn "number", "Chats"
  data.addRows window.graph_data
  
  # Set chart options
  options =
    title: "Chats per Day"
    width: '100%'
    height: 500

  
  # Instantiate and draw our chart, passing in some options.
  chart = new google.visualization.ColumnChart(document.getElementById("graph"))
  chart.draw data, options
  return
google.load "visualization", "1.0",
  packages: ["corechart"]

google.setOnLoadCallback drawChart