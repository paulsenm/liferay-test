<%@ include file="/init.jsp" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<!-- Load Highcharts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="<%= renderRequest.getContextPath() %>/js/highcharts.js"></script>

<script>
    function drawChart(monthlyDataMarionCo, monthlyDataDeschutesCo) {
    	if (typeof Highcharts === 'undefined') {
            console.error('Highcharts library is not loaded.');
            return;
        }
        Highcharts.chart('chart-container', {
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
            series: [
            	{
	                name: 'Marion County Permits',
	                data: monthlyDataMarionCo
                },
                {
                	name: 'Deschutes County Permits',
                	data: monthlyDataDeschutesCo
                }
            	
            	]
        });
    }
</script>

<%
    // Get the data from the backend
    Map<String, Integer> monthlyDataMarionCo = (Map<String, Integer>) request.getAttribute("monthlyDataMarionCo");
	Map<String, Integer> monthlyDataDeschutesCo = (Map<String, Integer>) request.getAttribute("monthlyDataDeschutesCo");    
	int[] chartDataMarionCo = new int[12];
	int[] chartDataDeschutesCo = new int[12];

    // Prepare the data for the chart
    if (monthlyDataMarionCo != null) {
        for (Map.Entry<String, Integer> entry : monthlyDataMarionCo.entrySet()) {
            int month = Integer.parseInt(entry.getKey());
            chartDataMarionCo[month - 1] = entry.getValue(); // Months are 1-based in SQL
        }
    }
    if (monthlyDataDeschutesCo != null) {
        for (Map.Entry<String, Integer> entry : monthlyDataDeschutesCo.entrySet()) {
            int month = Integer.parseInt(entry.getKey());
            chartDataDeschutesCo[month - 1] = entry.getValue(); // Months are 1-based in SQL
        }
    }
%>

<!-- Highcharts Container -->
<div id="chart-container" style="width: 100%; height: 400px;"></div>

<!-- Initialize the Chart -->
<script>
	window.onload = function() {
	    const monthlyDataMarionCo = <%= java.util.Arrays.toString(chartDataDeschutesCo) %>;
	    const monthlyDataDeschutesCo = <%= java.util.Arrays.toString(chartDataMarionCo) %>;
	
	    drawChart(monthlyDataMarionCo, monthlyDataDeschutesCo);
	}
	function go(){
		drawChart(<%= java.util.Arrays.toString(chartDataDeschutesCo) %>);
	}

</script>
