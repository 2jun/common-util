package com.aj.tool.core.office.excel;

import com.aj.tool.core.utils.DateFormatUtils;
import com.aj.tool.core.office.excel.style.AbstractCellStyle;
import com.aj.tool.core.office.excel.style.DefaultDataCellStyle;
import com.aj.tool.core.office.excel.style.DefaultTitleCellStyle;
import com.aj.tool.core.office.param.ExeclColumnParam;
import com.aj.tool.core.office.param.ExeclTableParam;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@SuppressWarnings("rawtypes")
public class ExportExcel {

	private SXSSFWorkbook workbook;
	private AbstractCellStyle titleCellStyle;// 标题行样式
	private AbstractCellStyle dataCellStyle;// 数据行样式

	private Integer dataLimit = 500000;

	public ExportExcel() {
		// 声明一个工作薄
		this(new SXSSFWorkbook(5000));
	}

	public ExportExcel(SXSSFWorkbook workbook) {
		this(workbook, new DefaultTitleCellStyle(workbook), new DefaultDataCellStyle(workbook));
	}

	public ExportExcel(SXSSFWorkbook workbook, AbstractCellStyle titleCellStyle, AbstractCellStyle dataCellStyle) {
		this.workbook = workbook;
		this.titleCellStyle = titleCellStyle;
		this.dataCellStyle = dataCellStyle;
		this.workbook.setCompressTempFiles(true);
	}

	/**
	 * 导出功能
	 *
	 * @param sheetName
	 * @param out
	 */
	public void execlExport(String sheetName, ExeclTableParam tableParam, OutputStream out) {
		List data = (List) tableParam.getData();
		int sheetNum = data.size() / dataLimit + 1;
		int startIndex = 0, endIndex = dataLimit;

		for (int i = 0; i < sheetNum; i++) {
			if (endIndex > data.size()) {
				endIndex = data.size();
			}
			createSheet(sheetName + (i + 1), tableParam, startIndex, endIndex);
			startIndex += dataLimit;
			endIndex += dataLimit;
		}

		writeAndDispose(out);
	}

	/**
	 * 分sheet导出
	 *
	 * @param sheetName
	 * @param baseParam
	 * @param startIndex
	 * @param endIndex
	 */
	public void createSheet(String sheetName, ExeclTableParam baseParam, int startIndex, int endIndex) {
		// 生成一个表格
		Sheet sheet = null;
		synchronized (this) {
			sheet = workbook.createSheet(sheetName);
		}

		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);

		// 声明一个画图的顶级管理器
		Drawing patriarch = sheet.createDrawingPatriarch();

		setExcelHeader(0, baseParam.getColumnParams(), sheet);
		
		@SuppressWarnings("unchecked")
		List<Object> dateLst=	(List<Object>) baseParam.getData();
		
		setTableData(baseParam.getColumnParams(), dateLst.subList(startIndex, endIndex), workbook, sheet, patriarch);
	}

	/**
	 * 写入OutputStream，且关闭删除workbook临时文件
	 * 
	 * @param out
	 */
	public void writeAndDispose(OutputStream out) {
		try {
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (workbook != null) {
				workbook.dispose();// 删除临时文件
			}
		}
	}

	/**
	 * @Description: 设置数据
	 */
	public void setTableData(List<ExeclColumnParam> columnParams, Collection dataset, Workbook workbook, Sheet sheet, Drawing patriarch) {
		// 遍历集合数据，产生数据行
		Iterator it = dataset.iterator();
		int index = 0;
		while (it.hasNext()) {
			index++;
			Row row = sheet.createRow(index);
			Object t = it.next();
			for (int i = 0; i < columnParams.size(); i++) {
				ExeclColumnParam columnParam = columnParams.get(i);
				Cell cell = row.createCell(i);
				cell.setCellStyle(dataCellStyle.getCellStyle());
				try {
					Object value = PropertyUtils.getProperty(t, columnParam.getFieldName());
					if (value == null)
						continue;

					// 判断值的类型后进行强制类型转换
					if (value instanceof String) {
						cell.setCellValue(value.toString());
					} else if (value instanceof Number) {
						cell.setCellValue(Double.valueOf(value+""));
					} else if (value instanceof Date) {
						String textValue = null;
						// 判断columnParam的数据处理类是否为null，是的话使用默认的数据处理，否则使用columnParam的
						if (columnParam.getType() == 1) {
							textValue = DateFormatUtils.formatYMd((Date) value);
						} else if (columnParam.getType() == 2) {
							textValue = DateFormatUtils.formatYMdHms((Date) value);
						}

						// 如果textValue为null，跳过
						if (textValue != null) {
							cell.setCellValue(textValue);
							// 自适应宽度
							int columnWidth = sheet.getColumnWidth(i);
							int newColumnWidth = textValue.getBytes().length * 1 * 256 + 256 * 2;
							if (newColumnWidth > columnWidth) {
								sheet.setColumnWidth(i, newColumnWidth);
							}
						}

					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					// 清理资源
				}
			}
		}
	}

	public void setExcelHeader(Integer index, List<ExeclColumnParam> columnParams, Sheet sheet) {
		if (index == null || index < 0) {
			index = 0;
		}
		Row row = sheet.createRow(index);
		ExeclColumnParam columnParam = null;
		Cell cell = null;
		for (int i = 0, columnNum = columnParams.size(); i < columnNum; i++) {
			columnParam = columnParams.get(i);
			cell = row.createCell(i);
			cell.setCellStyle(titleCellStyle.getCellStyle());
			cell.setCellValue(columnParam.getHeaderName());
			sheet.setColumnWidth(i, columnParam.getHeaderName().getBytes().length * 2 * 256);
		}
	}
}
