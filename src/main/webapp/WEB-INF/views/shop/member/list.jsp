<%@page import="com.gumzima.shopping.model.domain.Member"%>
<%@page import="com.gumzima.shopping.model.common.Pager"%>
<%@page import="java.util.List"%>

<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<Member> memberList = (List)request.getAttribute("memberList");
	
	Pager pager = new Pager();
	pager.init(request, memberList); 
%>
<!DOCTYPE html>
<html >
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>

</script>
</head>
<body>

<div class="container">
  <h4>회원목록</h4>     
  <table class="table">
    <thead>      	
      <tr>
        <th>No</th>
        <th>ID</th>
        <th>이름</th>
        <th>이메일</th>
        <th>연락처</th>
        <th>우편번호</th>        
        <th>기본주소</th>        
        <th>상세주소</th>        
      </tr>
    </thead>
    <tbody>
      <tr>
      <%for(int i=0;i<memberList.size();i++){ %>
      <%Member member = memberList.get(i); %>      
       <tr>
        <th><%=member.getMember_id()%></th>
        <th><a href = "/shop/member/detail?member_id=<%=member.getMember_id()%>"><%=member.getM_id()%></a></th>
        <th><%=member.getM_name() %></th>
        <th><%=member.getM_email() %><%="@" %><%=member.getM_email_server() %></th>
        <th><%=member.getM_phone() %></th>
        <th><%=member.getM_addr1() %></th>
        <th><%=member.getM_addr2() %></th>
        <th><%=member.getM_addr3() %></th>
      </tr>
      <%} %>		
      
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>
