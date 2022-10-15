package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    int insert(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    // 插入一条记录
    int insertSelective(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    Activity selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    int updateByPrimaryKeySelective(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Tue Oct 11 14:08:47 CST 2022
     */
    int updateByPrimaryKey(Activity record);

    // 插入一条市场活动
    int insertActivity(Activity activity);

    // 按照条件查询市场活动信息
    List<Activity> selectActivityByConditionForPage(Map<String, Object> map);

    // 根据条件查询市场活动总条数
    int selectActivityTotalRowByCondition(Map<String, Object> map);

}