<%@page import="com.gumzima.shopping.model.domain.OrderStatus"%>
<%@page import="com.gumzima.shopping.model.domain.Orders"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%
List<Orders> ordersList =(List)request.getAttribute("OrdersList");
	List<OrderStatus> orderStatusList = (List)request.getAttribute("OrderStatusList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../inc/header.jsp" %>

<script>
var checkArr;
var selBoxArr;

$(function(){
	$("button[name=bt_detail]").click(function(){
		var str="/admin/orders/detail/?orders_id=" + $(this).attr('value');
		location.href=str; //글쓰기 폼 요청
	});
	
	$("#bt_update").click(function(){
			checkArr = [];
			selBoxArr =[];
			
		 $("input[name=ck_orders_id]").each(function(i) {
			 
			 if(this.checked){
				selBoxArr.push($("select[name='sel_status']").eq(i).val());
				checkArr.push($(this).val());    // 체크된 것만 값을 뽑아서 배열에 push
			 }
		 });
		 
		 console.log(checkArr);
		 console.log(selBoxArr);
		 
		 $.ajax({
		        url: '/admin/orders/list/update'
		        , type: 'post'
		        , dataType: 'text'
		        , data: {
		            chkArr: checkArr,
		            selArr: selBoxArr
		        }
		 				,success:function(responseData){
		 					var json = JSON.parse(responseData); //string --> json 으로 파싱..
		 					if(json.result==1){
		 						alert(json.msg);
		 						location.href="/admin/orders/list";
		 					}else{
		 						alert(json.msg);
		 					}
		 				}
		  });
		 
	});
	
	$("#bt_delete").click(function(){
		checkArr = [];
		
		$("input[name=ck_orders_id]").each(function(i) {
		 	if(this.checked){
				checkArr.push($(this).val());    // 체크된 것만 값을 뽑아서 배열에 push
		 	}
	 	});
	 
	 $.ajax({
	        url: '/admin/orders/list/delete'
	        , type: 'post'
	        , dataType: 'text'
	        , data: {
	            chkArr: checkArr
	        }
	 				,success:function(responseData){
	 					var json = JSON.parse(responseData); //string --> json 으로 파싱..
	 					if(json.result==1){
	 						alert(json.msg);
	 						location.href="/admin/orders/list";
	 					}else{
	 						alert(json.msg);
	 					}
	 				}
	  });	 
	});
	
});

</script>
</head>
<body>

<%@ include file="../inc/main_navi.jsp" %>
<h3>주문관리</h3>
<form>
	<p>
		<table>
			<tr>
				<td>선택</td>
				<th>주문번호</th>
				<th>주문일자</th>
				<th>주문자명</th>
				<th>수취인명</th>
				<th>결제방법</th>
				<th>총금액</th>
				<th>상태</th>
				<th>상세보기</th>
			</tr>
			<%for(Orders orders:ordersList){%>
			<tr>
				<td><input type="checkbox" name="ck_orders_id" value="<%=orders.getOrders_id() %>"></td>
				<td><%=orders.getOrders_id() %></td>
				<td><%=orders.getOrder_date() %></td>
				<td><%=orders.getMember().getM_name()%></td>
				<td><%=orders.getReceiver_name() %></td>
				<td><%=orders.getPaymethod().getPaymethod_name()%></td>
				<td><%=orders.getTotal_price()%></td>
				<td>
					<select name="sel_status" >
						<%for(int i=0; i<orderStatusList.size(); i++){%>
							<option value="<%=orderStatusList.get(i).getOrder_status_id()%>" 
							<%if(orders.getOrder_status_id()==orderStatusList.get(i).getOrder_status_id()){%>
								selected="selected"
							<%}%>>
							<%=orderStatusList.get(i).getOrder_status_name()%></option>
						<%} %>
					</select>
				</td>
				<td><button type="button" name="bt_detail" value="<%=orders.getOrders_id() %>" onclick="location.href='/shop/mypage/orderhistory/detail?orders_id=<%=orders.getOrders_id()%>';">상세보기</button></td>
			</tr>
			<%}%>
		</table>	
	</p>
</form>

<button type="button" id="bt_update">선택 일괄수정</button>
<button type="button" id="bt_delete">선택 삭제</button>
</body>
</html>