package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    int insert(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    int insertSelective(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    ActivityRemark selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    int updateByPrimaryKeySelective(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Thu Oct 20 14:49:26 CST 2022
     */
    int updateByPrimaryKey(ActivityRemark record);

    // 根据市场活动ID查询市场活动评论
    List<ActivityRemark> selectActivityRemarkByActivityId(String activityId);

    // 插入一条市场活动评论
    int insertActivityRemark(ActivityRemark activityRemark);

    // 删除一条市场活动评论
    int deleteActivityRemark(String remarkId);

    // 修改评论
    int updateActivityRemark(ActivityRemark activityRemark);
}