<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<style>
body {
  margin: 0;
  padding: 0;
  background-color: #90d5db;
  height: 100vh;
}
</style>
</head>

<body>

	<div class="container">	
	<div class="container">
		<h2>임시 비밀번호를 발송해 드렸습니다. 비밀번호를 변경하여 사용하세요.</h2>
			<%=request.getAttribute("msg") %>
		</div>
	</div>
</body>
</html>