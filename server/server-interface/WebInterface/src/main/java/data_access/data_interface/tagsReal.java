package data_access.data_interface;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import data_access.MysqlAccess;
import data_access.data_impl.tag_impl;

public class tagsReal extends MysqlAccess{
	public ArrayList<tag_impl> getTagsList(String location) {
	// TODO Auto-generated method stub
		ArrayList<tag_impl> result = new ArrayList<tag_impl>();
		String query = "call getTagsViaLocation(\'"+location+"\');";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		try {
			while(rs.next()) {
				result.add(new tag_impl(rs.getString("token")));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			this.close();
		}
		return result;
	}
}
