<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page import="com.educonsulting.mms.util.SpringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div>
    <fieldset class="fieldset">
        <legend class="legend">
            <%=SpringUtils.getMessage("member.form.parent")%>
        </legend>
        <table class="tab-border" style="height: 300px;">
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.cnName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="cnName" name="cnName"
                           data-options="required:true,
                           missingMessage:'<%=SpringUtils.getMessage("member.form.cnNameRequired")%>'">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.cardNo")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="cardNo" name="cardNo"
                           data-options="required:true,
                           missingMessage:'<%=SpringUtils.getMessage("member.form.cardNoRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.enName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="enName" name="enName"></td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.sex")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="sex" name="sex"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.sexRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.birth")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox textbox" id="birth" name="birth"
                           data-options="required:true,
                           editable:false,
                           missingMessage:'<%=SpringUtils.getMessage("member.form.birthRequired")%>'">
                </td>
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.relation")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="relation" name="relation"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/relation',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.relationRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.mobile")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="mobile" name="mobile"
                           data-options="required:true,missingMessage:'<%=SpringUtils.getMessage("member.form.mobileRequired")%>'">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.eduDegree")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="eduDegree" name="eduDegree"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/eduDegree',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.eduDegreeRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.industry")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="industry" name="industry"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/industry',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:200,
                                                required:true,
                                                editable:false,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.industryRequired")%>'">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.job")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="job" name="job"
                           data-options="required:true,missingMessage:'<%=SpringUtils.getMessage("member.form.jobRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.email")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="email" name="email">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.registerDate")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="registerDate" name="registerDate"
                           data-options="editable:false">
                    <input type="hidden" id="createDate" name="createDate" value="">
                    <input type="hidden" id="id" name="id" value="">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.address")%>
                </td>
                <td colspan="3" class="domain-bg">
                    <input class="easyui-combobox" id="state" name="state"
                           data-options="panelHeight:200,
                                                required:true,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.stateRequired")%>'">
                    <%=SpringUtils.getMessage("member.form.state")%>
                    <input class="easyui-combobox" id="city" name="city"
                           data-options="method:'post',
                                                valueField:'id',
                                                textField:'name',
                                                panelHeight:200,
                                                required:true,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.cityRequired")%>'">
                    <%=SpringUtils.getMessage("member.form.city")%>
                    <input class="easyui-combobox" id="district" name="district"
                           data-options="method:'post',
                                                valueField:'id',
                                                textField:'name',
                                                panelHeight:200,
                                                required:true,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.districtRequired")%>'">
                    <%=SpringUtils.getMessage("member.form.district")%>
                    <input class="easyui-validatebox textbox" id="street" name="street"
                           data-options="required:true,missingMessage:'<%=SpringUtils.getMessage("member.form.streetRequired")%>'">
                    <%=SpringUtils.getMessage("member.form.street")%>
                    <input type="hidden" id="address" name="address">
                </td>
            </tr>
        </table>
    </fieldset>
</div>
<div style="padding-top: 20px;">
    <fieldset class="fieldset">
        <legend class="legend">孩子基本信息</legend>
        <table class="tab-border">
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-validatebox textbox" id="firstKidCnName"
                           name="firstKidCnName"
                           data-options="required:true,missingMessage:'<%=SpringUtils.getMessage("member.form.kidCnNameRequired")%>'">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidEnName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="firstKidEnName" name="firstKidEnName">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidBirth")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="firstKidBirth"
                           name="firstKidBirth"
                           data-options="required:true,editable:false,missingMessage:'<%=SpringUtils.getMessage("member.form.kidBirthRequired")%>'">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidSex")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="firstKidSex" name="firstKidSex"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                required:true,
                                                editable:false,
                                                missingMessage:'<%=SpringUtils.getMessage("member.form.kidSexRequired")%>'">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </td>
                <td class="domain-bg">
                    <input class="textbox" id="secondKidCnName"
                           name="secondKidCnName">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidEnName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="secondKidEnName" name="secondKidEnName">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidBirth")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="secondKidBirth"
                           name="secondKidBirth"
                           data-options="editable:false">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidSex")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="secondKidSex" name="secondKidSex"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                editable:false">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidCnName")%>
                </td>
                <td class="domain-bg">
                    <input class="textbox" id="thirdKidCnName"
                           name="thirdKidCnName">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidEnName")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-textbox" id="thirdKidEnName" name="thirdKidEnName">
                </td>
            </tr>
            <tr>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidBirth")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-datebox" id="thirdKidBirth"
                           name="secondKidBirth"
                           data-options="editable:false">
                </td>
                <td class="title-bg">
                    <%=SpringUtils.getMessage("member.form.kidSex")%>
                </td>
                <td class="domain-bg">
                    <input class="easyui-combobox" id="thirdKidSex" name="thirdKidSex"
                           data-options="url:'${pageContext.request.contextPath}/dict/findDict/sex',
                                                method:'get',
                                                valueField:'value',
                                                textField:'name',
                                                panelHeight:'auto',
                                                editable:false">
                </td>
            </tr>
        </table>
    </fieldset>
</div>