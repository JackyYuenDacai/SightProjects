package api;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_access.data_interface.addStaff;
import data_access.data_interface.addStudent;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class add_staff
 */
public class add_staff extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	addStaff JSONform = new addStaff();
    public add_staff() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		JSONObject json = new JSONObject();
		json.put("name", request.getParameter("name"));
		json.put("id", request.getParameter("id"));
		json.put("extra", request.getParameter("extra"));
		json.put("tagId", request.getParameter("tagId"));
		
		if(JSONform.submit(json)) {
			Writer out = response.getWriter();
			out.write("success");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
