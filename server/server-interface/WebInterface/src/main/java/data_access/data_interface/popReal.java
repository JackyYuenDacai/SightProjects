package data_access.data_interface;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import data_access.MysqlAccess;
import data_access.data_impl.pop_impl;

public class popReal extends MysqlAccess{

		public ArrayList<pop_impl> getPopList(String Location) {
		// TODO Auto-generated method stub
		ArrayList<pop_impl> result = new ArrayList<pop_impl>();
		String query = "call getPopList(\'"+Location+"\');";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		try {
			while(rs.next()) {
				if(rs!=null)
				result.add(new pop_impl(rs.getString("name"),rs.getString("id"),rs.getString("status"),rs.getString("unitok")));
			}
		}catch (SQLException e) {
			e.printStackTrace();this.close();
		}finally {
		}
		return result;
	}
}