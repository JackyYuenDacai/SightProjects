

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class beaconTest
 */
public class beaconTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public beaconTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		InputStream in = null;
		try {
			in = request.getInputStream();
			String parseReslut = ParseUtils.parse(in);
			System.out.println(parseReslut);
			System.out.println("-----------");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		InputStream in = null;
		try {
			in = request.getInputStream();
			String parseReslut = ParseUtils.parse(in);
			System.out.println(parseReslut);
			System.out.println("-----------");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
