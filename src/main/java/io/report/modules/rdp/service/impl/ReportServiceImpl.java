package io.report.modules.rdp.service.impl;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.hutool.http.HttpUtil;
import io.report.common.db.bean.DataSourceBean;
import io.report.common.db.util.DBUtil;
import io.report.modules.rdp.dao.ReportDao;
import io.report.modules.rdp.entity.xml.FieldEntity;
import io.report.modules.rdp.entity.xml.ParmEntity;
import io.report.modules.rdp.entity.xml.RdpDataSetEntity;
import io.report.modules.rdp.entity.xml.ReportEntity;
import io.report.modules.rdp.service.ReportService;
import io.report.modules.rdp.util.Cache;
import io.report.modules.rdp.util.StringHelper;
import io.report.modules.rdp.util.Tools;
import io.report.modules.ser.service.DataSourceService;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private DataSourceService dataSourceService;

	/**
	 * 数据执行service
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> queryExecuterNew(HttpServletRequest request, List<String> dataSetslist, ReportEntity entity, JSONArray jsonArray, Map<String, Object> mmdtl, int currentPage,
			int pageSize, Boolean isTotal, Map<String, BigDecimal> sumlist, Map<String, String> dsFilter) {
		ReportDao pd = new ReportDao();
		if (pageSize == -2) {
			pageSize = 40;
		}
		int pg = pageSize;
		if (!isTotal && pageSize != 1) {
			pg = 0;
		}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();// 数据
		Map<String, BigDecimal> sum = sumlist;// 统计
		int totalRecord = 0;
		Document document;
		List nodes = null;
		for (RdpDataSetEntity dataSetEntity : entity.getDataSets()) {
			if (dataSetslist.contains(dataSetEntity.getName().toLowerCase())) {
				String datasetType = dataSetEntity.getDataSetType();
				String dataSourceName = dataSetEntity.getDatasourcename();
				DataSourceBean dataSourceBean = new DataSourceBean();
				if (Cache.dataSourceBeanMap.get(dataSourceName) != null) {
					dataSourceBean = Cache.dataSourceBeanMap.get(dataSourceName);
				} else {
					dataSourceBean = dataSourceService.getDataSourceBeanByDataSourceName(dataSourceName);
				}
				String sql = dataSetEntity.getCommandtext();
				sql = Tools.prepParams(request, sql);// 处理sql中的参数变量
				List<JSONObject> l = new ArrayList<JSONObject>();
				for (FieldEntity field : dataSetEntity.getFileds()) {
					String DataField = field.getName();
					Object DataType = "";
					if (field.getDatatype() != null) {
						DataType = field.getDatatype();
					}
					JSONObject ob = new JSONObject();
					ob.put("datafield", DataField);
					ob.put("datatype", DataType);
					l.add(ob);
				}

				if ("javabean".equals(dataSourceName)) {
					if (jsonArray == null) {
						jsonArray = new JSONArray();
					}
					totalRecord = jsonArray.size();
					int strf = (currentPage - 1) * pageSize;
					int strt = currentPage * pageSize;
					if (strt > totalRecord) {
						strt = totalRecord;
					}
					JSONArray jsa = new JSONArray();
					for (int i = strf; i < strt; i++) {
						if (!isTotal && i > 0) {
							continue;
						}
						jsa.add(jsonArray.get(i));
					}
					if (jsa.size() > 0) {
						pd.queryFromObjectNew(sql, l, sum, list, dataSetEntity.getName(), jsa, mmdtl);
					} else {
						pd.queryFromObjectNew(sql, l, sum, list, dataSetEntity.getName(), jsonArray, mmdtl);
					}

				} else if ("json".equals(dataSourceName)) {
					DataSourceBean dsb = dataSourceService.getDataSourceBeanByDataSourceName(dataSetEntity.getHostName());
					String url = dsb.getDataBaseUrl() + dataSetEntity.getPath();
					Object method = dataSetEntity.getMethod();
					Object node = dataSetEntity.getNode();
					// Object cate = queryMap.get("cate");
					Object pagetype = dataSetEntity.getPageType();
					Object pageparam = dataSetEntity.getPageParam();
					Object pagesizeparam = dataSetEntity.getPageSizeParam();
					Object recordname = dataSetEntity.getRecordName();
					List<String> parameters = dataSetEntity.getParameters();
					String params = "";
					for (String k : parameters) {
						Object value = request.getParameter(k);
						if (value != null) {
							try {
								value = URLEncoder.encode(value.toString(), "UTF-8");
							} catch (UnsupportedEncodingException e) {
								e.printStackTrace();
							}
						}
						params += "&" + k + "=" + value;
					}
					if (params.length() > 0) {
						params = params.substring(1);
					}
					// 不分页默认取前500000条记录
					int npage = pageSize == -1 ? 500000 : pageSize;
					if (npage == -1) {
						npage = 500000;
					}
					Map<String, Object> jsonMap = Tools.getJsonArray(url, method, node, pagetype, pageparam, pagesizeparam, recordname, currentPage, npage, params);
					jsonArray = (JSONArray) jsonMap.get("jsonArray");
					totalRecord = (int) jsonMap.get("totalRecord");
					int strf = (currentPage - 1) * npage;// 起始记录
					int strt = currentPage * npage;// 终止记录
					if ("1".equals(pagetype)) {// 自定义分页
						strf = 0;
						strt = jsonArray.size() - 1;
					}
					if (strt > totalRecord) {
						strt = totalRecord;
					}
					JSONArray jsa = new JSONArray();
					for (int i = strf; i <= strt; i++) {
						if (!isTotal && i > 0) {
							continue;
						}
						if (jsonArray.size() > 0 && jsonArray.size() > i) {
							jsa.add(jsonArray.get(i));
						}
					}
					if (jsa.size() > 0) {
						pd.queryFromJson(l, sum, list, dataSetEntity.getName(), jsa, mmdtl);
					} else {
						pd.queryFromJson(l, sum, list, dataSetEntity.getName(), jsonArray, mmdtl);
					}

				} else {
					sql = sql.replaceAll("  ", " ");
					List<String> parameters = dataSetEntity.getParameters();
					ArrayList<Object> objParamsList = new ArrayList<Object>();
					int ii = 0;
					int iii = 0;
					String[] sqlarr = sql.split("\\?");
					String nslq = sql;
					String sin = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTNVWXYZ0123456789-_";
					Map<String, Object> procParamMap = new HashMap<String, Object>();// 存储过程参数
					// 动态表名（表名是参数）处理
					for (String k : parameters) {
						Object value = request.getParameter(k);
						if (value != null) {
							try {
								value = URLDecoder.decode(request.getParameter(k), "utf-8");
							} catch (UnsupportedEncodingException e) {
								e.printStackTrace();
							}
						}
						procParamMap.put(k, value);
						String dbtype = "";
						for (ParmEntity field : entity.getParmsList()) {
							if (field.getName().toLowerCase().equals(k.toLowerCase())) {
								dbtype = field.getDbtype();
							}
						}
						Boolean isw = false;// 动态表名
						if (dbtype != null && dbtype.length() > 0 && (dbtype.toLowerCase().equals("double") || dbtype.toLowerCase().equals("int"))) {
							if (sqlarr[iii].length() > 4 && sin.indexOf(sqlarr[iii].substring(sqlarr[iii].length() - 1)) != -1) {
								isw = true;
							}
						}
						if (isw) {
							nslq = nslq.replace(sqlarr[iii] + "?", sqlarr[iii] + String.valueOf(value));
						} else {
							if (dbtype != null && dbtype.length() > 0 && (dbtype.toLowerCase().equals("double") || dbtype.toLowerCase().equals("int"))) {
								objParamsList.add(value);
							} else {
								if (value != null) {
									objParamsList.add("'" + value + "'");
								} else {
									objParamsList.add(value);
								}
							}
							ii++;
						}
						iii++;
					}
					Object[] objParams = objParamsList.toArray();
					int kindex = 0;
					if (mmdtl.size() > 0 && sql.indexOf("?") != -1) {// 动态列
						String[] arrdtcol = null;
						int kkk = 0;
						for (String kk : mmdtl.keySet()) {
							if (kkk == kindex) {
								if (mmdtl.get(kk).toString().indexOf(",") != -1) {
									arrdtcol = mmdtl.get(kk).toString().split(",");
								} else {
									arrdtcol = new String[] { mmdtl.get(kk).toString() };
								}
							}
							kkk++;
						}
						if (arrdtcol != null) {
							for (int i = 0; i < arrdtcol.length; i++) {
								if (i == 0) {
									try {
										pd.queryExecuterNew(dataSourceBean, nslq.replaceFirst("\\?", "'" + arrdtcol[i] + "'"), l, sum, list, dataSetEntity.getName(), "", currentPage, pg,
												dataSourceBean.getType(), dsFilter, datasetType, procParamMap, objParams);
									} catch (SQLException e) {
										e.printStackTrace();
									}
								} else {
									try {
										pd.queryExecuterNew(dataSourceBean, nslq.replaceFirst("\\?", "'" + arrdtcol[i] + "'"), l, sum, list, dataSetEntity.getName(), "_" + i, currentPage, pg,
												dataSourceBean.getType(), dsFilter, datasetType, procParamMap, objParams);
									} catch (SQLException e) {
										e.printStackTrace();
									}
								}
								if (isTotal) {
									if (currentPage == 1) {
										int trd = 0;
										if (pageSize > 0 && dsFilter.size() == 0 && !"2".equals(datasetType) && !"3".equals(datasetType)) {
											String nsqln = nslq.replaceFirst("\\?", "'" + arrdtcol[i] + "'");
											trd = pd.queryExecuterRecord(dataSourceBean, nsqln, objParams);
										} else {// 不分页处理
											trd = list.size();
										}
										if (trd > totalRecord)
											totalRecord = trd;
									} else {
										try {
											totalRecord = Integer.parseInt(request.getParameter("totalRecord"));
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
								}
							}
						}
						kindex++;
					} else {
						try {
							pd.queryExecuterNew(dataSourceBean, nslq, l, sum, list, dataSetEntity.getName(), "", currentPage, pg, dataSourceBean.getType(), dsFilter, datasetType, procParamMap,
									objParams);
						} catch (SQLException e1) {
							e1.printStackTrace();
						}
						if (isTotal) {
							if (currentPage == 1) {
								int trd = 0;
								if (pageSize > 0 && dsFilter.size() == 0 && !"2".equals(datasetType) && !"3".equals(datasetType)) {
									String nsqln = nslq;
									trd = pd.queryExecuterRecord(dataSourceBean, nsqln, objParams);
								} else {// 不分页处理
									trd = list.size();
								}
								if (trd > totalRecord)
									totalRecord = trd;
							} else {
								try {
									totalRecord = Integer.parseInt(request.getParameter("totalRecord"));
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
						}
					}
				}
			}
		}

		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("list", list);
		mp.put("totalRecord", totalRecord);

		mp.put("sum", sum);
		return mp;
	}

	public Map<String, String> executeSql(String dataSourceName, String sqlStr) {
		DataSourceBean dataSourceBean = new DataSourceBean();
		if (Cache.dataSourceBeanMap.get(dataSourceName) != null) {
			dataSourceBean = Cache.dataSourceBeanMap.get(dataSourceName);
		} else {
			dataSourceBean = dataSourceService.getDataSourceBeanByDataSourceName(dataSourceName);
		}
		if (dataSourceBean.getReadOnly() != null && !dataSourceBean.getReadOnly()) {
			return DBUtil.getDbInfoUtil(dataSourceBean).executeSql(sqlStr);
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("code", "0");
			map.put("msg", "提示：保存失败，数据源不可写！");
			return map;
		}
	}

	public Map<String, String> executeSqlMapByTran(Map<String, Object> sqlMap) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", "1");
		DataSourceBean dataSourceBean = new DataSourceBean();
		List<String> sqls = new ArrayList<String>();
		for (String k : sqlMap.keySet()) {
			String[] sqlArr = (String[]) sqlMap.get(k);
			sqls.add(sqlArr[1]);
			if (dataSourceBean != null && dataSourceBean.getDataSourceName() != null) {
				if (dataSourceBean.getDataSourceName().equals(sqlArr[0])) {
					continue;
				} else {
					map.put("code", "0");
					map.put("msg", "保存失败，原因：填报数据源必须惟一！");
					return map;
				}
			}
			if (Cache.dataSourceBeanMap.get(sqlArr[0]) != null) {
				dataSourceBean = Cache.dataSourceBeanMap.get(sqlArr[0]);
			} else {
				dataSourceBean = dataSourceService.getDataSourceBeanByDataSourceName(sqlArr[0]);
			}
		}

		if (dataSourceBean.getReadOnly() != null && !dataSourceBean.getReadOnly()) {
			Connection conn = null;
			try {
				conn = DBUtil.getConn(dataSourceBean);
				if (conn != null) {
					conn.setAutoCommit(false);
					Statement stmt = conn.createStatement();
					for (String sql : sqls) {
						stmt.execute(sql);
					}
					conn.commit();
					stmt.close();
				}
			} catch (SQLException e) {
				map.put("code", "0");
				map.put("msg", "保存失败，原因：" + e.getMessage());
				// e.printStackTrace();
			} finally {
				DBUtil.closeConn(conn);
			}
		}
		return map;
	}
}
