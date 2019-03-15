package io.report.modules.rdp.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONArray;

import io.report.modules.rdp.entity.xml.ReportEntity;

public interface ReportService {
	
	public Map<String, Object> queryExecuterNew(HttpServletRequest request,List<String> dataSetslist, ReportEntity entity, JSONArray jsonArray, Map<String, Object> mmdtl, int currentPage,
			int pageSize, Boolean isTotal, Map<String, BigDecimal> sumlist, Map<String, String> dsFilter);
	
	public Map<String, String> executeSql(String dataSourceName,String sql);
	
	public Map<String, String> executeSqlMapByTran(Map<String, Object> sqlMap);
}
