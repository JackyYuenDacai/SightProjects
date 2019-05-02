package api;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_access.data_interface.StaffLocation;
import data_access.data_impl.pop_impl;
import data_access.data_impl.staff_location_impl;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class get_staff_list
 */
public class get_staff_list extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	StaffLocation StaffReal = new StaffLocation();
    public get_staff_list() {
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
		ArrayList<staff_location_impl> staffOptained = StaffReal.getStaffList(request.getParameter("location"));
		for(staff_location_impl a : staffOptained) {
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
		doGet(request, response);
	}

}
