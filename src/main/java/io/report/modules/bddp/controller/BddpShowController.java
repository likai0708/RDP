package io.report.modules.bddp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.pro.encryption.entrance.report.loader.RDPCoreContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import cn.hutool.http.HttpRequest;
import io.report.common.utils.R;
import io.report.common.utils.ServerUtil;
import io.report.modules.bddp.entity.BddpConstant;

@RestController
@RequestMapping("/bddpshow")
public class BddpShowController {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${report.bddp.path}")
	private String bddppath;
	@Value("${report.relative-path}")
	private Boolean relativePath;
	@Autowired
	HttpServletRequest rq;
	@Autowired
	HttpServletResponse rp;

	@RequestMapping("/show/{i}")
	public void show(@PathVariable("i") String i) {
		logger.info("正在打开大屏幕报表：" + i);
		RDPCoreContext.html(rp, ServerUtil.getDataPath(relativePath, bddppath, BddpConstant.BDDPFILE_PATH), i);
	}

	@RequestMapping("/bgi/{i}")
	public void bgi(@PathVariable("i") String i) throws Exception {
		RDPCoreContext.png(rq, rp, ServerUtil.getDataPath(relativePath, bddppath, BddpConstant.BDDPFILE_PATH), i);
	}

	/**
	 * 取所有的字段
	 * 
	 * @param url  服务地
	 * @return
	 */
	@RequestMapping(value = "/getJSONDataByUrl", method = { RequestMethod.GET, RequestMethod.POST })
	public R getJSONDataByUrl(@RequestParam("url") String url) {
		String result = "";
		try {
			url = url.replace("&amp;", "&");
			result =HttpRequest.get(url).header("Accept", "application/json, */*").contentType("application/json").timeout(5000).execute().body();
			logger.debug("请求:"+url+"返回的结果");
			logger.debug(result);
			try {
				return R.ok().put("list", JSONObject.parseObject(result));
			} catch (Exception ex) {
				try {
					return R.ok().put("list", JSONObject.parseArray(result));
				} catch (Exception ex1) {
					return R.error("获取出错！JSON数据格式不正常");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return R.error("获取出错！");
		}

	}
}
