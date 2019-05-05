package data_access.data_interface;

import java.sql.ResultSet;

import data_access.MysqlAccess;
import net.sf.json.JSONObject;

public class addStaff extends MysqlAccess{
	public boolean submit(JSONObject json) {
		// TODO Auto-generated method stub
	
		String query = "call addStaff(\'"+json.getString("id")+"\',\'"+json.getString("name")+"\',\'"+json.getString("tagId")+"\',\'"+json.getString("extra")+"\');";
		
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null) {
			this.close();
			return true;
		}
		else {
			this.close();
			return false;
		}
	}
}

