<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="format-detection" content="telephone=no" />
		<title>小区选择列表</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="../../../ui/css/mui.min.css?rnd=0">
		<link rel="stylesheet" href="../../../css/headOfHouse/keyApply.css?rnd=0" />
		
	</head>

	<body>
		
	<div class="mui-content">
		  
		<!--下拉刷新容器-->
		<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
			<div class="mui-scroll">
				<!--搜索框-->
				<div class="mui-input-row mui-search xiaoqu_search">
					<input type="search" class="mui-input-clear" placeholder="请输入小区名称..." id="xiaoqu_search">
				</div>
				<div class="search_btn">
					<input type="button" id="btn_search" class="mui-btn mui-btn-primary mui-btn-outlined" value="搜索" />
				</div>
				<!--数据列表-->
				<ul class="mui-table-view mui-table-view-chevron">
					<c:forEach items="${cfgs }" var="cfg">
						<li class="mui-table-view-cell">
							<a href="" class="mui-navigate-right"  id="${cfg.cfgUcode}" >
								${cfg.cfgUname }
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
		<script src="../mui/js/mui.min.js"></script>
		<script>
<%--			var ismore = true; //还有更多
//			var pagenow = 0;
//			var pagesize = 10;
//
//			mui.init({
//				pullRefresh: {
//					container: '#pullrefresh',
//					down: {
//						callback: pulldownRefresh
//					},
//					up: {
//						contentrefresh: '正在加载...',
//						callback: pullupRefresh
//					}
//				}
//			});--%>
			/**
			 * 下拉刷新具体业务实现
			 */
			function pulldownRefresh(xiaoqu) {
				//ismore = true;
				mui.ajax('jsonGetCfg.do', {
					data: {
						comName:xiaoqu
					},
					dataType: 'json', //服务器返回json格式数据
					type: 'post', //HTTP请求类型
					timeout: 20000, //超时时间设置为20秒；
					success: function(data) {
						console.log(data);
						//pagenow = 0;
						var table = document.body.querySelector('.mui-table-view');
						table.innerHTML = '';
						for (var i = 0; i < data.cfgs.length; i++) {
							html = '<a href="" class="mui-navigate-right" id='+data.cfgs[i].cfgUcode+'>';
							html += data.cfgs[i].cfgUname;
							html += '</a>';
							var li = document.createElement('li');
							li.className = 'mui-table-view-cell';
							li.innerHTML = html;
							//下拉刷新，新纪录插到最前面；
							table.appendChild(li);
						}
						//mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
					},
					error: function(xhr, type, errorThrown) {
						//mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
						console.log(type);
					}
				});
			}

<%--			/**
			 * 上拉加载具体业务实现
			 */
//			function pullupRefresh() {
//				if (!ismore) {
//					mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
//					return;
//				}
//				mui.ajax('/ZHCS/comGuide/selectglist.do', {
//					data: {
//						recordStart: pagenow * pagesize,
//						pageSize: pagesize
//					},
//					dataType: 'json', //服务器返回json格式数据
//					type: 'post', //HTTP请求类型
//					timeout: 20000, //超时时间设置为20秒；
//					success: function(data) {
//						pagenow++;
//						//如果上拉加载新页加载到底了，上拉刷新就会不能加载第二页因此先屏蔽
//						//mui('#pullrefresh').pullRefresh().endPullupToRefresh(data.length < pagesize); //参数为true代表没有更多数据了。
//						if (data.length == 0) {
//							ismore = false;
//							mui.alert('没有更多的数据了。', '提示', function() {});
//						}
//						mui('#pullrefresh').pullRefresh().endPullupToRefresh(false); //参数为true代表没有更多数据了。
//						var table = document.body.querySelector('.mui-table-view');
//						for (var i = 0; i < data.length; i++) {
//							html = '<a href="#" class="mui-navigate-right">';
//							html += data[i].xiaoqu();
//							html += '</a>';
//							var li = document.createElement('li');
//							li.className = 'mui-table-view-cell';
//							li.innerHTML = html;
//							table.appendChild(li);
//						}
//					},
//					error: function(xhr, type, errorThrown) {
//						console.log(type);
//					}
//				});
//			}
//			if (mui.os.plus) {
//				mui.plusReady(function() {
//					setTimeout(function() {
//						mui('#pullrefresh').pullRefresh().pullupLoading();
//					}, 1000);
//
//				});
//			} else {
//				mui.ready(function() {
//					mui('#pullrefresh').pullRefresh().pullupLoading();
//				});
//			}--%>
//			小区选择
			mui(".mui-table-view").on('tap', '.mui-table-view-cell', function(event) {
				var target=event.srcElement||event.target;
				var xId=target.id;
				var xiaoqu=target.innerHTML!=undefined?target.innerHTML:"";
				xiaoqu=encodeURI(xiaoqu);
				document.cookie="xiaoqu="+xiaoqu;
				location.href="getBuilding.do?comCode="+xId;
			})
			//小区查询
			document.getElementById("btn_search").addEventListener("tap", function() {
				var xiaoqu = document.getElementById("xiaoqu_search").value;
				pulldownRefresh(xiaoqu);
			})			
		</script>
	</body>

</html>