package data_access;
 
import org.junit.Test;

import net.sf.json.JSONObject;

public class record_impl{
	
	String name;
	String id;
	String time;
	String interval;
	String location;
	String json_data;
	record_impl(String name,String id,String time,String interval,String location,String json_data){
		this.name = name;
		this.id = id;
		this.time = time;
		this.location = location;
		this.json_data = json_data;
		this.interval = interval;
	}

 

    /*@Override
    public String toString() {
        return "pop{name='" + name + '\'' + ", id='" + id + '\'' + ", status=" + status + '}';
    }*/
    
    public JSONObject toJSONObject() {
    	JSONObject ret = new JSONObject();
    	ret.put("name", name);
    	ret.put("id", id);
    	ret.put("time", time);
    	ret.put("location", location);
    	ret.put("interval", interval);
    	ret.put("data_json",json_data);
    	return ret;
    }
}