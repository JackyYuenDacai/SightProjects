package api;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import data_access.data_impl.record_impl;
import data_access.data_interface.RecordData;

import org.json.CDL;


import net.sf.json.JSONArray;
/**
 * Servlet implementation class record_export
 */
public class record_export extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RecordData recordInterface = new RecordData();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public record_export() {
        super();
        // TODO Auto-generated constructor stub
    }
    public String csvfromJSONArray(String jsonstr) {
    	org.json.JSONArray output;
        try {
            output = new org.json.JSONArray(jsonstr);
            //JSONArray docs = output.getJSONArray("infile");
            String csv = CDL.toString(output);
            return csv;
        } catch (org.json.JSONException e) {
            e.printStackTrace();
        }
		return null;        
    }
    public String getRecord(String id,String time) {
		
		JSONArray jsonObject = new JSONArray();
		ArrayList<record_impl> staffOptained = recordInterface.getRecordList(id,time);
		for(record_impl a : staffOptained) {
			jsonObject.add(a.toJSONObject());
		}
		return(jsonObject.toString());
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Writer out = response.getWriter();
		try {
		out.write(csvfromJSONArray(getRecord(request.getParameter("id"),request.getParameter("time"))));
		}
		catch(Exception ex) {
			ex.printStackTrace();
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
