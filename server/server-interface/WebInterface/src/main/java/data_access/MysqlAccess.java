package data_access;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class MysqlAccess {
	private String url = "jdbc:mysql://localhost:3306/caritas_main?useSSL=false&useUnicode=true&characterEncoding=utf-8";
	private String user = "root";
	private String pwd = "";
	private java.sql.Connection conn = null;
	private PreparedStatement pstmt = null;
	private java.sql.ResultSet rs = null;
	static {
		try {
			java.lang.Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	public void getConnection() {
		
		try {
			
			conn = DriverManager.getConnection(url,user,pwd);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    public java.sql.ResultSet executeQuery(String query,List<Object> params){
		 
		try {
			getConnection();
			pstmt = conn.prepareStatement(query);
			if(params!=null && params.size()>0){
		        for(int i=0;i<params.size();i++){
		            pstmt.setObject(i+1, params.get(i));
		        }
		    }
		    rs = pstmt.executeQuery();
		} catch (SQLException e) {
		    e.printStackTrace();this.close();
		}finally {
			
		}
		return rs;
	}

	public int executeUpdate(String query,List<Object> params){
		int result = 0;
		
		try {
			getConnection();
		    pstmt = conn.prepareStatement(query);
		
		    if(params!=null && params.size()>0){
		        for(int i=0;i<params.size();i++){
		            pstmt.setObject(i+1, params.get(i));
		        }
		    }
		    result = pstmt.executeUpdate();
		} catch (SQLException e) {
		    e.printStackTrace();this.close();
		}finally{
			this.close();
		}
		return result;
	}
	public void close(){        
	    try {
	        if(rs!=null){
	            rs.close();
	            rs = null;
	        }
	        if(pstmt!=null){
	            pstmt.close();
	            pstmt = null;
	        }
	        if(conn!=null){
	            conn.close();
	            conn = null;
	        }
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}
}
