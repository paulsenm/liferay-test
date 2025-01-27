package current.day.temp.graph.portlet;

import current.day.temp.graph.constants.CurrentDayTempGraphPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;


import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;


//import org.json.JSONObject;
//import org.json.JSONArray;
import org.osgi.service.component.annotations.Component;

@Component(
    property = {
        "com.liferay.portlet.display-category=category.sample",
        "com.liferay.portlet.instanceable=true",
        "javax.portlet.display-name=CurrentDayTempGraph",
        "javax.portlet.init-param.template-path=/",
        "javax.portlet.init-param.view-template=/view.jsp",
        "javax.portlet.name=" + CurrentDayTempGraphPortletKeys.CURRENTDAYTEMPGRAPH,
        "javax.portlet.resource-bundle=content.Language",
        "javax.portlet.security-role-ref=power-user,user"
    },
    service = Portlet.class
)
public class CurrentDayTempGraphPortlet extends MVCPortlet {

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {
	    try {
	        // Latitude and Longitude for Portland, OR
	        String latitude = "45.5234";
	        String longitude = "-122.6762";
	        List<String> tempList = new ArrayList<>();
	        List<Integer> tempListInt = new ArrayList<>();
	        String periodObj;

	        // Step 1: Get forecast office and grid
	        String pointsUrl = "https://api.weather.gov/points/" + latitude + "," + longitude;
	        com.liferay.portal.kernel.json.JSONObject pointsResponse = fetchJsonFromUrl(pointsUrl);
	        String forecastUrl = pointsResponse.getJSONObject("properties").getString("forecast");
	        String forecastUrlHourly = pointsResponse.getJSONObject("properties").getString("forecastHourly");

	        // Step 2: Get the forecast data
	        	//14 day forecast data
	        com.liferay.portal.kernel.json.JSONObject forecastResponse = fetchJsonFromUrl(forecastUrl);
	        com.liferay.portal.kernel.json.JSONArray allPeriods = forecastResponse.getJSONObject("properties").getJSONArray("periods");
	        	
	        	//Hourly forecast data
	        com.liferay.portal.kernel.json.JSONObject forecastResponseHourly = fetchJsonFromUrl(forecastUrlHourly);
	        com.liferay.portal.kernel.json.JSONArray allPeriodsHourly = forecastResponseHourly.getJSONObject("properties").getJSONArray("periods");
	        
	        // Extract relevant data
	        com.liferay.portal.kernel.json.JSONObject firstPeriod = allPeriods.getJSONObject(0);
	        String temperature = firstPeriod.getInt("temperature") + "°" + firstPeriod.getString("temperatureUnit");
	        String condition = firstPeriod.getString("shortForecast");
	        
	        periodObj = firstPeriod.toString();
	        
	        for (int i = 0; i < 24; i++) {
	            com.liferay.portal.kernel.json.JSONObject period = allPeriodsHourly.getJSONObject(i);
	            int tempForPeriod = period.getInt("temperature");
	            tempList.add(String.valueOf(tempForPeriod));
	            tempListInt.add(tempForPeriod);
	        }

	        // Set attributes for the JSP
	        renderRequest.setAttribute("temperature", temperature);
	        renderRequest.setAttribute("condition", condition);
	        renderRequest.setAttribute("tempList", tempList);
	        renderRequest.setAttribute("periodObj", periodObj);
	        renderRequest.setAttribute("tempListInt", tempListInt);

	    } catch (Exception e) {
	        e.printStackTrace();
	        renderRequest.setAttribute("error", "Unable to fetch weather data. Please try again later.");
	    }

	    // Call the super class's doView method
	    super.doView(renderRequest, renderResponse);
	}


    private com.liferay.portal.kernel.json.JSONObject fetchJsonFromUrl(String urlString) throws Exception {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("User-Agent", "Liferay-Weather-App");

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // Convert response string to Liferay JSONObject
        return JSONFactoryUtil.createJSONObject(response.toString());
    }
}
