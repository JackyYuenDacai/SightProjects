package data_access.data_impl;

import org.junit.Test;

import net.sf.json.JSONObject;

public class pop_impl{
	
	String name;
	String id;
	String status;
	String unitok;
	public pop_impl(String name,String id,String status,String unitok){
		this.name =name;
		this.id=id;
		this.status = status;
		this.unitok = unitok;
	}

	@Test
	public void EntityToJson(){
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("name", name);
		jsonObject.put("id", id);
		jsonObject.put("status", status);
		jsonObject.put("unitok", unitok);
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
    	ret.put("status", status);
    	ret.put("unitok", unitok);
    	return ret;
    }
}