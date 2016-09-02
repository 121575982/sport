<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>门禁管理</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link href="../../mui/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="../../css/headOfHouse/keyManage.css" />
	</head>

	<body>
		<nav class="mui-bar mui-bar-tab footer">
			<a id="footer_headApplay">
				<p>申请成为户主 <span class="mui-icon mui-icon-forward"></span> </p>
			</a>
		</nav>
		<div class="mui-content">
			<!--门禁钥匙申请-->
			<header class="header">
				<a id="header_keyApplay">
					<p>申请成为业主 <span class="mui-icon mui-icon-forward"></span> </p>
				</a>
			</header>
			<!--我的钥匙-->
			<div class="ownkey">
				<h4 class="title">
		    		我的钥匙
		    	</h4>
		    	<ul class="mui-table-view">
			    	<c:forEach var="doorUser" items="${doorUsers }">
						<c:choose>
							<c:when test="${empty doorUser.applytype}">
								<li class="mui-table-view-cell">
									<a>
										<p class="pid" data-id="${doorUser.cfgUcode }" data-title="${doorUser.cbUcode }">${doorUser.cfgUname }</p>
										<p><span class="gary">${doorUser.cbUname}</span>&nbsp;&nbsp;<span class="gary headTime" >${doorUser.keyExpiry }</span></p>
									</a>
								</li>
							</c:when>
							<c:when test="${doorUser.applytype==1}">
								<li class="mui-table-view-cell">
									<a>
										<p class="pid" data-id="${doorUser.cfgUcode }" data-title="${doorUser.cbUcode }">${doorUser.cfgUname }</p>
										<p><span class="gary">${doorUser.cbUname}</span> &nbsp;&nbsp;<span class="gary headTime" >${doorUser.keyExpiry }</span></p>
									</a>
								</li>
							</c:when>
							<c:when test="${doorUser.applytype==2}">
								<c:choose>
									<c:when test="${doorUser.userstatu==1}">
										<li class="mui-table-view-cell">
											<a>
												<p class="pid" data-id="${doorUser.cfgUcode }" data-title="${doorUser.cbUcode }">${doorUser.cfgUname } <span class="gary">户主(审核中)</span></p>
												<p><span class="gary">${doorUser.cbUname}</span> &nbsp;&nbsp;<span class="gary headTime" >${doorUser.keyExpiry }</span></p>
											</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="mui-table-view-cell">
											<a class="mui-navigate-right">
												<p class="pid" data-id="${doorUser.cfgUcode }" data-title="${doorUser.cbUcode }">${doorUser.cfgUname } <span class="gary">户主</span></p>
												<p><span class="gary">${doorUser.cbUname}</span> &nbsp;&nbsp;<span class="gary headTime" >${doorUser.keyExpiry }</span></p>
											</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:when>
						</c:choose>
						
			    	</c:forEach>
		    	</ul>
			</div>
		</div>
		<script src="../../mui/js/mui.min.js"></script>
		<script type="text/javascript">
			mui.init();
//			有效期时间格式化
			var span=document.getElementsByClassName("headTime");
			var headT='';
			var yy='';
			var mm='';
			var dd='';
			for(var i=0;i<span.length;i++){
				headT=span[i].innerHTML,
				yy=headT.slice(0,4),
				mm=headT.slice(4,6),
				dd=headT.slice(6,8);
				span[i].innerHTML="有效期至："+yy+"-"+mm+"-"+dd;
			}
			//跳转申请成为业主页面
			document.getElementById("header_keyApplay").addEventListener("tap", function() {
				location.href = "keyApply.do";
				document.cookie="applytype="+encodeURI(1);
			});
			//跳转申请成为户主页面
			document.getElementById("footer_headApplay").addEventListener("tap", function() {
				location.href = "keyApply.do";
				document.cookie="applytype="+encodeURI(2);
			});
			//户主进入  钥匙管理页面
			mui(".mui-table-view").on("tap", ".mui-navigate-right", function() {
				var comCode = this.getElementsByClassName("pid")[0].dataset.id;
				var buildCode = this.getElementsByClassName("pid")[0].dataset.title;
				
 				location.href="getAccess.do?comCode="+comCode+"&buildCode="+buildCode;
			});
		</script>
	</body>

</html>