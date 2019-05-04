package data_access.data_interface;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import data_access.MysqlAccess;
import data_access.data_impl.student_impl;
import net.sf.json.JSONObject;
public class StudentReal extends MysqlAccess{
	public ArrayList<student_impl> getStudentList() {
	// TODO Auto-generated method stub
		ArrayList<student_impl> result = new ArrayList<student_impl>();
		String query = "select personnel.id as id, personnel.p_name as name from personnel where personnel.p_role = 1 order by personnel.p_name;";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		try {
			while(rs.next()) {
				result.add(new student_impl(rs.getString("name"),rs.getString("id")));
			}
			this.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			this.close();
		}
		return result;
	}
}