package api;
import java.io.IOException;
import java.io.Writer;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.json.JSONParser;

import com.mysql.cj.xdevapi.JsonParser;

import data_access.data_impl.pop_impl;
import data_access.data_interface.popReal;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class Class
 */
public class get_pops_list extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	popReal PopReal = new popReal();
    public get_pops_list() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Writer out = response.getWriter();
		JSONArray jsonObject = new JSONArray();
		ArrayList<pop_impl> popOptained = PopReal.getPopList(request.getParameter("location"));
		for(pop_impl a : popOptained) {
			jsonObject.add(a.toJSONObject());
			//jsonObject.
			
		}
		//JSONObject jsonObject = new JSONObject();
		//JSONArray jsonObject= JSONArray.fromObject(popOptained);
		out.write(jsonObject.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
