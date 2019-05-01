

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_access.StudentReal;
import data_access.staff_location_impl;
import data_access.tag_impl;
import data_access.tagsReal;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class get_tags_list
 */
public class get_tags_list extends HttpServlet {
	private static final long serialVersionUID = 1L;
	tagsReal instanceApi = new tagsReal();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public get_tags_list() {
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
		ArrayList<tag_impl> tagOptained = instanceApi.getTagsList(request.getParameter("location"));
		for(tag_impl a : tagOptained) {
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
