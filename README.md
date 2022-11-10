## 动力节点CRM项目制作
## 使用Git每天跟踪项目进度
项目视频地址链接：https://www.bilibili.com/video/BV1tZ4y1d7kg/?p=1
### 技术栈 JSP + Echart + Spring + SpringMVC + MyBatis + MySQL

## 2022/10/8

需求分析和项目的简介

## 2022/10/9 

实现登录功能，并对代码进行了优化，创建了日期工具类和常量类。

## 2022/10/10 

1.完成对workbench/index.html改造为jsp页面

2.完成显示在所有页面上都显示用户名的操作 [使用session 了解四种作用域的范围和使用情况]

3.完成用户点击登录后如果网络比较慢提示正在验证的信息 [使用ajax的beforeSend函数进行实现]

4.完成回车登录 [使用keyCode实现]

5.完成记住密码 [使用Cookie实现]

6.完成安全退出功能 [清理session和cookie]

## 2022/10/11

1.为了防止未登录用户通过url直接访问主页面，需要根据用户登录状态判断是否跳转到登录页面[使用拦截器实现]

2.分析index.jsp页面的前端构成，并完成了主界面iframe的设置

3.了解Bootstrap中的模态窗口的使用

4.完成跳转到市场活动页面，并实现页面数据的动态加载

5.分析添加市场活动的流程图

## 2022/10/12

1.通过Mybatis逆向工程生成市场活动表的Mapper和实体类文件

2.完成ActivityService和相关Controller的编写

3.完成前端页面JQuery代码的编写，顺便复习了正则表达式相关内容

4.了解Boostrap中的DateTimePicker插件的相关配置，并整理出通用的JS插件的使用步骤

## 2022/10/15

1.完成分页功能的mapper, service, controller, 前端页面Js编写

2.学习并完成了Boostrap框架的pagination分页插件的使用以及如何应用到现有的CRM项目中

## 2022/10/16

1.使用Boostrap框架的pagination分页插件实现分页效果

2.完成分页功能的细节优化

3.完成删除市场活动的UML流程图

4.了解了HTML页面中固有元素和动态元素的区别，了解了JQuery中不同.click() 和 $(父).on('click',子,function)加事件方式

5.完成全选、取消全选功能

## 2022/10/17

1.完成删除市场活动功能的实现 

2.独立分析并完成修改市场活动的功能

## 2022/10/18

1.学习Apache-poi插件的使用，了解如何使用该插件生成Excel文件

2.完成批量导出所有市场活动的功能

3.由于视频中的导出Excel代码过于冗余，所以自己使用反射机制重新实现将list数据封装到Excel文件中的工具类，实现了任意list都可以根据其里面实体类的类型来生成Excel文件的功能


## 2022/10/19

1.学习Apache-poi插件的如何解析Excel文件。

2.完成使用Excel文件导入市场活动的后台代码部分。

## 2022/10/20

1.完成上传文件前台代码编写。学了了jQuery中formData对象的使用

2.踩坑 ContentType 不是ContextType!!!!!!

3.完成查询市场活动明细功能的流程图绘制

4.使用逆向工程生成评论表相关类

5.完成显示市场活动信息详情和其对应的后台代码 (有BUG，需要调试)

## 2022/10/21 

1.调试显示市场活动详情的代码

2.完成添加评论的功能

3.学习了jQuery中的几个函数的区别text(),html(),append(),before(), after()

## 2022/10/23

1.完成删除评论功能前后端代码

2.完成修改市场活动的前后端代码

3.市场活动所有业务均已做完，！！需要完善选择部分市场互动导出功能！！

4.了解数组字典

5.完成线索主界面显示的前后端代码

6.完成插入线索的前后端代码

## 2022/10/24

1.完成线索详情，线索评论，线索关联的市场活动信息的前后端代码

2.通过异步请求方式完成用户输入相关的市场活动信息实时显示匹配的市场活动

## 2022/10/28

1.完成关联市场活动，解除关联市场活动功能

2.线索转换功能。线索是给初级销售使用的。如果有购买意向，则将该线索转换到客户模块（存储公司信息，给那些比较了解公司流程和法律的销售去进一步联系）
   和联系人模块（给那些擅长共同的销售去联系）供高级销售使用，没有购买意向的存入用户公海模块。最后完成转换后删除线索信息

3.完成线索转换功能的前期准备工作，包括页面的跳转，动态数据刷新，实时查询等功能

4.完成线索转换到客户模块的功能


## 2022/10/29

1.完成线索转换剩余的业务代码

2.完成创建交易的前端和后端所有代码。其中难点为根据用户给定配置文件显示交易可能性，第二个是实现公司全称的自动补全。

3.了解xml和properties配置文件的异同和适用场景

4.使用typeahead插件实现自动补全

5.实现创建交易

## 2022/10/30  2022/10/31

1.完成查看交易明细信息

2.完成根据交易不同的进度使用进度条动态显示交易执行到的阶段

3.使用echarts的漏斗图图形化展示所有交易所处的阶段

# 完结
