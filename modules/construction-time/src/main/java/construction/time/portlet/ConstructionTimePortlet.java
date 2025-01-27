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
        Map<String, Integer> monthlyDataMarionCo = new HashMap<>();
        Map<String, Integer> monthlyDataDeschutesCo = new HashMap<>();

        // Connect to the database
        Connection connection;

        try {
        	connection = DataAccess.getConnection();
            // Query to aggregate construction permits by month
            String sqlMarionCo = "SELECT MONTH(start_date) AS month, COUNT(*) AS frequency " +
                         "FROM permits_marion_co " +
                         "GROUP BY MONTH(start_date)" +
                         "ORDER BY MONTH(start_date);";
            
            PreparedStatement preparedStatement = connection.prepareStatement(sqlMarionCo);
            ResultSet resultSetMarionCo = preparedStatement.executeQuery();

            // Populate the map with data
            while (resultSetMarionCo.next()) {
                String month = resultSetMarionCo.getString("month");
                int frequency = resultSetMarionCo.getInt("frequency");
                System.out.println("_________Frequency for month: " + month + "was: " + String.valueOf(frequency));
                monthlyDataMarionCo.put(month, frequency);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
        	connection = DataAccess.getConnection();
            // Query to aggregate construction permits by month
            String sqlDeschutesCo = "SELECT MONTH(start_date) AS month, COUNT(*) AS frequency " +
                         "FROM permits_deschutes_co " +
                         "GROUP BY MONTH(start_date)" +
                         "ORDER BY MONTH(start_date);";
            
            PreparedStatement preparedStatement = connection.prepareStatement(sqlDeschutesCo);
            ResultSet resultSetDeschutesCo = preparedStatement.executeQuery();

            // Populate the map with data
            while (resultSetDeschutesCo.next()) {
                String month = resultSetDeschutesCo.getString("month");
                int frequency = resultSetDeschutesCo.getInt("frequency");
                System.out.println("_________Frequency for month: " + month + "was: " + String.valueOf(frequency));
                monthlyDataDeschutesCo.put(month, frequency);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Pass the data to the JSP
        renderRequest.setAttribute("monthlyDataMarionCo", monthlyDataMarionCo);
        renderRequest.setAttribute("monthlyDataDeschutesCo", monthlyDataDeschutesCo);
        super.doView(renderRequest, renderResponse);
    }
}
