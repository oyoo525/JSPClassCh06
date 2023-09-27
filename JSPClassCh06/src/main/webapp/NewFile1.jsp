<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미디어쿼리 예제</title>
<!-- TCP School - CSS - 미디어쿼리 -->
<!-- 미디어쿼리는 반응형에서 사용함 -->
<style>
	.content {
		height: 300px;
		background-color: pink;
	}
	@media screen and (min-width : 768px) {
		.content {
			background-color: purple;
		}
	}
	@media screen and (min-width : 1024px) {
		.content {
			background-color: yellow;
		}
	}
	@media screen and (min-width : 1280px) {
		.content {
			background-color: skyblue;
		}
	}
</style>
</head>
<body>
	<div id="box" class="content">content</div>

</body>
</html>