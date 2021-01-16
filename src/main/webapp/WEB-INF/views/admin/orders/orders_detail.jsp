<%@page import="com.gumzima.shopping.model.domain.OrderStatus"%>
<%@page import="com.gumzima.shopping.model.domain.OrderDetail"%>
<%@page import="com.gumzima.shopping.model.domain.Orders"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%
	Orders orders =(Orders)request.getAttribute("Orders");
	List<OrderDetail> order_detail_list = orders.getOrder_detail_list();
	List<OrderStatus> orderStatusList = (List)request.getAttribute("OrderStatusList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../inc/header.jsp" %>
<script>
$(function(){
	$("#bt_update").click(function(){
		var formData = $("#detail_form").serialize();//전부 문자열화 시킨다.
		
		$.ajax({
	        url:'/admin/orders/detail/update'
	        , type: 'post'
	        , dataType: 'text'
	        , data:formData
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
<h1>주문상세정보</h1>
<h3>주문한 상품</h3>
<p>
	<table>
		<tr>
			<th>상품코드</th>
			<th>이미지</th>
			<th>상품명</th>
			<th>상품가격</th>
			<th>수량</th>
			<th>금액</th>
		</tr>
		<%for(int i=0; i<order_detail_list.size(); i++){ %>
		<tr>
			<th><%=order_detail_list.get(i).getProduct_id() %></th>
			<th><%=order_detail_list.get(i).getFilename() %></th>
			<th><%=order_detail_list.get(i).getProduct_name() %></th>
			<th><%=order_detail_list.get(i).getProduct_price() %></th>
			<th><%=order_detail_list.get(i).getQuantity() %></th>
			<th><%=order_detail_list.get(i).getProduct_price()%></th>
		</tr>
		<%}%>
	</table>	
</p>
//여기서 표시해야될 것
<h3>주문 정보</h3>
<!-- 주문정보 테이블 -->
<form id="detail_form">
	<p>
		<table>
			<tr>
				<td colspan="1">주문번호
				<input name="orders_id" type="hidden" value="<%=orders.getOrders_id()%>"></input>
				</td>
				<td colspan="2"><%=orders.getOrders_id()%></td>
				<td colspan="1">주문일자</td>
				<td colspan="2"><%=orders.getOrder_date() %></td>
			</tr>
			<tr>
				<td colspan="1">결제방법</td>
				<td colspan="2"><%=orders.getPaymethod_id() %></td>
				<td colspan="1">입금인</td>
				<td colspan="2"><%=orders.getMoney_sender() %></td>
			</tr>
			<tr>
				<td colspan="1">운송장번호</td>
				<td colspan="2"><input name="invoice_number" type="text" value="<%=orders.getInvoice_number()%>"></input></td>
				<td colspan="1">발송일자</td>
				<td colspan="2"><%=orders.getShipment_date() %></td>
			</tr>
			<tr>
				<td colspan="1">처리상태</td>
				<td colspan="2">
					<select name="order_status_id" >
							<%for(int i=0; i<orderStatusList.size(); i++){%>
								<option value="<%=orderStatusList.get(i).getOrder_status_id()%>" 
								<%if(orders.getOrder_status_id()==orderStatusList.get(i).getOrder_status_id()){%>
									selected="selected"
								<%}%>>
								<%=orderStatusList.get(i).getOrder_status_name()%></option>
							<%} %>
					</select>
				</td>
				<td colspan="6"></td>
			</tr>
		</table>	
	</p>
	
	<!-- 회원정보 테이블 -->
	<h3>주문 회원 정보</h3>
	<p>
		<table>
			<tr>
				<td colspan="1">주문자명</td>
				<td colspan="2"><%=orders.getMember().getM_name() %></td>
				<td colspan="1">이메일</td>
				<td colspan="2"><%=orders.getMember().getM_email() %></td>
			</tr>
			<tr>
				<td colspan="1">전화번호</td>
				<td colspan="2"><%=orders.getMember().getM_phone() %></td>
				<td colspan="1"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="1">우편번호</td>
				<td colspan="4"><%=orders.getMember().getM_addr1() %></td>
			</tr>
			<tr>
				<td colspan="1">주소</td>
				<td colspan="4"><%=orders.getMember().getM_addr2() %></td>
			</tr>
			<tr>
				<td colspan="1">상세주소</td>
				<td colspan="4"><%=orders.getMember().getM_addr3() %></td>
			</tr>
		</table>	
	</p>
	
	<!-- 수취인 정보 테이블 -->
	<h3>수취인 정보</h3>
	<p>
		<table>
			<tr>
				<td colspan="1">수취인명</td>
				<td colspan="2"><%=orders.getReceiver_name() %></td>
				<td colspan="1"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="1">전화번호</td>
				<td colspan="2"><%=orders.getReceiver_cellphone()%></td>
				<td colspan="1"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="1">우편번호</td>
				<td colspan="2"><%=orders.getReceiver_postcode() %></td>
				<td colspan="1"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="1">주소</td>
				<td colspan="4"><%=orders.getReceiver_address1()%></td>
			</tr>
			<tr>
				<td colspan="1">상세주소</td>
				<td colspan="4"><%=orders.getReceiver_address2()%></td>
			</tr>
			<tr>
				<td colspan="1">주문요청사항</td>
				<td colspan="4"><%=orders.getReceiver_request()%></td>
			</tr>
			<tr>
				<td colspan="1">주문 취소 사유</td>
				<td colspan="4"><%=orders.getReceiver_cancle_reason()%></td>
			</tr>
		</table>	
	</p>
</form>

<button type="button" id="bt_update">업데이트</button>
<button type="button" id="bt_delete" onclick="location.href='/admin/orders/list'">목록으로</button>

</body>
</html>