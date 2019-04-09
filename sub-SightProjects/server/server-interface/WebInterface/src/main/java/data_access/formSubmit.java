package data_access;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import data_access.MysqlAccess;
import net.sf.json.JSONObject;

public class formSubmit extends MysqlAccess{
	public boolean submit(JSONObject json) {
		// TODO Auto-generated method stub
		ArrayList<pop_impl> result = new ArrayList<pop_impl>();
		String query = "call submitForm(\'"+json.getString("id")+"\',\'"+json.getString("unitok")+"\',\'"+json.getString("json_form")+"\');";
		ResultSet rs = this.executeQuery(query, null);
		if(rs != null)
		return true;
		else
		return false;
	}
	
};