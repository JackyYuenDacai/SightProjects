package data_access;

import java.sql.ResultSet;
import java.util.ArrayList;

import net.sf.json.JSONObject;

public class addStudent extends MysqlAccess{
		public boolean submit(JSONObject json) {
			// TODO Auto-generated method stub
		
			String query = "call addStudent(\'"+json.getString("id")+"\',\'"+json.getString("name")+"\',\'"+json.getString("tagId")+"\',\'"+json.getString("extra")+"\');";
			
			ResultSet rs = this.executeQuery(query, null);
			if(rs != null)
			return true;
			else
			return false;
		}
}
