<%@page import="com.gumzima.shopping.model.domain.Customer"%>
<%@page import="com.gumzima.shopping.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<Customer> customerList = (List)request.getAttribute("customerList");
	
	Pager pager = new Pager();
	pager.init(request, customerList); 
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
<%@ include file="../inc/header.jsp"%>
</head>
<body>
<%@ include file="../inc/main_navi.jsp"%>
<div class="container">
  <h4>1:1 문의목록</h4>     
  <table class="table">
    <thead>      	
      <tr>
        <th>No</th>
        <th>제목</th>
        <th>이메일</th>        
        <th>등록일</th>        
        <th>처리상태</th>        
      </tr>
    </thead>
    <tbody>
      <tr>
      <%for(int i=0;i<customerList.size();i++){ %>
      <%Customer customer = customerList.get(i); %>
      <%String c_ok=null; %>
      <%if(customer.getC_ok()==0 ){c_ok="미처리"; %>      
      <%}else{c_ok="처리완료";} %>      
       <tr>
        <th><%=customer.getCustomer_id()%></th>
        <th><a href = "/admin/customer/customerdetail?customer_id=<%=customer.getCustomer_id()%>"><%=customer.getTitle() %></a></th>
        <th><%=customer.getWriter() %>@<%=customer.getWriter_server() %></th>      
        <th><%=customer.getRegdate()%></th>                
        <th><%=c_ok %></th>
        
      </tr>
      <%} %>		
      
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>
