<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="format-detection" content="telephone=no" />
		<title>楼栋号选择列表</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="../../../mui/css/mui.min.css?rnd=0">
		<link rel="stylesheet" href="../../../css/headOfHouse/keyApply.css?rnd=0" />
		
	</head>

	<body>
		
	<div class="mui-content">
		  
		<!--下拉刷新容器-->
		<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
			<div class="mui-scroll">
				<!--搜索框-->
				<div class="mui-input-row mui-search danyuan_search">
					<input type="search" class="mui-input-clear" placeholder="请输入楼栋信息..." id="danyuan_search">
				</div>
				<div class="search_btn">
					<input type="button" id="btn_search" class="mui-btn mui-btn-primary mui-btn-outlined" value="搜索" />
				</div>
				<!--数据列表-->
				<ul class="mui-table-view mui-table-view-chevron">
					<c:forEach var="build" items="${builds }">
						<li class="mui-table-view-cell">
							<a href="" id="${build.cbUcode }">
								${build.cbUname }
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
		<script src="../../../mui/js/mui.min.js"></script>
		<script>
			var dUrl=document.location.search;
			var xId=dUrl.substring(dUrl.lastIndexOf("=")+1,dUrl.lenght);
			/**
			 * 排序请求后台
			 */
			function pulldownRefresh(danyuan) {
				
				mui.ajax('jsonGetBuilding.do', {
					data: {
						building:danyuan,
						comCode:xId
					},
					type: 'post', //HTTP请求类型
					timeout: 20000, //超时时间设置为20秒；
					success: function(data) {
						var table = document.body.querySelector('.mui-table-view');
						table.innerHTML = '';
						for (var i = 0; i < data.builds.length; i++) {
							html = '<a href="#" id='+data.builds[i].cbUcode+'>';
							html += data.builds[i].cbUname;
							html += '</a>';
							var li = document.createElement('li');
							li.className = 'mui-table-view-cell';
							li.innerHTML = html;
							//下拉刷新，新纪录插到最前面；
							table.appendChild(li);
						}
					},
					error: function(xhr, type, errorThrown) {
						console.log(type);
					}
				});
			}

			
			//获取cookie函数
			function getCookie(name) {
			   var cookies = document.cookie.split(";");
			   //var cookies = document.cookie;
			   for(var i=0;i<cookies.length;i++) {
			    var cookie = cookies[i];
			    var cookieStr = cookie.split("=");
			    if(cookieStr && cookieStr[0].trim()==name) {
			     return  decodeURI(cookieStr[1]);
			    }
			   }
			 }
			 //去掉空格函数
			 String.prototype.trim = function() {
			  return this.replace(/^(\s*)|(\s*)$/g,"");
			 }
			 //点击选择单元
			mui(".mui-table-view").on('tap', '.mui-table-view-cell', function(event) {
				var target=event.srcElement||event.target;
				var danyuan=(target.innerHTML!=undefined?target.innerHTML:"");
				var xiaoqu=(getCookie("xiaoqu")!=undefined?getCookie("xiaoqu"):"");
				var address=encodeURI(xiaoqu+danyuan);
				var dId=target.id;
				document.cookie="address="+address;
				document.cookie="xId="+encodeURI(xId);
				document.cookie="dId="+encodeURI(dId);
				location.href="keyApply.do?xId="+xId+"&dId="+dId;
			});
			//查询单元
			document.getElementById("btn_search").addEventListener("tap", function() {
				var danyuan = document.getElementById("danyuan_search").value;
				pulldownRefresh(danyuan);
			})
		</script>
	</body>

</html>