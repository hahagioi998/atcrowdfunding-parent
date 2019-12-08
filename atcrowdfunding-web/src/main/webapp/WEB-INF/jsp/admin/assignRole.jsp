<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>

	<jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"></jsp:include>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
					<li><a href="#">数据列表</a></li>
					<li class="active">分配角色</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-body">
						<form role="form" class="form-inline">
							<div class="form-group">
								<label for="exampleInputPassword1">未分配角色列表</label><br>
								<select id="leftRoleList" class="form-control" multiple size="10"
									style="width: 250px; overflow-y: auto;">
									<c:forEach items="${unAssignList}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<ul>
									<li id="leftToRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
									<br>
									<li id="rightToLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left"
										style="margin-top: 20px;"></li>
								</ul>
							</div>
							<div class="form-group" style="margin-left: 40px;">
								<label for="exampleInputPassword1">已分配角色列表</label><br>
								<select id="rightRoleList" class="form-control" multiple size="10"
									style="width: 250px; overflow-y: auto;">
									<c:forEach items="${assignList}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</select>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">帮助</h4>
				</div>
				<div class="modal-body">
					<div class="bs-callout bs-callout-info">
						<h4>测试标题1</h4>
						<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
					</div>
					<div class="bs-callout bs-callout-info">
						<h4>测试标题2</h4>
						<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
					</div>
				</div>
				<!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
	<script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            
            //分配角色
            $("#leftToRightBtn").click(function(){
            	var leftSelectRoleList = $("#leftRoleList option:selected");
            	
            	if(leftSelectRoleList.length == 0){
            		layer.msg("请选择要分配的角色",{time:2000,icon:6});
            		return false;
            	}else{
            		var str = '';
            		$.each(leftSelectRoleList,function(i,e){
            			var roleId = e.value;
            			str+="roleId="+roleId+"&";
            		});
            		str+="adminId=${param.id}";
            		
            		$.ajax({
            			type:"post",
            			url:"${PATH}/admin/doAssign",
            			data:str,
            			success:function(result){
            				if(result == "ok"){
            					layer.msg("分配的角色成功",{time:1000,icon:6},function(){
            						$("#rightRoleList").append(leftSelectRoleList.clone());
                					leftSelectRoleList.remove();
            					});
            				}else{
            					layer.msg("分配的角色失败",{time:1000,icon:5});
            				}
            			}
            		});
            		
            		
            		
            	}
            });
            
            //取消分配角色
            $("#rightToLeftBtn").click(function(){
            	var rightSelectRoleList = $("#rightRoleList option:selected");
            	
            	if(rightSelectRoleList.length == 0){
            		layer.msg("请选择要分配的角色",{time:2000,icon:6});
            		return false;
            	}else{
            		var str = '';
            		$.each(rightSelectRoleList,function(i,e){
            			var roleId = e.value;
            			str+="roleId="+roleId+"&";
            		});
            		str+="adminId=${param.id}";
            		
            		$.ajax({
            			type:"post",
            			url:"${PATH}/admin/doUnAssign",
            			data:str,
            			success:function(result){
            				if(result == "ok"){
            					layer.msg("分配的角色成功",{time:1000,icon:6},function(){
                					$("#leftRoleList").append(rightSelectRoleList.clone());
                	            	rightSelectRoleList.remove();
            					});
            				}else{
            					layer.msg("分配的角色失败",{time:1000,icon:5});
            				}
            			}
            		});            		
            	}
            });
        </script>
</body>
</html>