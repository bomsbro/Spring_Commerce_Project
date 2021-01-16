<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

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

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
	$(function () {
		CKEDITOR.replace("content");
		
		$($("input[type='button']")[0]).click(function(){
			regist();
		});
	});
	
	// 글등록 요청
	function regist(){
		$("form").attr({
			action:"/admin/notice/regist",
			method:"post"
		});
		$("form").submit();
	}
</script>
</head>
<head>
</head>
<body>

<div class="container">
  <form>    
    <input type="text" name="title" placeholder="Your name..">
    <input type="text" name="writer" placeholder="Your last name..">
    <textarea name="content" placeholder="Write something.." style="height:200px"></textarea>    	
    <input type="button" value="글등록">
    <input type="button" value="목록보기" onclick="location.href='/admin/notice/list'">
  </form>
</div>

</body>
</html>
