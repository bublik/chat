drawChart = ->
  
  # Create the data table.
  data_agent = new google.visualization.DataTable()
  data_agent.addColumn "string", "Date"
  data_agent.addColumn "number", "Chats"
  data_agent.addRows window.graph_data_agent
  
  # Set chart options
  options_agent =
    title: "Chats per Day (for Agent)"
    width: '100%'
    height: 500
    hAxis:
      textStyle:
        fontSize: 10

  
  # Instantiate and draw our chart, passing in some options.
  chart_agent = new google.visualization.AreaChart(document.getElementById("graph-agent"))
  chart_agent.draw data_agent, options_agent

  # Create the data table.
  # data_users = new google.visualization.DataTable()
  # data_users.addColumn "string", "Date"
  # data_users.addColumn "number", "Chats"
  # data_users.addRows window.graph_data_users
  data_users = google.visualization.arrayToDataTable window.graph_data_users
  
  # Set chart options
  options_users =
    title: "Chats per Day (for Users)"
    width: '100%'
    height: 500
    hAxis:
      textStyle:
        fontSize: 10

  
  # Instantiate and draw our chart, passing in some options.
  chart_users = new google.visualization.AreaChart(document.getElementById("graph-users"))
  chart_users.draw data_users, options_users


  return
google.load "visualization", "1.0",
  packages: ["corechart"]

google.setOnLoadCallback drawChart