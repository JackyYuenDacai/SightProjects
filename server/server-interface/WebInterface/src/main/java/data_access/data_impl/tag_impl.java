package data_access.data_impl;

import org.junit.Test;

import net.sf.json.JSONObject;

public class tag_impl {
	String id;
	
	public tag_impl(String id){
		
		this.id=id;
		
	}

	@Test
	public void EntityToJson(){
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("id", id);
		
		System.out.println(jsonObject.toString());
	}

    /*@Override
    public String toString() {
        return "pop{name='" + name + '\'' + ", id='" + id + '\'' + ", status=" + status + '}';
    }*/
    
    public JSONObject toJSONObject() {
    	JSONObject ret = new JSONObject();
    	
    	ret.put("id", id);

    	return ret;
    }
}
