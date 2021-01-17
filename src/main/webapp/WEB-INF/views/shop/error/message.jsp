<%@page import="com.gumzima.shopping.model.common.MessageData"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	MessageData messageData= (MessageData)request.getAttribute("messageData");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
	alert("<%=messageData.getMsg()%>");
	<%if(messageData.getResultCode()==1){%>
		location.href="<%=messageData.getUrl()%>";
	<%}else{%>
		history.back();
	<%}%>
</script>
</head>
<body>
</body>
</html>