<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
	background-color: yellow;
}

input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=button] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=botton]:hover {
	background-color: #45a049;
}
.container1 {
	width: 50%;
	height:100%;
	border-radius: 5px;
	background-color: white;
	padding: 20px;
	float: left;
}
.container2 {
	width: 50%;
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	float: left;
}
</style>
<%@ include file="../inc/header.jsp"%>
<script>
	$(function() {
		
	});
	function regist() {
		var i=$($("select")[0]).val();
		if(i==1){
			topCategoryRegist();
		}else{
			subCategoryRegist();
		}
	}
	function topCategoryRegist(){
		$("form").attr({
			action : "/admin/product/topcategory_regist",
			method : "get",
		});
		$("form").submit();
	}
	function subCategoryRegist(){
		$("form").attr({
			action : "/admin/product/subcategory_regist",
			method : "get",
		});
		$("form").submit();
	}
</script>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<div class="container1">
	<table></table>
	</div>
	<div class="container2">
		<form>
			<h3>카테고리 등록</h3>
			<select>
				<option>카테고리 구분</option>
				<option value="1">상위</option>
				<option value="2">하위</option>
			</select> <input type="text" name="name" placeholder="카테고리 명">

			<input type="button" value="등록" onClick="regist()">
			<input type="button" value="수정" onClick="">
			<input type="button" value="삭제" onClick="">
		</form>
	</div>

</body>
</html>
