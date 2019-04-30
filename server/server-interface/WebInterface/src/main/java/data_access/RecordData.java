package data_access;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import data_access.MysqlAccess;
import net.sf.json.JSONObject;
//| token                            | student_id | location | time_in             | time_interval | data_json |
//
public class RecordData extends MysqlAccess{
	public  ArrayList<record_impl> getRecordList(String id,String interval) {
	// TODO Auto-generated method stub
		ArrayList<record_impl> result = new ArrayList<record_impl>();
		String query = "call getUserRecord('"+id+"','"+interval+"');";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		try {
			//(String name,String id,String time,String interval,String location,String json_data){
			while(rs.next()) {
				result.add(new record_impl(rs.getString("name"),
						rs.getString("id"),
						rs.getString("time_in"),
						rs.getString("time_interval"),rs.getString("location"),
						rs.getString("data_json")));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			this.close();
		}
		return result;
	}
}