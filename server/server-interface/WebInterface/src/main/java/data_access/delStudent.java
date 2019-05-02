package data_access;

import java.sql.ResultSet;

import net.sf.json.JSONObject;

public class delStudent extends MysqlAccess{
	public boolean submit(JSONObject json) {
		// TODO Auto-generated method stub
	
		String query = "call delStudent(\'"+json.getString("id")+"\');";
		
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		return true;
		else
		return false;
	}
}
