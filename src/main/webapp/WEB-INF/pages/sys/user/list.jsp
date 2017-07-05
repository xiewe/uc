<jsp:directive.page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"/>
<jsp:directive.include file="/WEB-INF/pages/include.inc.jsp"/> 

<own:paginationForm action="${contextPath }/user/list" page="${page }">
	<input type="hidden" name="search_LIKE_username" value="${param.search_LIKE_username }"/>
</own:paginationForm>

<form method="post" action="${contextPath }/security/user/list" onsubmit="return navTabSearch(this)">
	<div class="pageHeader">
		<div class="searchBar" id="commonSearchDiv">
			<ul class="searchContent">
				<li>
					<label>登录名称：</label>
					<input type="text" name="search_LIKE_username" value="${param.search_LIKE_username }"/>
				</li>			
			</ul>
			<div class="subBar">
				<ul>						
					<li><div class="button"><div class="buttonContent"><button type="button" onclick="clearAllSearchContent('commonSearchDiv');">清空</button></div></div></li>
					<li><div class="button"><div class="buttonContent"><button type="submit">搜索</button></div></div></li>
				</ul>
			</div>
		</div>
	</div>
</form>

<div class="pageContent">

	<div class="panelBar">
		<ul class="toolBar">
			<shiro:hasPermission name="User:save">
				<li><a class="add" href="${contextPath}/security/user/create" target="navTab"><span>添加用户</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:edit:owns">
				<li><a class="edit" href="${contextPath}/security/user/update/{slt_uid}" target="navTab"><span>编辑用户</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:delete:owns">
				<li><a class="delete" rel="ids" target="selectedTodo" href="${contextPath}/security/user/delete" title="确定要删除吗?"><span>删除用户</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:reset:owns">
				<li class="line">line</li>
				<li><a iconClass="arrow_refresh" target="ajaxTodo" href="${contextPath }/security/user/reset/password/{slt_uid}" title="确认重置密码为123456?"><span>重置密码</span></a></li>
				<li><a iconClass="user_go" target="ajaxTodo" href="${contextPath }/security/user/reset/status/{slt_uid}" title="确认更新状态?"><span>更新状态(启用/禁用)</span></a></li>
			</shiro:hasPermission>
			<shiro:hasPermission name="User:assign">				
				<li class="line">line</li>
				<li><a iconClass="shield_add" target="dialog" mask="true" width="400" height="500" href="${contextPath }/security/user/lookup2create/userRole/{slt_uid}"><span>分配角色</span></a></li>
				<li><a iconClass="shield_delete" target="dialog" mask="true" width="400" height="500" href="${contextPath }/security/user/lookup2delete/userRole/{slt_uid}"><span>撤销角色</span></a></li>
			</shiro:hasPermission>
		</ul>
	</div>
	
	<table class="table" layoutH="137" width="100%">
		<thead>
			<tr>
				<th width="3%"><input type="checkbox" group="ids" class="checkboxCtrl"></th>	
				<th width="7%">ID</th>		
				<th width="10%" orderField="username" class="${page.orderField eq 'username' ? page.orderDirection : ''}">登录名称</th>
				<th width="10%" orderField="email" class="${page.orderField eq 'email' ? page.orderDirection : ''}">邮箱地址</th>
				<th width="10%" orderField="phone" class="${page.orderField eq 'phone' ? page.orderDirection : ''}">电话</th>
				<th width="10%" orderField="organization.name" class="${page.orderField eq 'organization.name' ? page.orderDirection : ''}">所在组织</th>
				<th >角色</th>
				<th width="5%" orderField="status" class="${page.orderField eq 'status' ? page.orderDirection : ''}">账户状态</th>
				<th width="10%" orderField="createTime" class="${page.orderField eq 'createTime' ? page.orderDirection : ''}">创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${users}">
			<tr target="slt_uid" rel="${item.id}">
				<td><input name="ids" value="${item.id}" type="checkbox"></td>
				<td>${item.id}</td>
				<td>${item.username}</td>
				<td>${item.email}</td>
				<td>${item.phone}</td>
				<td>${item.organization.name}</td>
				<td>
					<c:forEach var="ur" items="${item.userRoles}">
						${ur.role.name }&nbsp;&nbsp;
					</c:forEach>
				</td>
				<td>${item.status == 0 ? "可用":"不可用"}</td>
				<td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>			
			</c:forEach>
		</tbody>
	</table>
	<!-- 分页 -->
	<own:pagination page="${page}"/>
</div>