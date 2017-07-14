<jsp:directive.page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" />
<jsp:directive.include file="/WEB-INF/pages/include.inc.jsp" />

<div class="row main-content">
    <form class="form-horizontal" role="form" method="post" action="${contextPath }/role/create" onsubmit="return doSave(this, '${contextPath }/role/list');">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="name" placeholder="请输入组织名字">
            </div>
        </div>
        <div class="form-group">
            <label for="parentId" class="col-sm-2 control-label">父组织</label>
            <div class="col-sm-10">
                <select class="form-control" name="parentId">
                    <option value=""></option>
                    <c:forEach var="item" items="${roles}">
                        <option value="${item.id }">${item.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="description" class="col-sm-2 control-label">描述</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="3" name="description" placeholder="请输入描述"></textarea>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary">确定</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">


</script>
