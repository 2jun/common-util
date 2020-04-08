  
package com.aj.tool.core.office.param;

/**  
 * ClassName:ColumnParam <br/>  
 * Function: TODO ADD FUNCTION. <br/>  
 * Reason:   TODO ADD REASON. <br/>  
 * Date:     2018年9月13日 下午4:19:12 <br/>  
 * @author   deru_  
 * @version    
 * @since    JDK 1.8  
 * @see        
 */
/**
 * 数据行参数
 */
public class ExeclColumnParam{
	private String headerName;
	private String fieldName;
//	private DataExportConversion conversion;//数据转换
	private Integer type;
	
	public ExeclColumnParam(String headerName, String fieldName) {
		this(headerName, fieldName,null);
	}

	public ExeclColumnParam(String headerName, String fieldName, Integer type) {
		this.headerName = headerName;
		this.fieldName = fieldName;
		this.type = type;
	}

	
	/**
	 * @param headerName
	 */
	public ExeclColumnParam(String headerName) {
		super();
		this.headerName = headerName;
	}

	/**
	 * @param headerName
	 * @param type
	 */
	public ExeclColumnParam(String headerName, Integer type) {
		super();
		this.headerName = headerName;
		this.type = type;
	}

	public String getHeaderName() {
		return headerName;
	}

	public void setHeaderName(String headerName) {
		this.headerName = headerName;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	
  
}