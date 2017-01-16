<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html> <!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]--> <!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]--> <!--[if !IE]><!-->
<html lang="zh">
<!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <title>${shop:shopTitle('productName')}</title>
    <meta name="decorator" content="default"/>
</head>
<!-- END HEAD -->

<body class="page-header-static page-sidebar-closed-hide-logo page-content-white">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <sys:sidebar navItemName="代码生成" subMenuName="业务表配置" />

    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->

            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <a href="${ctx}/gen/genTable/">业务表列表</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>业务表${not empty genTable.id?'修改':'添加'}</span>
                    </li>
                </ul>
                <div class="page-toolbar">
                </div>
            </div>
            <!-- END PAGE BAR -->

            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title"> 业务表${not empty genTable.id?'修改':'添加'} <small></small></h3>
            <!-- END PAGE TITLE-->

            <!-- END PAGE HEADER-->

            <!-- BEGIN TABLE -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light portlet-fit portlet-form bordered">
                        <c:choose>
                            <c:when test="${empty genTable.name}">
                                <form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/form" method="post">
                                    <form:hidden path="id"/>
                                    <div class="form-body">
                                        <div class="alert alert-danger display-hide">
                                            <button class="close" data-close="alert"></button><i class="fa fa-close"></i> 表单填写时出现了一些问题，请仔细检查...
                                        </div>
                                        <div class="alert alert-success display-hide">
                                            <button class="close" data-close="alert"></button><i class="fa fa-check"></i> 正在提交数据，请稍候...
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <form:select path="name" class="form-control required">
                                                <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false" />
                                            </form:select>
                                            <label> 表名</label>
                                        </div>
                                    </div>
                                    <div class="form-actions" style="margin-top: 20px;">
                                        <input id="btnSubmit" class="btn blue" type="submit" value="下一步"/>&nbsp;
                                        <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
                                    </div>
                                </form:form>
                            </c:when>
                            <c:otherwise>
                                <form:form id="inputForm1" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post">
                                    <form:hidden path="id"/>
                                    <div class="form-body">
                                        <div id="messageBox" class="alert alert-danger ${empty message ? 'display-hide' : ''}">
                                            <button class="close" data-close="alert"></button> ${message}
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <form:input path="name" htmlEscape="false" class="form-control required" readonly="true" />
                                            <label> 表名</label>
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <form:input path="comments" htmlEscape="false" class="form-control required" />
                                            <label> 说明</label>
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <form:input path="primaryId" htmlEscape="false" class="form-control required" />
                                            <label> 主键名</label>
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <form:input path="className" htmlEscape="false" class="form-control required" />
                                            <label> 类名</label>
                                        </div>
                                            <%--<div class="form-group form-md-line-input">--%>
                                            <%--<form:select path="parentTable" cssClass="form-control">--%>
                                            <%--<form:option value="">无</form:option>--%>
                                            <%--<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>--%>
                                            <%--</form:select>--%>
                                            <%--<label> 父表表名</label>--%>
                                            <%--</div>--%>
                                            <%--<div class="form-group form-md-line-input">--%>
                                            <%--<form:select path="parentTableFk" cssClass="form-control">--%>
                                            <%--<form:option value="">无</form:option>--%>
                                            <%--<form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>--%>
                                            <%--</form:select>--%>
                                            <%--<label> 当前表外键</label>--%>
                                            <%--<span class="help-block">如果有父表，请指定父表表名和外键</span>--%>
                                            <%--</div>--%>
                                        <div class="form-group form-md-line-input">
                                            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
                                            <label> 备注</label>
                                        </div>
                                        <div class="form-group form-md-line-input">
                                            <div class="row">
                                                <div class="portlet">
                                                    <div class="portlet-title" style="padding-left: 18px;">
                                                        字段列表
                                                    </div>
                                                    <div class="portlet-body">
                                                        <table id="contentTable" class="table table-striped table-hover table-bordered">
                                                            <thead>
                                                            <tr style="white-space: nowrap;">
                                                                <th>列名
                                                                    <i class="icon-question tooltips" title="数据库字段名"></i></th>
                                                                <th>说明
                                                                    <i class="icon-question tooltips" title="默认读取数据库字段备注"></i></th>
                                                                <th>物理类型
                                                                    <i class="icon-question tooltips" title="数据库中设置的字段类型及长度"></i></th>
                                                                <th>Java类型
                                                                    <i class="icon-question tooltips" title="实体对象的属性字段类型"></i></th>
                                                                <th>Java属性名称
                                                                    <i class="icon-question tooltips" title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）"></i>
                                                                </th>
                                                                <th>主键
                                                                    <i class="icon-question tooltips" title="是否是数据库主键"></i></th>
                                                                <th>可空
                                                                    <i class="icon-question tooltips" title="字段是否可为空值，不可为空字段自动进行空值验证"></i></th>
                                                                <th>插入
                                                                    <i class="icon-question tooltips" title="选中后该字段被加入到insert语句里"></i></th>
                                                                <th>编辑
                                                                    <i class="icon-question tooltips" title="选中后该字段被加入到update语句里"></i></th>
                                                                <th>列表
                                                                    <i class="icon-question tooltips" title="选中后该字段被加入到查询列表里"></i></th>
                                                                <th>查询
                                                                    <i class="icon-question tooltips" title="选中后该字段被加入到查询条件里"></i></th>
                                                                <th>查询匹配方式
                                                                    <i class="icon-question tooltips" title="该字段为查询字段时的查询匹配方式"></i></th>
                                                                <th>显示表单类型
                                                                    <i class="icon-question tooltips" title="字段在表单中显示的类型"></i></th>
                                                                <th>字典类型
                                                                    <i class="icon-question tooltips" title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型"></i></th>
                                                                <th>排序</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
                                                                <tr${column.delFlag eq '1'?' class="danger" title="已删除的列，保存之后消失！"':' class="active"'}>
                                                                    <td nowrap>
                                                                        <input type="hidden" name="columnList[${vs.index}].id" value="${column.id}"/>
                                                                        <input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}"/>
                                                                        <input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}"/>
                                                                        <input type="hidden" name="columnList[${vs.index}].name" value="${column.name}"/>${column.name}
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="form-control required" style="width:100px;"/>
                                                                    </td>
                                                                    <td nowrap>
                                                                        <input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}"/>${column.jdbcType}
                                                                    </td>
                                                                    <td>
                                                                        <select name="columnList[${vs.index}].javaType" class="form-control required" style="width:85px;*width:75px">
                                                                            <c:forEach items="${config.javaTypeList}" var="dict">
                                                                                <option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="form-control required" style="width: 150px;"/>
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isInsert" value="1" ${column.isInsert eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="checkbox" name="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''} class="form-control" />
                                                                    </td>
                                                                    <td>
                                                                        <select name="columnList[${vs.index}].queryType" class="form-control required" style="width: 100px;">
                                                                            <c:forEach items="${config.queryTypeList}" var="dict">
                                                                                <option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </td>
                                                                    <td>
                                                                        <select name="columnList[${vs.index}].showType" class="form-control required" style="width:120px;">
                                                                            <c:forEach items="${config.showTypeList}" var="dict">
                                                                                <option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="form-control" style="width: 150px;"/>
                                                                    </td>
                                                                    <td>
                                                                        <input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="form-control required digits" style="text-align: center; width: 80px;" />
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-actions" style="margin-top: 20px;">
                                        <shiro:hasPermission name="gen:genTable:edit"><input id="btnSubmit" class="btn blue" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
                                        <input id="btnCancel" class="btn default" type="button" value="返 回" onclick="history.go(-1)"/>
                                    </div>
                                </form:form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <!-- END TABLE -->
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/WEB-INF/views/include/footer.jsp" %>
<c:choose>
    <c:when test="${empty genTable.name}">
        <sys:validateForm form="inputForm" />
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
            $(function () {
                $("#inputForm1").validate({
                    errorClass: 'help-block help-block-error',

                    submitHandler: function (form) {
                        Custom.initStartPageBlockUI();
                        $("input[type=checkbox]").each(function () {
                            $(this).after("<input class=\"form-control\" type=\"hidden\" name=\"" + $(this).attr("name") + "\" value=\"" + ($(this).attr("checked") ? "1" : "0") + "\"/>");
                            $(this).attr("name", "_" + $(this).attr("name"));
                        });
                        form.submit();
                    },

                    errorContainer: "#messageBox",

                    highlight: function (element) { // hightlight error inputs
                        $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
                    },

                    success: function (label) {
                        label.closest('.form-group').removeClass('has-error');
                        label.remove();
                    },

                    errorPlacement: function (error, element) {
                        $("#messageBox").text("表单填写时出现了一些问题，请仔细检查...");
                        if (element.is(':checkbox')) {
                            error.insertAfter(element.closest(".md-checkbox-list, .md-checkbox-inline, .checkbox-list, .checkbox-inline"));
                        } else if (element.is(':radio')) {
                            error.insertAfter(element.closest(".md-radio-list, .md-radio-inline, .radio-list,.radio-inline"));
                        } else {
                            error.insertAfter(element);
                        }
                    }
                });
            });
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>