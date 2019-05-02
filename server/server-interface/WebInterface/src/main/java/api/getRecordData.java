package api;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_access.data_impl.record_impl;
import data_access.data_interface.RecordData;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class getRecordData
 */
public class getRecordData extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RecordData recordInterface = new RecordData();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getRecordData() {
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
		ArrayList<record_impl> staffOptained = recordInterface.getRecordList(request.getParameter("id"),request.getParameter("time"));
		for(record_impl a : staffOptained) {
			jsonObject.add(a.toJSONObject());
			
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
