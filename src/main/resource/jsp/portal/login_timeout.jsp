<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/include.inc.jsp"%>
<div class="bjui-pageContent">
    <form action="${pageContext.request.contextPath}/user/relogin.do" data-toggle="validate" method="post">
        <div class="form-group">
            <label class="control-label x85">用户名：</label>
            <input type="text" data-rule="required" name="username" value="" placeholder="请输入用户名" size="20">
        </div>
        <div class="form-group">
            <label class="control-label x85">密　码：</label>
            <input type="password" data-rule="required" name="passwordhash" value="" placeholder="请输入密码" size="20">
        </div>
    </form>   
</div>
<div class="bjui-pageFooter">
    <ul>
        <li><button type="submit" class="btn-default">确定</button></li>
        <li><button type="button" class="btn-close">取消</button></li>
    </ul>
</div>