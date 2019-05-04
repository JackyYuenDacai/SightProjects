package api;

import java.io.IOException;
import java.io.Writer;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_access.data_interface.formSubmit;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class submit_form
 */
public class submit_form extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	formSubmit JSONform = new formSubmit();
    public submit_form() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		JSONObject json = new JSONObject();
		json.put("unitok", request.getParameter("unitok"));
		json.put("id", request.getParameter("id"));
		JSONObject json_form = new JSONObject();
		//json_form.put("select0", request.getParameter("select0"));
		//json_form.put("select1", request.getParameter("select1"));
		//json_form.put("select2", request.getParameter("select2"));
		//json_form string
		//get json body data
		json.put("json_form", String.valueOf(request.getInputStream().readAllBytes()));
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
		JSONObject json = new JSONObject();
		json.put("unitok", request.getParameter("unitok"));
		json.put("id", request.getParameter("id"));
		JSONObject json_form = new JSONObject();
		String body = request.getReader().lines().collect(Collectors.joining());//json_form string
		//get json body data
		json.put("json_form", body);
		if(JSONform.submit(json)) {
			Writer out = response.getWriter();
			out.write("success");
		}
	}

}
