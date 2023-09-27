<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플렉서블박스 예제</title>
<!-- TCP School - CSS - 플렉서블박스 -->
<style>
	#box {
		display: flex;
		direction: rtl;
	}
	.item {
		width: 200px;
		height: 100px;
		background-color: salmon;
		border: 2px solid red;
	}
</style>
</head>
<body>
	<div id="box">
		<div class="item">1</div>
		<div class="item">2</div>
		<div class="item">3</div>
	</div>
</body>
</html>