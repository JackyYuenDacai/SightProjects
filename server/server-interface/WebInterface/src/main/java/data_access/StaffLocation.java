package data_access;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import data_access.MysqlAccess;
import net.sf.json.JSONObject;
public class StaffLocation extends MysqlAccess{
	public ArrayList<staff_location_impl> getStaffList(String Location) {
	// TODO Auto-generated method stub
		ArrayList<staff_location_impl> result = new ArrayList<staff_location_impl>();
		String query = "call getStaffList('"+Location+"');";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		try {
			while(rs.next()) {
				result.add(new staff_location_impl(rs.getString("name"),rs.getString("id")));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			this.close();
		}
		return result;
	}
}