<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="format-detection" content="telephone=no" />
		<title>真好智慧社区</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" href="../../mui/css/mui.min.css">
		<link rel="stylesheet" href="../../css/cardActivity/card.css?rnd=5">
	</head>
	<body>
		<div class="mui-content">
			<div class="topimg">
				<img src="${cardCard.detailsImg}" />
			</div>
			<div class="title">
				<span class="tmain">${cardCard.cardLevel}</span>
				<span class="ttitle">${cardCard.cardTitle}</span>
			</div>
			<div class="para">
				地址：${cardCard.csAddress }
			</div>
			<div class="para">
				电话：${cardCard.csPhone }
			</div>
			<div class="para">
				有效期： 开始时间：<fmt:formatDate pattern="yyyy-M-d HH:mm" value="${cardCard.cardStarttime}"/><br />
				　　　　 结束时间：<fmt:formatDate pattern="yyyy-M-d HH:mm" value="${cardCard.cardEndtime}"/>
			</div>
			<div class="detail">
				${cardCard.cardLimit}
			</div>
			<div class="store">${cardCard.csStoreName}</div>
			<div class="detail pagebottom">
				${cardCard.csInformation}
			</div>
		</div>
		<c:choose>
			<c:when test="${category==1 }">
				<nav class="mui-bar mui-bar-tab">
					<button type="button" class="mui-btn mui-btn-main" data-id="${cardActivityUcode}#${activityCategory}">立即领券</button>
				</nav>
			</c:when>
			<c:when test="${category==2 }">
				<nav class="mui-bar mui-bar-tab">
					<button type="button" class="mui-btn mui-btn-main" data-id="${cardCard.ucode}">扫码消费</button>
				</nav>
			</c:when>
		</c:choose>
		
		<script src="../../mui/js/mui.min.js"></script>
		<script src="../../mui/js/mui.lazyload.js"></script>
		<script src="../../mui/js/mui.lazyload.img.js"></script>
		<script>
			mui(".mui-bar").on('tap', '.mui-btn', function() {
				var id = this.getAttribute("data-id");
				//window.location.href = "articleDetails.do?id=" + id;
				mobileObj.mobileFunction('51',id);
			})
			MyImgLazy(); 
			//图片懒加载
			function MyImgLazy () {
				var img=document.getElementsByTagName('img');
				
				for (var i=0;i<img.length;i++) {
					img[i].setAttribute("data-lazyload",img[i].src);
				}
				mui(document).imageLazyload({
	                placeholder:'../mui/images/gw.gif'
	            });
			} 
		
		</script>
		
	</body>

</html>