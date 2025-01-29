<%@ include file="/init.jsp" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<!-- Load Highcharts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>


<%
	Map<String, Map<String, Integer>> allJurisData = (Map<String, Map<String, Integer>>) request.getAttribute("allJurisData");
	
	StringBuilder chartDataBuilder = new StringBuilder("[");
	for (Map.Entry<String, Map<String, Integer>> entry : allJurisData.entrySet()) {
	    String jurisdiction = entry.getKey();
	    Map<String, Integer> monthlyData = entry.getValue();
	    int[] monthlyCounts = new int[12];
	    for (Map.Entry<String, Integer> monthEntry : monthlyData.entrySet()) {
	        int monthIndex = Integer.parseInt(monthEntry.getKey()) - 1; // Adjust 1-based month
	        monthlyCounts[monthIndex] = monthEntry.getValue();
	    }
	    chartDataBuilder.append("{name: '").append(jurisdiction).append("', data: ")
	                    .append(java.util.Arrays.toString(monthlyCounts)).append("},");
	}
	chartDataBuilder.append("]");
%>


<script>
	let permitChart;
    function drawChart(chartData) {
    	if (typeof Highcharts === 'undefined') {
            console.error('Highcharts library is not loaded.');
            return;
        }
    	
        permitChart = Highcharts.chart('chart-container-permits', {
            chart: {
                type: 'line'
            },
            title: {
                text: 'Construction Frequency Over the Year'
            },
            xAxis: {
                categories: ['January', 'February', 'March', 'April', 'May', 'June', 
                             'July', 'August', 'September', 'October', 'November', 'December'],
                title: {
                    text: 'Month'
                }
            },
            yAxis: {
                title: {
                    text: 'Number of Permits'
                }
            },
            series: chartData
        });
    }
</script>


<!-- Highcharts Container -->
<div id="chart-container-permits" style="width: 100%; height: 400px;"></div>

<!-- Initialize the Chart -->
<script>
//	permitBtn = document.getElementById("layout_com_liferay_site_navigation_menu_web_portlet_SiteNavigationMenuPortlet_13");
//	permitBtn.addEventListener("click", go);
	
	const chartData = <%= chartDataBuilder.toString() %>;
	document.addEventListener('DOMContentLoaded', function() {
	console.log("Adding data to chart: " + chartData);
	   drawChart(chartData);
	});
	function go(){
		console.log("Adding data to chart: " + chartData);
		const chartData = <%= chartDataBuilder.toString() %>;
	    drawChart(chartData);
	}

</script>
