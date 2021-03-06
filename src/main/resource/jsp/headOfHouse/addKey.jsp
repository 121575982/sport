<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>户主添加钥匙</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link href="../../mui/css/mui.min.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="../../mui/css/mui.picker.min.css" />
		<link rel="stylesheet" href="../../css/headOfHouse/addKey.css" />
	</head>

	<body>
		<nav class="mui-bar mui-bar-tab footer">
			<div id="submint_btn" class="submint_btn">
				<p>提交</p>
			</div>
		</nav>
		<div class="mui-content">

			<div class="useInfo">
				<div class="mui-input-row">
					<label>住户姓名：</label>
					<input type="text" id="username" placeholder="请输入住户真实姓名">
				</div>
				<div class="mui-input-row">
					<label>住户手机：</label>
					<input type="text" id="userphone" placeholder="请输入住户手机号">
				</div>
				<div class="out_time">
					<table border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="timer">有效期至：</td>
								<td id="headTime" style="display: none;">${keyExpiry }</td>
								<td>
									<button type="button" class="mui-btn fix-btn">选择</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<script src="../../mui/js/mui.min.js"></script>
		<script src="../../mui/js/mui.picker.min.js"></script>
		<script type="text/javascript">
			mui.init();
			//			有效期时间格式化
			
			var td=document.getElementById("headTime"),
				headT=td.innerHTML,
				yy=headT.slice(0,4),
				mm=headT.slice(4,6),
				dd=headT.slice(6,8);
			var time="${keyExpiry}";
			//选择有效时间:
			var btn = mui(".fix-btn");
			btn[0].addEventListener('tap', function() {
					var optionsJson = this.getAttribute('data-options') || '{}';
					var options = JSON.parse(optionsJson);
					var id = this.getAttribute('id');
					
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
						var outTime = document.getElementsByClassName("timer")[0];
						outTime.innerHTML = '有效期至：' + rs.text;
						time=rs.text.replace(/-/g,"");
						picker.dispose();
					});
			}, false);
			
			
			
			//提交
			document.getElementById("submint_btn").addEventListener("tap", function() {
				var username = document.getElementById("username").value;
				var userphone = document.getElementById("userphone").value;
				var timer=document.getElementsByClassName("timer")[0].innerHTML.slice(5);
				if(!username) {
					mui.alert("请输入业主姓名！");
				} else if(!userphone) {
					mui.alert("请输入业主手机号码！");
				} else if(!timer){
					mui.alert("请选择有效期！");
				} else{
					mui.ajax('submitDoorInfo.do', {
						data: {
							phone: userphone,
							realname: username,
							community:'${comCode}',
							building:'${buildCode}',
							applytype:1,
							time:time,
							flag:1
							
						},
						dataType: 'json', //服务器返回json格式数据
						type: 'post', //HTTP请求类型
						timeout: 10000, //超时时间设置为10秒；
						success: function(data) {
							mui.alert(data.rr.msg);
						},
						error: function(xhr, type, errorThrown) {
							mui.alert("对不起，未提交成功！");
						}
					});
				}

			});
		</script>
	</body>

</html>