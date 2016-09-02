<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>我的钥匙</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link href="../../mui/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="../../mui/css/mui.picker.min.css" />
		<link rel="stylesheet" type="text/css" href="../../css/headOfHouse/ownKey.css" />
	</head>

	<body>
		<div class="mui-content">
			<header class="header">
				<h4>${doorUser.cfgUname }&nbsp;&nbsp;<span class="gary">${doorUser.cbUname }</span></h4>
			</header>
			<div class="manage_key">
				<a id="header_keyApplay">
					<p>申请电子钥匙
						<span class="mui-icon mui-icon-forward"></span>
						<span class="gary">添加我的钥匙</span>
					</p>
				</a>
			</div>
			<div class="content">
				<div class="title">
					<dl>
						<dt><span class="mui-icon mui-icon-person"></span></dt>
						<dd>户主</dd>
					</dl>
					<div>
						<p><span>手机号：${doorUser.userId }</span></p>
						<p><span id="headTime">有效期至：${doorUser.keyExpiry }</span></p>
						<p><span id="authCount">可授权人数：
							<c:choose>
								<c:when test="${empty doorUser.num}">
									0
								</c:when>
								<c:when test="${!empty doorUser.num}">
									${doorUser.num}
								</c:when>
							</c:choose>
						人</span></p>
					</div>
					
				</div>
				<div class="content_list">
					<ul class="mui-table-view">
						<c:forEach var="doorUser2" items="${doorUsers2 }">
							<li class="mui-table-view-cell">
								<table border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td class="phone">手机号：${doorUser2.userId }</td>
											<td rowspan="2">
												<button type="button" data-id="${doorUser2.id }" class="mui-btn fix-btn">修改</button>
												<button type="button" data-id="${doorUser2.id }" class="mui-btn del-btn">删除</button>
											</td>
										</tr>
										<tr>
											<td class="out_time">过期时间：${doorUser2.keyExpiry }</td>
										</tr>
									</tbody>
								</table>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<script src="../../mui/js/mui.min.js"></script>
		<script src="../../mui/js/mui.picker.min.js"></script>
		<script type="text/javascript">
			mui.init();
//			有效期时间格式化
			var span=document.getElementById("headTime"),
				headT=span.innerHTML.slice(5,14),
				yy=headT.slice(0,4),
				mm=headT.slice(4,6),
				dd=headT.slice(6,8);
			span.innerHTML="有效期至："+yy+"-"+mm+"-"+dd;
			var td=document.getElementsByClassName("out_time");
			for(var i=0;i<td.length;i++){
				var outT=td[i].innerHTML.slice(5,14),
					y=outT.slice(0,4),
					m=outT.slice(4,6),
					d=outT.slice(6,8);
				td[i].innerHTML="过期时间："+y+"-"+m+"-"+d;
			}


//			删除操作
			var delbtns = mui(".del-btn");
			delbtns.each(function(i, btn) {
				btn.addEventListener('tap', function() {
					var li = document.getElementsByClassName("mui-table-view-cell")[i];
					var phone=li.getElementsByClassName("phone")[0].innerHTML;
					var id = this.dataset.id;
					var btnArray = ['否', '是'];
					mui.confirm('是否删除'+phone+'用户的钥匙？', '确认提示', btnArray, function(e) {
						if(e.index == 1) {
							mui.ajax('deleteKey.do',{
								data:{
									id:id
								},
								type:'post',//HTTP请求类型
								timeout:10000,//超时时间设置为10秒；
								success:function(data){
									li.parentNode.removeChild(li);
									mui.alert("删除成功！");
								},
								error:function(xhr,type,errorThrown){
									mui.alert("未删除成功，请稍后再试！");
								}
							});
						}
					})
				});
			});
			
//			修改过期时间
			var fixbtns = mui(".fix-btn");
			fixbtns.each(function(i, btn) {
				btn.addEventListener('tap', function() {
					//var optionsJson = this.getAttribute('data-options') || '{}';
					//var options = JSON.parse(optionsJson);
					var id = this.dataset.id;
					/*
					 * 首次显示时实例化组件
					 * 示例为了简洁，将 options 放在了按钮的 dom 上
					 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
					 */
					var picker = new mui.DtPicker({
						type:"date",
						beginDate:new Date(),
						endDate:new Date(yy,mm-1,dd)
					});
					picker.show(function(rs) {
						/*
						 * rs.value 拼合后的 value
						 * rs.text 拼合后的 text
						 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
						 * rs.m 月，用法同年
						 * rs.d 日，用法同年
						 * rs.h 时，用法同年
						 * rs.i 分（minutes 的第二个字母），用法同年
						 */
						/* 
						 * 返回 false 可以阻止选择框的关闭
						 * return false;
						 */
						/*
						 * 释放组件资源，释放后将将不能再操作组件
						 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
						 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
						 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
						 */
						picker.dispose();
						mui.ajax('editTime.do',{
							data:{
								id:id,
								keyExpiry:rs.text.replace(/-/g,"")
							},
							type:'post',//HTTP请求类型
							timeout:10000,//超时时间设置为10秒；
							success:function(data){
								var outTime = document.getElementsByClassName("out_time");
								outTime[i].innerText = '过期时间：' + rs.text;
								mui.alert("修改成功！");
							},
							error:function(xhr,type,errorThrown){
								mui.alert("未能修改成功，请稍后再试！");
							}
						});
					});
				}, false);
			});
			
// 			var authC=document.getElementById("authCount").innerHTML.slice(6,8);
			var authC='${doorUser.num}'||0;
			var liL=document.getElementsByClassName("mui-table-view-cell").length;
			
//			添加我的钥匙
			document.getElementById("header_keyApplay").addEventListener("tap",function(){
				if(liL>=authC){
					mui.alert("对不起，您授权的人数已达到上限！");
				}else{
					location.href="addKey.do?keyExpiry=${doorUser.keyExpiry }&comCode=${doorUser.cfgUcode}&buildCode=${doorUser.cbUcode}";
				}
			});
			
			
		</script>
	</body>

</html>