package construction.time.portlet;

import construction.time.constants.ConstructionTimePortletKeys;

import com.liferay.portal.kernel.dao.jdbc.DataAccess;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.PortletException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.osgi.service.component.annotations.Component;

@Component(
    property = {
        "com.liferay.portlet.display-category=category.sample",
        "com.liferay.portlet.header-portlet-css=/css/main.css",
        "com.liferay.portlet.instanceable=true",
        "javax.portlet.display-name=ConstructionTime",
        "javax.portlet.init-param.template-path=/",
        "javax.portlet.init-param.view-template=/view.jsp",
        "javax.portlet.name=" + ConstructionTimePortletKeys.CONSTRUCTIONTIME,
        "javax.portlet.resource-bundle=content.Language",
        "javax.portlet.security-role-ref=power-user,user"
    },
    service = Portlet.class
)
public class ConstructionTimePortlet extends MVCPortlet {

    @Override
    public void doView(RenderRequest renderRequest, RenderResponse renderResponse) 
            throws PortletException, java.io.IOException {
    	String[] jurisTitles = {"DESCHUTES_CO", "MARION_CO", "LINCOLN_CO", "MILWAUKIE", "REDMOND", "SPRINGFIELD"};

        Map<String, Map<String, Integer>> allJurisData = new HashMap<>();
        // Query to aggregate construction permits by month
        String sqlVariableJuris = "SELECT MONTH(start_date) AS month, COUNT(*) AS frequency " +
                     "FROM permits_all_juris " +
                     "WHERE  permit_jurisdiction = ? " + 
                     "GROUP BY MONTH(start_date)" +
                     "ORDER BY MONTH(start_date);";
        
        try (Connection connection = DataAccess.getConnection();){
            for (String jurisTitle : jurisTitles) {
            	Map<String, Integer> monthlyData = new HashMap<>();
            	
            	try (PreparedStatement preparedStatement = connection.prepareStatement(sqlVariableJuris)) {
            		preparedStatement.setString(1, jurisTitle);
                    try (ResultSet resultSet = preparedStatement.executeQuery()){
                    	while (resultSet.next()) {
                    		String month = resultSet.getString("month");
                    		int frequency = resultSet.getInt("frequency");
                    		monthlyData.put(month,  frequency);
                    	}
                    }
            	}
            	allJurisData.put(jurisTitle, monthlyData);
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
       

        // Pass the data to the JSP
        renderRequest.setAttribute("allJurisData", allJurisData);
        super.doView(renderRequest, renderResponse);
    }
}
