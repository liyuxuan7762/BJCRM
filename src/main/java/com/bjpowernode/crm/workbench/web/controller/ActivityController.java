package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.ExcelUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.service.ActivityService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.OutputStream;
import java.util.*;

@Controller
public class ActivityController {

    @Autowired
    private UserService userService;
    @Autowired
    private ActivityService activityService;

    // 显示Activity的主页面，完成动态数据的加载
    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request) {
        // 1. 处理请求数据 无
        // 2.调用业务层相关方法
        List<User> userList = userService.queryAllUsers();
        // 3.将数据传递给jsp页面
        request.setAttribute("userList", userList);
        // 4.页面跳转
        return "workbench/activity/index";
    }

    // 保存市场活动 返回成功与否的Json对象
    @RequestMapping("/workbench/activity/saveActivity.do")
    @ResponseBody
    public Object saveActivity(Activity activity, HttpSession session) {
        // 1.接收数据并封装对象 封装额外的数据 比如创建用户id，活动id，创建时间
        activity.setId(UUIDUtils.getUUID());
        activity.setCreateTime(DateUtils.getFormatDate(new Date()));
        User currentUser = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        activity.setCreateBy(currentUser.getId());
        // 2.调用业务层方法
        ReturnObj obj = new ReturnObj();
        try {
            int result = activityService.saveCreatActivity(activity);
            if (result > 0) {
                obj.setCode("1");
                obj.setMessage("添加成功");
            } else {
                obj.setCode("0");
                obj.setMessage("系统忙......");
            }
        } catch (Exception e) {
            obj.setCode("0");
            obj.setMessage("系统忙......");
        }
        return obj; // 返回json对象
    }

    // 根据条件分页查询市场活动
    @RequestMapping("/workbench/activity/queryActivity.do")
    @ResponseBody
    public Object queryActivity(String name, String owner, String startDate, String endDate, int pageSize, int pageNo) {
        // 1.接收并封装参数
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("pageSize", pageSize);
        map.put("beginNo", (pageNo - 1) * pageSize);

        // 2.调用service层方法
        List<Activity> activityList = activityService.queryActivityByConditionForPage(map);
        int count = activityService.queryActivityTotalRowByCondition(map);

        //返回Json对象
        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("activityList", activityList);
        returnMap.put("totalRow", count);

        return returnMap;
    }

    // 根据ID删除市场活动
    @RequestMapping("/workbench/activity/deleteActivityByIds.do")
    @ResponseBody
    public Object deleteActivityByIds(String[] id) {
        ReturnObj obj = new ReturnObj();
        try {
            int result = activityService.deleteActivityByIds(id);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("系统忙，请稍后再试.....");
            }
        } catch (Exception e) {
            e.printStackTrace();
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统忙，请稍后再试.....");
        }
        return obj;
    }

    // 根据ID查询单个市场活动
    @RequestMapping("/workbench/activity/queryActivityById.do")
    @ResponseBody
    public Object queryActivityById(String id) {
        return activityService.queryActivityById(id);
    }

    // 更新市场活动
    @RequestMapping("/workbench/activity/updateActivity.do")
    @ResponseBody
    public Object updateActivity(Activity activity, HttpSession session) {
        ReturnObj obj = new ReturnObj();
        // 添加数据
        activity.setEditTime(DateUtils.getFormatDate(new Date()));
        User currentUser = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        activity.setEditBy(currentUser.getId());
        try {
            int result = activityService.updateActivity(activity);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("系统繁忙.......");
            }
        } catch (Exception e) {
            e.printStackTrace();
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统繁忙.......");
        }

        return obj;
    }

    // 批量导出所有市场活动
    @RequestMapping("/workbench/activity/exportAllActivities.do")
    public void exportAllActivities(HttpServletResponse response) throws Exception {
        // 1.调用业务方法查询所有市场活动
        List<Activity> activityList = activityService.queryAllActivities();
        HSSFWorkbook wb = ExcelUtils.exportExcel(activityList, "市场活动列表");
        response.setContentType("application/octet-stream;charset=UTF-8"); // 设置相应格式 不同的文件后缀名对应不同的格式
        response.addHeader("Content-Disposition", "attachment;filename=activityList.xls");
        OutputStream os = response.getOutputStream();
        wb.write(os);
        wb.close();
        os.flush();
    }

    // 导入市场活动
    @RequestMapping("/workbench/activity/importActivity.do")
    @ResponseBody
    public Object importActivity(MultipartFile file, HttpSession session) {
        List<Activity> activityList = new ArrayList<>();
        ReturnObj obj = new ReturnObj();
        try {
            // 1.获取用户上传文件的输入流，然后解析成excel文件
            HSSFWorkbook wb = new HSSFWorkbook(file.getInputStream());
            // 2.解析excel文件
            HSSFSheet sheet = wb.getSheetAt(0); // 获取第一个工作表
            HSSFRow row = null;
            HSSFCell cell = null;
            Activity activity = null;

            // 表结构 所属者 开始时间 结束时间 花费 活动描述
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                // 设置新的Activity的一些属性
                activity = new Activity();
                activity.setId(UUIDUtils.getUUID());
                User user = (User) session.getAttribute(Constants.SESSION_USER_KEY);
                activity.setCreateBy(user.getId());
                activity.setCreateTime(DateUtils.getFormatDate(new Date()));
                row = sheet.getRow(i);
                // 获取每一行的单元格
                for (int j = 0; j < row.getLastCellNum(); j++) {
                    cell = row.getCell(j);
                    // 获取单元格的数据
                    String value = ExcelUtils.getCellValueForString(cell);
                    switch (j) {
                        case 0:
                            activity.setOwner(userService.queryUserByName(value).getId());
                            break;
                        case 1:
                            activity.setStartDate(value);
                            break;
                        case 2:
                            activity.setEndDate(value);
                            break;
                        case 3:
                            activity.setCost(value);
                            break;
                        case 4:
                            activity.setDescription(value);
                            break;
                    }
                }
                activityList.add(activity);

                // 3.调用业务层方法
                int result = activityService.saveCreatedActivityByList(activityList);
                if (result > 0) {
                    // 插入成功
                    obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
                    obj.setMessage("成功添加了" + result + "条记录");
                } else {
                    obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                    obj.setCode("系统繁忙，添加失败......");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setCode("系统繁忙，添加失败......");
        }
        return obj;
    }
}
