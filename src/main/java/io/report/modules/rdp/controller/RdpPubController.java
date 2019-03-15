package io.report.modules.rdp.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.commons.jexl2.JexlContext;
import org.apache.commons.jexl2.MapContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.report.common.db.bean.DataSourceBean;
import io.report.common.db.util.DBUtil;
import io.report.common.utils.Base64Util;
import io.report.common.utils.R;
import io.report.common.utils.ServerUtil;
import io.report.modules.rdp.entity.JsonToXMLUtil;
import io.report.modules.rdp.entity.json.JsonReportEntity;
import io.report.modules.rdp.entity.xml.ColEntity;
import io.report.modules.rdp.entity.xml.FieldEntity;
import io.report.modules.rdp.entity.xml.RdpDataSetEntity;
import io.report.modules.rdp.entity.xml.ReportEntity;
import io.report.modules.rdp.entity.xml.RowEntity;
import io.report.modules.rdp.service.ReportService;
import io.report.modules.rdp.util.Cache;
import io.report.modules.rdp.util.DesignXmlUtil;
import io.report.modules.rdp.util.FillReportUtil;
import io.report.modules.rdp.util.JRUtilNew;
import io.report.modules.rdp.util.ListFilterUtil;
import io.report.modules.rdp.util.PoiUtil;
import io.report.modules.ser.service.DataSourceService;

/*
 * 报表展现相关--不拦截
 */
@RestController
@RequestMapping("/rdppub")
public class RdpPubController {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${report.rdp.data-path}")
	private String realPath;
	@Value("${report.rdp.maxexport}")
	private int maxexport;
	@Value("${report.relative-path}")
	private Boolean relativePath;

	@Autowired
	HttpServletRequest rq;
	@Autowired
	HttpServletResponse rp;
	@Autowired
	private ReportService reportService;
	@Autowired
	private DataSourceService dataSourceService;

	/**
	 * 显示报表
	 * 
	 */
	@RequestMapping("/show")
	public R show() {
		Map<String, Object> dMap = new HashMap<String, Object>();
		String uuid = rq.getParameter("uuid");
		String reportJson = rq.getParameter("reportJson");
		int pageSize = rq.getParameter("pageSize") != null ? Integer.parseInt(rq.getParameter("pageSize")) : 0;// 页尺寸
		int currentPage = rq.getParameter("currentPage") != null ? Integer.parseInt(rq.getParameter("currentPage")) : 1;// 当前页
		int pageType = rq.getParameter("pageType") != null ? Integer.parseInt(rq.getParameter("pageType")) : 0;// 页方向 0-纵向 1-横向
		JRUtilNew jn = new JRUtilNew();
		ReportEntity entity = new ReportEntity();
		Boolean isReportJson = false;
		try {
			if (reportJson == null || "".equals(reportJson)) {
				if (uuid != null && uuid.length() > 0 && Cache.xmlMap.get(uuid) != null) {
					entity = (ReportEntity) Cache.xmlMap.get(uuid);
				} else {
					File file = new File(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
					if (file.exists()) {
						entity = DesignXmlUtil.openXMLNew(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
					} else {
						entity = new ReportEntity();
					}
				}
				if (entity.getUuid() != null) {
					isReportJson = false;
				} else {
					return R.error("报表不存在！");
				}
			} else {
				try {
					reportJson = Base64Util.decode(reportJson, "Unicode");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				JsonReportEntity json = JSON.parseObject(reportJson, JsonReportEntity.class);
				entity = JsonToXMLUtil.JsonToXml(json);
				isReportJson = true;
			}
			if (pageSize == 0) {
				pageSize = entity.getBodyPagesize();
			}
			Map<String, Object> rmap = reportMap(jn, entity, uuid, currentPage, pageSize);
			if (isReportJson) {
				dMap = jn.pubPreDes(rq, ServerUtil.getDataPath(relativePath, realPath), entity, currentPage, pageType, pageSize, uuid, false, rmap);
			} else {
				if (pageSize == 0) {
					dMap = jn.pubPreDes(rq, ServerUtil.getDataPath(relativePath, realPath), entity, currentPage, entity.getBodyPageorder(), entity.getBodyPagesize(), uuid, false, rmap);
				} else {
					dMap = jn.pubPreDes(rq, ServerUtil.getDataPath(relativePath, realPath), entity, currentPage, pageType, pageSize, uuid, false, rmap);
				}
			}
			return R.ok().put("list", dMap);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error("获取参数出错！");
		}
	}

	/**
	 * 报表导出状态
	 * 
	 * @return
	 */
	@RequestMapping("/exportFlag")
	public R exportFlag() {
		int maxexport = 10;
		String uuid = rq.getParameter("uuid");
		String stat = rq.getParameter("stat");
		int curexport = 0;
		String cep = Cache.exportMap.get("curexport");
		String expuuid = Cache.exportMap.get(uuid);
		if (stat != null && stat.equals("1")) {
			// 失败减导出标志
			if (cep != null && cep.equals("1")) {
				Cache.exportMap.put("curexport", "0");
				Cache.exportMap.remove(uuid);
			} else {
				try {
					int xcep = maxexport - 1;
					if (xcep < 0)
						xcep = 0;
					Cache.exportMap.put("curexport", String.valueOf(xcep));
					Cache.exportMap.remove(uuid);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			if (cep == null || cep.equals("0")) {
				Cache.exportMap.put("curexport", "1");
				curexport = 1;
			} else {
				try {
					if (maxexport > Integer.parseInt(cep) && expuuid == null) {
						Cache.exportMap.put("curexport", String.valueOf(Integer.parseInt(cep) + 1));
					}
					if (maxexport >= curexport) {
						curexport = Integer.parseInt(cep) + 1;
					}
				} catch (Exception e) {
				}
			}
		}
		if (maxexport >= curexport) {
			// if(expuuid==null){
			// exportMap.put(uuid, "1");
			// backFlag = 1;
			// }else{
			// backFlag=0;
			// }
			// 启用上方注释则单报表不同同时导出
			return R.ok();
		} else {
			return R.error();
		}
	}

	/**
	 * 导出非主子报表
	 * 
	 * @return
	 */
	@RequestMapping("/exportExcel")
	public void exportExcel() {
		long startTime = System.currentTimeMillis();
		ReportEntity entity = new ReportEntity();
		String uuid = rq.getParameter("uuid");
		if (uuid != null && uuid.length() == 32) {
			if (Cache.xmlMap.get(uuid) != null) {
				entity = (ReportEntity) Cache.xmlMap.get(uuid);
			} else {
				File file = new File(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
				if (file.exists()) {
					entity = DesignXmlUtil.openXMLNew(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
				} else {
					entity = new ReportEntity();
				}
			}
		} else {
			String reportJson = rq.getParameter("reportJson");
			try {
				reportJson = Base64Util.decode(reportJson, "Unicode");
			} catch (Exception e) {
				e.printStackTrace();
			}
			JsonReportEntity json = JSON.parseObject(reportJson, JsonReportEntity.class);
			entity = JsonToXMLUtil.JsonToXml(json);
		}
		JSONArray jsonArray = new JSONArray();
		String jsonlist = rq.getParameter("jsonlist");
		if (!"".equals(jsonlist))
			jsonArray = JSON.parseArray(jsonlist);
		try {
			String fileName = entity.getReportDescription() != null ? entity.getReportDescription() : "temp";
			Map<String, Object> rpmap = rpMap(entity, uuid, jsonArray);
			new JRUtilNew().exportExcel(entity, uuid, jsonArray, fileName, rq, rp, false, rpmap);
		} catch (Exception e) {
			e.printStackTrace();
			rp.setHeader("Set-Cookie", "fileDownload=false; path=/");
			rp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		}
		// 减导出标志
		String cep = Cache.exportMap.get("curexport");
		if (cep != null && cep.equals("1")) {
			Cache.exportMap.put("curexport", "0");
			Cache.exportMap.remove(uuid);
		} else {
			try {
				int xcep = Integer.parseInt(cep) - 1;
				if (xcep < 0)
					xcep = 0;
				Cache.exportMap.put("curexport", String.valueOf(xcep));
				Cache.exportMap.remove(uuid);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Long endTime = System.currentTimeMillis();
		logger.info("导出总用时：" + (endTime - startTime));
	}

	/**
	 * 导出主子报表
	 * 
	 * @return
	 */
	@RequestMapping("/exportSubExcel")
	public void exportSubExcel() {
		String uuid = rq.getParameter("uuid");
		long startTime = System.currentTimeMillis();
		ReportEntity entity = new ReportEntity();
		if (uuid != null && uuid.length() == 32) {
			if (Cache.xmlMap.get(uuid) != null) {
				entity = (ReportEntity) Cache.xmlMap.get(uuid);
			} else {
				File file = new File(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
				if (file.exists()) {
					entity = DesignXmlUtil.openXMLNew(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
				} else {
					entity = new ReportEntity();
				}
			}
		} else {
			String reportJson = rq.getParameter("reportJson");
			JsonReportEntity json = JSON.parseObject(reportJson, JsonReportEntity.class);
			entity = JsonToXMLUtil.JsonToXml(json);
		}
		Map<String, Object> dMap = null;
		try {
			JRUtilNew jn = new JRUtilNew();
			Map<String, Object> rmap = reportMap(jn, entity, uuid, 1, -1);
			dMap = jn.pubPreDes(rq, ServerUtil.getDataPath(relativePath, realPath), entity, 1, 1, -1, uuid, false, rmap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (dMap != null && dMap.get("body") != null) {
				String fileName = entity.getReportDescription();
				PoiUtil.exportExcel(dMap.get("body").toString(), fileName, rq, rp);
				dMap = null;
			} else {
				rp.setHeader("Set-Cookie", "fileDownload=false; path=/");
				rp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			}
		} catch (Exception e) {
			e.printStackTrace();
			rp.setHeader("Set-Cookie", "fileDownload=false; path=/");
			rp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		}
		// 减导出标志
		String cep = Cache.exportMap.get("curexport");
		if (cep != null && cep.equals("1")) {
			Cache.exportMap.put("curexport", "0");
			Cache.exportMap.remove(uuid);
		} else {
			try {
				int xcep = Integer.parseInt(cep) - 1;
				if (xcep < 0)
					xcep = 0;
				Cache.exportMap.put("curexport", String.valueOf(xcep));
				Cache.exportMap.remove(uuid);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Long endTime = System.currentTimeMillis();
		logger.info("导出总用时：" + (endTime - startTime));
	}

	/**
	 * 显示报表参数
	 * 
	 * @return
	 */
	@RequestMapping("/showparam")
	public R showparam() {
		String uuid = rq.getParameter("uuid");
		String reportJson = rq.getParameter("reportJson");
		try {
			Map<String, Object> map = DesignXmlUtil.compileReportParms(ServerUtil.getDataPath(relativePath, realPath), uuid, reportJson, rq);
			return R.ok().put("data", map);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error("获取参数出错！");
		}
	}

	/**
	 * 填报保存 --注意：填报不支持多数据源
	 * 
	 * @return
	 */
	@RequestMapping("/savereport")
	public R savereport() {
		String uuid = rq.getParameter("uuid");
		try {
			if (uuid.length() != 32) {
				return R.error("提示：预览时不支持填报保存功能！");
			} else {
				ReportEntity entity = (ReportEntity) Cache.xmlMap.get(uuid);
				if (entity == null) {
					File file = new File(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
					if (file.exists()) {
						entity = DesignXmlUtil.openXMLNew(ServerUtil.getDataPath(relativePath, realPath) + uuid + ".xml");
					}
				}
				if (entity != null) {
					Map<String, Object> returnMap = FillReportUtil.getFillSql(rq, entity);
					Map<String, Object> sqlMap=new HashMap<String, Object>();
					if (returnMap.get("code").toString().equals("0")) {
						for (String k : returnMap.keySet()) {
							if (k.startsWith("sql_")) {
								sqlMap.put(k, returnMap.get(k));
							}
						}
						if(sqlMap.size()>0) {
							Map<String, String> resMap = reportService.executeSqlMapByTran(sqlMap);
							if (resMap != null && resMap.size() > 0 && resMap.get("code") != null) {
								if (resMap.get("code").equals("0")) {
									return R.error(resMap.get("msg"));
								}
							} else {
								return R.error("提示：保存失败，验证出错！");
							}
						}else {
							return R.error("提示：没有找到要保存的SQL！");
						}
					} else {
						return R.error(returnMap.get("msg").toString());
					}
				} else {
					return R.error("提示：出错了，未找到报表模板！");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return R.error("获取参数出错！");
		}
		return R.ok();
	}

	/**
	 * 预览报表解析
	 * 
	 * @param jn
	 * @param entity
	 * @param uuid
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	private Map<String, Object> reportMap(JRUtilNew jn, ReportEntity entity, String uuid, int currentPage, int pageSize) {
		if(uuid==null){
			uuid="null";
		}
		Map<String, Object> reportMap = new HashMap<String, Object>();
		// -----------------strat------------
		String jsonlist = rq.getParameter("jsonlist");
		JSONArray jsonArray = new JSONArray();
		if (!"".equals(jsonlist))
			jsonArray = JSONArray.parseArray(jsonlist);
		JexlContext jc = new MapContext();
		jc.set("expFuntionChange", new io.report.modules.rdp.util.JRFunExpImpl());
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Boolean dtSign = false;// 动态列标志
		Boolean subreport = false;// 主子报表标志

		// 数据集map
		List<RdpDataSetEntity> listDataSetEntities = entity.getDataSets();
		Boolean exsitsProcDataSet = false;// 是否有存储过程数据集
		if (listDataSetEntities != null && listDataSetEntities.size() > 0) {
			for (RdpDataSetEntity ks : listDataSetEntities) {
				String dstype = ks.getDataSetType();
				if (dstype != null && (dstype.equals("2") || dstype.equals("3"))) {
					exsitsProcDataSet = true;
				}
			}
		}
		// 模板内容map
		LinkedHashMap docMap = jn.getDocMap(rq,entity);
		Map<String, Object> dsMap = jn.getDsMap(docMap, jc);
		List<String> dsthList = (List<String>) dsMap.get("a");
		List<String> dstfList = (List<String>) dsMap.get("af");
		List<String> dsdList = (List<String>) dsMap.get("b");
		Map<String, List<String>> dicWhereMap = (Map) dsMap.get("dicWhere");
		Map<String, BigDecimal> sumList = (Map<String, BigDecimal>) dsMap.get("sum");
		List<String> smallsumList = (List<String>) dsMap.get("smallsum");
		Map<String, Object> dtlMap = (Map) dsMap.get("dtl");
		dtSign = (Boolean) dsMap.get("isdtl");
		subreport = (Boolean) dsMap.get("subreport");
		Map<String, String> dsFilter = (Map) dsMap.get("dsFilter");// 数据集过滤
		dicMap(listDataSetEntities, dicWhereMap);// 处理数据字典缓存
		Map<String, Object> mmdtl = new HashMap<String, Object>();
		// 表头表尾数据map
		Object objMtf = rq.getSession().getAttribute(uuid);
		Map<String, Object> mtfMap = new HashMap<String, Object>();
		Map<String, BigDecimal> _sumMap = new HashMap<String, BigDecimal>();// 表头表尾不参与统计计算
		if (currentPage == 1) {
			if (dtSign) {
				mtfMap = reportService.queryExecuterNew(rq, dsthList, entity, jsonArray, mmdtl, currentPage, pageSize, false, _sumMap, dsFilter);
			} else {
				List<String> dsthfList = dsthList;
				for (String s : dstfList) {
					if (!dsthfList.contains(s)) {
						dsthfList.add(s);
					}
				}
				mtfMap = reportService.queryExecuterNew(rq, dsthfList, entity, jsonArray, mmdtl, currentPage, 1, false, _sumMap, dsFilter);
			}
			rq.getSession().setAttribute(uuid, mtfMap);
		} else {// 同报表次页直接从缓存取数
			mtfMap = (Map<String, Object>) objMtf;
		}
		List<Map<String, Object>> listtf = (List<Map<String, Object>>) mtfMap.get("list");// 表头表尾数据
		List<Map<String, Object>> listtfDtl = new ArrayList<Map<String, Object>>();// 动态列重构表头表尾数据
		// System.out.println("listtf:"+listtf);
		if (dtSign) {// 动态列
			int di = 0;
			Map<String, Object> dhMap = new HashMap<String, Object>();
			Map<String, Integer> loopMap = new CaseInsensitiveMap();
			for (Map<String, Object> hashMap : listtf) {// 取出所有值
				for (String key : hashMap.keySet()) {
					String value = hashMap.get(key) != null ? hashMap.get(key).toString() : "";
					if (mmdtl.get(key) != null && !mmdtl.get(key).equals("")) {
						mmdtl.put(key, mmdtl.get(key) + "," + value);
					} else {
						mmdtl.put(key, value);
					}
					if (di == 0) {
						dhMap.put(key, value);
					} else {
						dhMap.put(key + "_" + di, value);
					}
					if (loopMap.get(key) != null) {
						loopMap.put(key, loopMap.get(key) + 1);
					} else {
						loopMap.put(key, 1);
					}
				}
				di++;
			}
			if (currentPage == 1 && mtfMap != null && mmdtl.size() > 0) {
				Map<String, Object> mthfMap = reportService.queryExecuterNew(rq, dstfList, entity, jsonArray, mmdtl, currentPage, 1, false, _sumMap, dsFilter);
				Map<String, BigDecimal> sum = (Map<String, BigDecimal>) mtfMap.get("sum");
				List<Map<String, Object>> list = (List<Map<String, Object>>) mtfMap.get("list");
				Map<String, BigDecimal> sumf = (Map<String, BigDecimal>) mthfMap.get("sum");
				for (String s : sumf.keySet()) {
					sum.put(s, sumf.get(s));
				}
				List<Map<String, Object>> listf = (List<Map<String, Object>>) mthfMap.get("list");
				Map<String, Object> listm = list.get(0);
				if (listf.size() > 0) {
					for (String s : listf.get(0).keySet()) {
						listm.put(s, listf.get(0).get(s));
					}
				}
				for(String k:dhMap.keySet()) {
					listm.put(k, dhMap.get(k));
				}
				List<Map<String, Object>> listnew = new ArrayList<Map<String, Object>>();
				listnew.add(listm);
				mtfMap.put("sum", sum);
				mtfMap.put("list", listnew);
				mtfMap.put("totalRecord", 0);
				rq.getSession().setAttribute(uuid, mtfMap);
				listtfDtl=listnew;
			}else {
				listtfDtl=(List<Map<String, Object>>) mtfMap.get("list");
			}
			if (loopMap.size() > 0) {
				// 重构docMap
				docMap = jn.resetDocMap(docMap, dtlMap, loopMap);
				// 重新解析docmap
				Map<String, Object> rsdsMap = jn.getDsMap(docMap, jc);
				sumList = (Map<String, BigDecimal>) rsdsMap.get("sum");
			}
		} else {
			Map<String, Object> dhMap = new HashMap<String, Object>();
			for (Map<String, Object> hashMap : listtf) {// 取出所有值
				for (String key : hashMap.keySet()) {
					String value = hashMap.get(key) != null ? hashMap.get(key).toString() : "";
					dhMap.put(key, value);
				}
			}
			listtf.clear();
			listtf.add(dhMap);
		}
//		 System.out.println(docMap);
		// 数据区数据map
		Object objMtd = rq.getSession().getAttribute("s_" + uuid + "_d");
		Map<String, Object> mdMap = new HashMap<String, Object>();
		List<Map<String, Object>> listd = new ArrayList<Map<String, Object>>();
		if (currentPage == 1 || objMtd == null) {
			if ((dtSign && mmdtl.size() > 0) || !dtSign) {
				mdMap = reportService.queryExecuterNew(rq, dsdList, entity, jsonArray, mmdtl, currentPage, pageSize, true, sumList, dsFilter);
				listd = (List<Map<String, Object>>) mdMap.get("list");// 数据区list
				if (exsitsProcDataSet) {
					mdMap.put("totalRecord", listd.size());// 更新总记录
					rq.getSession().setAttribute("s_" + uuid + "_d", mdMap);
				}
				if (dsFilter.size() > 0) {
					String filterStr = ListFilterUtil.filterStr(listd.get(0), dsFilter);// $F{DS.JIE}>15
					listd = (List<Map<String, Object>>) ListFilterUtil.getList(listd, filterStr);// 新list不分页
					mdMap.put("totalRecord", listd.size());// 更新总记录
					rq.getSession().setAttribute("s_" + uuid + "_d", mdMap);
				}
			} else {
				mdMap.put("list", new ArrayList<Map<String, Object>>());
				mdMap.put("totalRecord", 0);
				mdMap.put("sum", sumList);
				rq.getSession().setAttribute("s_" + uuid + "_d", mdMap);
			}
		} else {// 使用数据集过滤
			mdMap = (Map<String, Object>) objMtd;
			listd = (List<Map<String, Object>>) mdMap.get("list");// 数据区list
		}
		if (dsFilter.size() > 0 || exsitsProcDataSet) {// 按页取数据
			int fromIndex = (currentPage - 1) * pageSize;
			int toIndex = fromIndex + pageSize;
			if (fromIndex > listd.size())
				fromIndex = listd.size();
			if (toIndex > listd.size() || toIndex < 0)
				toIndex = listd.size();
			if (toIndex > 0)
				listd = listd.subList(fromIndex, toIndex);
			Map<String, BigDecimal> sum = sumList;
			for(String k:sum.keySet()) {
				sum.put(k, new BigDecimal("0"));
			}
			for (Map<String, Object> mm : listd) {
				for (String nkey : mm.keySet()) {
					Object oo = null;
					if (sum.get(nkey) != null) {
						oo = sum.get(nkey);
					}
					if (oo != null) {
						BigDecimal bd = new BigDecimal(oo.toString());
						bd = bd.add(new BigDecimal("".equals(mm.get(nkey)) ? "0" : mm.get(nkey).toString()));
						sum.put(nkey, bd);
					}
				}
			}
			mdMap.put("sum", sum);// 更新统计
		}
		// System.out.println("listd:" + listd);
		// -----------------end--------------
		reportMap.put("dataMap", dataMap);
		reportMap.put("mtfMap", mtfMap);
		reportMap.put("mdMap", mdMap);
		reportMap.put("docMap", docMap);
		reportMap.put("subreport", subreport);
		reportMap.put("dtSign", dtSign);
		reportMap.put("listd", listd);
		reportMap.put("listtf", listtf);
		reportMap.put("listtfDtl", listtfDtl);
		reportMap.put("smallsumList", smallsumList);
		// 递归查子报表
		for (RowEntity rows : entity.getRows()) {
			for (ColEntity cols : rows.getCols()) {
				if (cols.getFrameid() != null && cols.getFrameid().length() == 32) {
					String _uid = cols.getFrameid();
					ReportEntity reportEntity = new ReportEntity();
					if (Cache.xmlMap.get(_uid) != null) {
						reportEntity = (ReportEntity) Cache.xmlMap.get(_uid);
					} else {
						File file = new File(ServerUtil.getDataPath(relativePath, realPath) + _uid + ".xml");
						if (file.exists()) {
							reportEntity = DesignXmlUtil.openXMLNew(ServerUtil.getDataPath(relativePath, realPath) + _uid + ".xml");
						} else {
							continue;
						}
					}
					Map<String, Object> rMap = reportMap(jn, reportEntity, _uid, currentPage, pageSize);
					reportMap.put(_uid, rMap);
				}
			}
		}
		return reportMap;
	}

	/**
	 * 导出报表解析
	 * 
	 * @param entity
	 * @param uuid
	 * @param jsonArray
	 * @return
	 */
	private Map<String, Object> rpMap(ReportEntity entity, String uuid, JSONArray jsonArray) {
		Map<String, Object> reportMap = new HashMap<String, Object>();
		// 处理数据
		JRUtilNew jn = new JRUtilNew();
		int currentPage = 1, pageType = 1, pageSize = -1;
		JexlContext jc = new MapContext();
		jc.set("expFuntionChange", new io.report.modules.rdp.util.JRFunExpImpl());
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Boolean dtSign = false;// 动态列标志
		// 模板内容map
		LinkedHashMap docMap = jn.getDocMap(rq,entity);
		// System.out.println(docMap);
		Map<String, Object> dsMap = jn.getDsMap(docMap, jc);
		List<String> dsthList = (List<String>) dsMap.get("a");
		List<String> dstfList = (List<String>) dsMap.get("af");
		List<String> dsdList = (List<String>) dsMap.get("b");
		Map<String, String> dicMap = (Map) dsMap.get("dic");
		Map<String, BigDecimal> sumList = (Map<String, BigDecimal>) dsMap.get("sum");
		List<String> smallsumList = (List<String>) dsMap.get("smallsum");
		Map<String, Object> dtlMap = (Map) dsMap.get("dtl");
		dtSign = (Boolean) dsMap.get("isdtl");
		Map<String, String> dsFilter = (Map) dsMap.get("dsFilter");
		// System.out.println(dsMap);
		Map<String, Object> mmdtl = new HashMap<String, Object>();
		Map<String, BigDecimal> _sumMap = new HashMap<String, BigDecimal>();// 表头表尾不参与统计计算
		// 表头表尾数据map
		Map<String, Object> mtfMap = new HashMap<String, Object>();
		if (dtSign) {
			mtfMap = reportService.queryExecuterNew(rq, dsthList, entity, jsonArray, mmdtl, 1, -1, false, _sumMap, dsFilter);
		} else {
			List<String> dsthfList = dsthList;
			for (String s : dstfList) {
				if (!dsthfList.contains(s)) {
					dsthfList.add(s);
				}
			}
			mtfMap = reportService.queryExecuterNew(rq, dsthfList, entity, jsonArray, mmdtl, 1, -1, false, _sumMap, dsFilter);
		}
		List<Map<String, Object>> listtf = (List<Map<String, Object>>) mtfMap.get("list");// 表头表尾数据
		List<Map<String, Object>> listtfDtl = new ArrayList<Map<String, Object>>();// 动态列重构表头表尾数据
//		 System.out.println("listtf:"+listtf);
		if (dtSign) {// 动态列
			int di = 0;
			Map<String, Object> dhMap = new HashMap<String, Object>();
			Map<String, Integer> loopMap = new CaseInsensitiveMap();
			for (Map<String, Object> hashMap : listtf) {// 取出所有值
				for (String key : hashMap.keySet()) {
					String value = hashMap.get(key) != null ? hashMap.get(key).toString() : "";
					if (mmdtl.get(key) != null && !mmdtl.get(key).equals("")) {
						mmdtl.put(key, mmdtl.get(key) + "," + value);
					} else {
						mmdtl.put(key, value);
					}
					if (di == 0) {
						dhMap.put(key, value);
					} else {
						dhMap.put(key + "_" + di, value);
					}
					if (loopMap.get(key) != null) {
						loopMap.put(key, loopMap.get(key) + 1);
					} else {
						loopMap.put(key, 1);
					}
				}
				di++;
			}
			if (mmdtl.size() > 0) {
				Map<String, Object> mthfMap = reportService.queryExecuterNew(rq, dstfList, entity, jsonArray, mmdtl, currentPage, pageSize, false, _sumMap, dsFilter);
				Map<String, BigDecimal> sum = (Map<String, BigDecimal>) mtfMap.get("sum");
				List<Map<String, Object>> list = (List<Map<String, Object>>) mtfMap.get("list");
				Map<String, BigDecimal> sumf = (Map<String, BigDecimal>) mthfMap.get("sum");
				for (String s : sumf.keySet()) {
					sum.put(s, sumf.get(s));
				}
				List<Map<String, Object>> listf = (List<Map<String, Object>>) mthfMap.get("list");
				Map<String, Object> listm = list.get(0);
				if (listf.size() > 0) {
					for (String s : listf.get(0).keySet()) {
						listm.put(s, listf.get(0).get(s));
					}
				}
				for(String k:dhMap.keySet()) {
					listm.put(k, dhMap.get(k));
				}
				List<Map<String, Object>> listnew = new ArrayList<Map<String, Object>>();
				listnew.add(listm);
				mtfMap.put("sum", sum);
				mtfMap.put("list", listnew);
				mtfMap.put("totalRecord", 0);
				listtfDtl=listnew;
			}
			listtfDtl.add(dhMap);
			if (loopMap.size() > 0) {
				// 重构docMap
				docMap = jn.resetDocMap(docMap, dtlMap, loopMap);
				// 重新解析docmap
				Map<String, Object> rsdsMap = jn.getDsMap(docMap, jc);
				sumList = (Map<String, BigDecimal>) rsdsMap.get("sum");
			}
		} else {
			Map<String, Object> dhMap = new HashMap<String, Object>();
			for (Map<String, Object> hashMap : listtf) {// 取出所有值
				for (String key : hashMap.keySet()) {
					String value = hashMap.get(key) != null ? hashMap.get(key).toString() : "";
					dhMap.put(key, value);
				}
			}
			listtf.clear();
			listtf.add(dhMap);
		}
//		 System.out.println(docMap);
		// 数据区数据map
		Map<String, Object> mdMap = new HashMap<String, Object>();
		if ((dtSign && mmdtl.size() > 0) || !dtSign) {
			mdMap = reportService.queryExecuterNew(rq, dsdList, entity, jsonArray, mmdtl, currentPage, pageSize, true, sumList, dsFilter);
		} else {
			mdMap.put("list", new ArrayList<Map<String, Object>>());
			mdMap.put("totalRecord", 0);
			mdMap.put("sum", sumList);
		}
		List<Map<String, Object>> listd = (List<Map<String, Object>>) mdMap.get("list");// 数据区list
		if (dsFilter.size() > 0) {
			String filterStr = ListFilterUtil.filterStr(listd.get(0), dsFilter);// $F{DS.JIE}>15
			listd = (List<Map<String, Object>>) ListFilterUtil.getList(listd, filterStr);// 新list不分页
			mdMap.put("totalRecord", listd.size());// 更新总记录
			Map<String, BigDecimal> sum = sumList;
			for(String k:sum.keySet()) {
				sum.put(k, new BigDecimal("0"));
			}
			for (Map<String, Object> mm : listd) {
				for (String nkey : mm.keySet()) {
					Object oo = null;
					if (sum.get(nkey) != null) {
						oo = sum.get(nkey);
					}
					if (oo != null) {
						BigDecimal bd = new BigDecimal(oo.toString());
						bd = bd.add(new BigDecimal("".equals(mm.get(nkey)) ? "0" : mm.get(nkey).toString()));
						sum.put(nkey, bd);
					}
				}
			}
			mdMap.put("sum", sum);// 更新统计
		}
		// System.out.println("listd:" + listd);
		Map<String, Object> sumMap = (Map<String, Object>) mdMap.get("sum");// 表尾统计

		reportMap.put("dataMap", dataMap);
		reportMap.put("mtfMap", mtfMap);
		reportMap.put("mdMap", mdMap);
		reportMap.put("docMap", docMap);
		reportMap.put("dtSign", dtSign);
		reportMap.put("listd", listd);
		reportMap.put("listtf", listtf);
		reportMap.put("listtfDtl", listtfDtl);
		reportMap.put("sumMap", sumMap);
		reportMap.put("smallsumList", smallsumList);
		return reportMap;
	}

	/**
	 * 数据字典MAP缓存
	 * 
	 * @param listDataSetEntities                数据集MAP
	 * @param dicWhereMap 报表模板解析MAP
	 */
	public void dicMap(List<RdpDataSetEntity> listDataSetEntities, Map<String, List<String>> dicWhereMap) {
		if (dicWhereMap.size() > 0) {
			for (String key : dicWhereMap.keySet()) {
				List<String> list = dicWhereMap.get(key);
				StringBuilder nstr = new StringBuilder();
				for (String nkey : list) {
					if (Cache.dicMap.get(nkey) == null) {
						nstr.append("'" + nkey + "',");
					}
				}
				if (nstr.toString().length() > 0) {
					String where = nstr.toString().substring(0, nstr.toString().length() - 1);
					String dataSourceName = "";
					String sql = "";
					List<FieldEntity> FieldsList = new ArrayList<FieldEntity>();
					for (RdpDataSetEntity dataSetEntity : listDataSetEntities) {
						if (dataSetEntity.getName().equals(key)) {
							dataSourceName = dataSetEntity.getDatasourcename();
							sql = dataSetEntity.getCommandtext();
							FieldsList = dataSetEntity.getFileds();
						} else {
							continue;
						}
					}

					DataSourceBean dataSourceBean = new DataSourceBean();
					if (Cache.dataSourceBeanMap.get(dataSourceName) != null) {
						dataSourceBean = Cache.dataSourceBeanMap.get(dataSourceName);
					} else {
						dataSourceBean = dataSourceService.getDataSourceBeanByDataSourceName(dataSourceName);
					}
					String KEY_NAME = "KEY_NAME";
					String OPT_CODE = "OPT_CODE";
					String OPT_NAME = "OPT_NAME";
					for (FieldEntity obj : FieldsList) {
						String DataField = obj.getName();
						Object dicType = "";
						if (obj.getDicType() != null) {
							dicType = obj.getDicType();
						}
						if (dicType.equals("type")) {
							KEY_NAME = DataField.toUpperCase();
						}
						if (dicType.equals("code")) {
							OPT_CODE = DataField.toUpperCase();
						}
						if (dicType.equals("text")) {
							OPT_NAME = DataField.toUpperCase();
						}
					}
					if (sql.length() > 0) {
						sql = sql.trim();
						if (sql.endsWith(";")) {
							sql = sql.substring(0, sql.length() - 1);
						}
					}
					if (sql.toLowerCase().indexOf(" where ") == -1&&sql.toLowerCase().indexOf(" order ")==-1&&sql.toLowerCase().indexOf(" group ")==-1) {
						sql = sql + " where " + KEY_NAME + " in (" + where + ")";
					} else {
						sql = "select * from (" + sql + ") a_dt where a_dt." + KEY_NAME + " in (" + where + ")";
					}
					List<Map<String, Object>> dicslist = DBUtil.getDbInfoUtil(dataSourceBean).getResultToList(sql, false, new HashMap<String, Object>());
					for (int i = 0; i < dicslist.size(); i++) {
						Map<String, Object> m = new HashMap<String, Object>();
						Set<String> ss = dicslist.get(i).keySet();
						for (String set : ss) {
							if (set.toUpperCase().equals(KEY_NAME)) {
								m.put("KEY_NAME", dicslist.get(i).get(set));
							} else if (set.toUpperCase().equals(OPT_CODE)) {
								m.put("OPT_CODE", dicslist.get(i).get(set));
							} else if (set.toUpperCase().equals(OPT_NAME)) {
								m.put("OPT_NAME", dicslist.get(i).get(set));
							}
						}
						Map<String, String> map = new HashMap<String, String>();
						if (!"".equals(m.get("OPT_CODE").toString())) {
							map.put(m.get("OPT_CODE").toString(), m.get("OPT_NAME").toString());
							if (Cache.dicMap.get(m.get("KEY_NAME")) == null && !"".equals(m.get("KEY_NAME").toString())) {
								Cache.dicMap.put(m.get("KEY_NAME").toString(), map);
							} else {
								map = Cache.dicMap.get(m.get("KEY_NAME").toString());
								map.put(m.get("OPT_CODE").toString(), m.get("OPT_NAME").toString());
								Cache.dicMap.put(m.get("KEY_NAME").toString(), map);
							}
						}
					}
				}
			}
		}
	}

}
