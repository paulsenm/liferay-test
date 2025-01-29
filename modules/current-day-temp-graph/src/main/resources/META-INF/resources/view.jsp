<%@ include file="/init.jsp" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<!-- Load jQuery and Highcharts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>

<script>
	let tempHourlyChart;
    function initializeHC(tempDataHourly) {
        // Check if Highcharts is loaded
        if (typeof Highcharts === 'undefined') {
            console.error('Highcharts library is not loaded.');
            return;
        }

        console.log('Initializing Highcharts...');

        if(tempHourlyChart){
        	tempHourlyChart.destroy();
        }
        // Highcharts configuration
        tempHourlyChart = Highcharts.chart('chart-container-temp-hourly', {
            chart: {
                type: 'area'
            },
            title: {
                text: 'Temperature Data'
            },
            xAxis: {
                title: {
                    text: 'Time'
                } ,
                labels:{
                	enabled: false
                }
            },
            yAxis: {
                title: {
                    text: 'Temperature (°C)'
                }
            },
            series: [
                {
                    name: 'Portland',
                    //data: [1, 2, 3, 4, 5, 6, 7]
                	data: tempDataHourly
                }
            ]
        });
    }
</script>

<%
    // Retrieve attributes set by the backend
    String temperature = (String) request.getAttribute("temperature");
    String condition = (String) request.getAttribute("condition");
    List<String> tempList = (List<String>) request.getAttribute("tempList");
    List<Integer> tempListInt = (List<Integer>) request.getAttribute("tempListInt");
    String error = (String) request.getAttribute("error");

    // Debugging: log attributes to ensure they are being set correctly
    if (temperature == null || condition == null || tempList == null) {
        System.out.println("Temperature, condition, or tempList is null.");
    } else {
        System.out.println("Temperature: " + temperature);
        System.out.println("Condition: " + condition);
    }
%>

<!-- Weather Widget -->
<div class="weather-widget border border-primary">
    <% if (error != null) { %>
        <!-- Display error message -->
        <p><strong>Error:</strong> <%= error %></p>
    <% } else { %>
        <!-- Highcharts Container -->
        <div id="chart-container-temp-hourly" style="width: 100%; height: 400px;"></div>
        
        <!-- Display Weather Details -->
        <h2>Current Weather</h2>
        <p><strong>Temperature:</strong> <%= temperature != null ? temperature : "N/A" %></p>
        <p><strong>Condition:</strong> <%= condition != null ? condition : "N/A" %></p>
     <% } %>
  <script>
  document.addEventListener('DOMContentLoaded', function () {
      const tempDataHourly = <%= tempListInt != null ? tempListInt.toString() : "[]" %>;
      console.log('Temperature data: ', tempDataHourly);
      initializeHC(tempDataHourly);
  });
</script>
</div>

<!-- Call the initializeHC function on window load -->

