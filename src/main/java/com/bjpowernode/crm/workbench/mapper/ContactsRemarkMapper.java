package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.domain.ContactsRemark;

import java.util.List;

public interface ContactsRemarkMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    int insert(ContactsRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    int insertSelective(ContactsRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    ContactsRemark selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    int updateByPrimaryKeySelective(ContactsRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_contacts_remark
     *
     * @mbggenerated Fri Oct 28 22:22:16 CST 2022
     */
    int updateByPrimaryKey(ContactsRemark record);

    int insertContactsRemark(List<ContactsRemark> list);
}