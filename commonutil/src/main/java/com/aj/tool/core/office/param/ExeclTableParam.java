package com.aj.tool.core.office.param;

import java.util.Collection;
import java.util.List;

public class ExeclTableParam{
	private Collection data;
	private List<ExeclColumnParam> columnParams;
	
	public ExeclTableParam() {
		super();
	}
	public ExeclTableParam(Collection data, List<ExeclColumnParam> columnParams) {
		super();
		this.data = data;
		this.columnParams = columnParams;
	}
	public Collection getData() {
		return data;
	}
	
	public void setData(Collection data) {
		this.data = data;
	}
	
	public List<ExeclColumnParam> getColumnParams() {
		return columnParams;
	}
	
	public void setColumnParams(List<ExeclColumnParam> columnParams) {
		this.columnParams = columnParams;
	}
}
