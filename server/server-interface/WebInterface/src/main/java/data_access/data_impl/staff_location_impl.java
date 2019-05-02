package data_access.data_impl;

import org.junit.Test;

import net.sf.json.JSONObject;

public class staff_location_impl {
	String id;
	String name;
	public staff_location_impl(String name,String id){
		this.name =name;
		this.id=id;
		
	}

	@Test
	public void EntityToJson(){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("name", name);
		jsonObject.put("id", id);
		
		System.out.println(jsonObject.toString());
	}

    /*@Override
    public String toString() {
        return "pop{name='" + name + '\'' + ", id='" + id + '\'' + ", status=" + status + '}';
    }*/
    
    public JSONObject toJSONObject() {
    	JSONObject ret = new JSONObject();
    	ret.put("name", name);
    	ret.put("id", id);

    	return ret;
    }
}
