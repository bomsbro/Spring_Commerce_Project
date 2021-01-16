<%@page import="com.gumzima.shopping.model.domain.Notice"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	//정말로 포워딩이 요청을 유지햇는지 테스트해보자!!
	Notice notice =(Notice)request.getAttribute("notice"); 
	out.print("요청객체에 담겨진 notice는 "+ notice); 
		
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
$(function(){
	CKEDITOR.replace("content"); //textarea의 id가 content인 컴포넌트를 편집기 스킨으로 변경
	
	$($("input[type='button']")[0]).click(function(){// 글 수정
		edit();	// 동기방식으로 요청하겠다
	});
	$($("input[type='button']")[1]).click(function(){// 글 삭제
		del();	
	});	
});
//글등록 요청
function edit(){
	if(confirm("수정하시겠습니까?")){
		$("form").attr({
			action:"/admin/notice/edit", 
			method:"post"
		});		
		$("form").submit();		
	}
}

function del(){
	if(confirm("삭제하시겠습니까?")){
		$("form").attr({
			action:"/admin/notice/delete", 
			method:"post"
		});		
		$("form").submit();
	}
}

</script>
</head>
<body>

<div class="container">
  <form>
    <input type="hidden" name="notice_id" value="<%=notice.getNotice_id()%>"> 
    <input type="text" name="title" value="<%=notice.getTitle()%>">
    <input type="text" name="writer" value="<%=notice.getWriter()%>">
    <textarea id="content" name="content" style="height:200px"><%=notice.getContent() %></textarea>
    
    <input type="button" value="글수정">
    <input type="button" value="글삭제">
    <input type="button" value="목록보기" onClick="location.href='/admin/notice/list'"> 
  </form>
</div>

</body>
</html>
