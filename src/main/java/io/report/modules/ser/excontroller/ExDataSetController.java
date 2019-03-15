package io.report.modules.ser.excontroller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import io.report.common.db.bean.TableData;
import io.report.common.db.handler.DbInfoUtil;
import io.report.common.db.util.StringUtil;
import io.report.common.utils.R;
import io.report.common.validator.ValidatorUtils;
import io.report.modules.rdp.util.SqlParserUtil;
import io.report.modules.ser.entity.DataSetEntity;
import io.report.modules.ser.entity.DataSourceEntity;
import io.report.modules.ser.service.DataSetService;
import io.report.modules.ser.service.DataSourceService;
import io.report.modules.ser.util.SerHandler;
import io.report.modules.sys.shiro.ShiroUser;



/**
 * 数据集表
 *
 * @author jizh
 * @email jzh15084102133@126.com
 * @date 2018-08-29 18:01:10
 */
@RestController
@RequestMapping("/ex/ser/dataset")
public class ExDataSetController {
    @Autowired
    private DataSetService dataSetService;
    @Autowired
    private DataSourceService dataSourceService;
    @Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpServletResponse response;
    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
    	DataSetEntity dataSet = new DataSetEntity();
        List<DataSetEntity> list = dataSetService.getList(dataSet);
        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{dtId}")
    public R info(@PathVariable("dtId") Integer dtId){
        DataSetEntity dataSet = dataSetService.selectById(dtId);
        return R.ok().put("dataSet", dataSet);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody DataSetEntity dataSet){
    	dataSet.setTxOp(ShiroUser.getUserName());
    	dataSet.setUpOp(ShiroUser.getUserName());
    	dataSet.setTxDate(ShiroUser.getSysDate());
    	dataSet.setUpDate(ShiroUser.getSysDate());
        dataSetService.insert(dataSet);
        return R.ok().put("dataSet", dataSet);
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody DataSetEntity dataSet){
        ValidatorUtils.validateEntity(dataSet);
    	dataSet.setUpOp(ShiroUser.getUserName());
    	dataSet.setUpDate(ShiroUser.getSysDate());
        dataSetService.updateAllColumnById(dataSet);//全部更新
        return R.ok().put("dataSet", dataSet);
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] dtIds){
        dataSetService.deleteBatchIds(Arrays.asList(dtIds));
        return R.ok();
    }
    
    /**
     * 返回结果
     */
    @RequestMapping("/result")
    public R getResult(@PathParam("dtId") Integer dtId){
    	DataSetEntity dataSet = dataSetService.selectById(dtId);
        DbInfoUtil d = SerHandler.getDbInfoUtil(dataSet);
        
        String sqlstr = SqlParserUtil.getPageSql(dataSet.getType(), dataSet.getSql(), 1, 1);
		TableData td = d.getTableDataList(sqlstr, null);
        return R.ok().put("data", td);
    }
    
    /**
     * 返回结果
     */
    @RequestMapping("/sqlresult")
    @ResponseBody
    public R getSqlResult(@PathParam("dsId") String dsId,@PathParam("sql") String sql){
    	DataSourceEntity dataSource = dataSourceService.selectById(dsId);
    	DbInfoUtil d = SerHandler.getDbInfoUtil(dataSource);
		TableData td = d.getTableDataList(sql, null);
        return R.ok().put("data", td);
    }
    
    /**
     * 返回结果
     */
    @RequestMapping("/sqlgroupresult")
    @ResponseBody
    public R getSqlGroupResult(@RequestParam Map<String, Object> params){
    	String dtId = (String)params.get("dtId");
    	String columns[] = StringUtil.getObjectToArray((String)params.get("columns"),",");
    	String groups[] = StringUtil.getObjectToArray((String)params.get("groups"),",");
    	DataSetEntity dataSet = dataSetService.selectById(dtId);
    	DbInfoUtil d = SerHandler.getDbInfoUtil(dataSet);
		List<Map<String,Object>> list = d.getGroupList(dataSet.getSql(),columns, groups, new String[0]);
        return R.ok().put("data", list);
    }
    
    /**
     * 返回结果
     */
    @RequestMapping("/sqlgroupresult/series")
    @ResponseBody
    public R getSqlGroupSeriesResult(@RequestParam Map<String, Object> params){
    	String dtId = (String)params.get("dtId");
    	String columns[] = StringUtil.getObjectToArray((String)params.get("columns"),",");
    	String groups[] = StringUtil.getObjectToArray((String)params.get("groups"),",");
    	String series[] = StringUtil.getObjectToArray((String)params.get("series"),",");
    	DataSetEntity dataSet = dataSetService.selectById(dtId);
    	DbInfoUtil d = SerHandler.getDbInfoUtil(dataSet);
		List<?> list = d.getGroupSeriesList(dataSet.getSql(),columns, groups,series,new String[0]);
        return R.ok().put("data", list);
    }
}
