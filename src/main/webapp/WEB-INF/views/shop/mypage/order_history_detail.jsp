
<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@page import="com.gumzima.shopping.model.domain.OrderStatus"%>
<%@page import="com.gumzima.shopping.model.domain.OrderDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.gumzima.shopping.model.domain.Orders"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
Orders orders =(Orders)request.getAttribute("Orders");
	List<OrderDetail> order_detail_list = orders.getOrder_detail_list();
	List<OrderStatus> orderStatusList = (List)request.getAttribute("OrderStatusList");
%>
<!DOCTYPE html>
<html>
<head>
	<title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   
	<!-- include haeader -->
 	<%@ include file="../inc/header.jsp" %>
 	
 	<style>
 	/*for product list*/
 	body {
    margin: 0;
    font-family: Roboto, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
    font-size: .8125rem;
    font-weight: 400;
    line-height: 1.5385;
    color: #333;
    text-align: left;
    background-color: #f5f5f5
	}
	
	.mt-50 {
	    margin-top: 50px
	}
	
	.mb-50 {
	    margin-bottom: 50px
	}
	
	.bg-teal-400 {
	    background-color: #26a69a
	}
	
	a {
	    text-decoration: none !important
	}
	
	.fa {
	    color: red
	}
 	</style>
 	<script>
 	var myModal = document.getElementById('myModal')
 	var myInput = document.getElementById('myInput')

 	myModal.addEventListener('shown.bs.modal', function () {
 	  myInput.focus();
 	})
 	</script>
</head>
<body>
	
	<%@ include file="../inc/top.jsp"%>
	<!-- For Product List -->
	<div class="container d-flex justify-content-center mt-50 mb-50">
    <div class="row">
    		<div class="col-md-10">
    		<h1>주문 상세</h1>
    		<hr >
					<!-- 주문정보 테이블 -->
					<form id="detail_form">
						<p>
							<table>
								<thead>
									<h3>수취인 정보</h3>
								</thead>
								<tbody>
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
										<td colspan="2"><%=orders.getInvoice_number()%></td>
										<td colspan="1">발송일자</td>
										<td colspan="2"><%=orders.getShipment_date() %></td>
									</tr>
									<tr>
										<td colspan="1">처리상태:</td>
										<td colspan="2">										
											<%for(OrderStatus orderStatus :orderStatusList){%>
												<%if(orderStatus.getOrder_status_id()==orders.getOrder_status_id()){%>
													<%=orderStatus.getOrder_status_name() %>
												<%}%>
											<%}%>
										</td>
										<td colspan="6"></td>
									</tr>
								</tbody>
							</table>	
						</p>
				
				  	<!-- 수취인 정보 테이블 -->
				  <hr>
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
    		</div>
        <div class="col-md-10">
        	<%for(int i=0; i<order_detail_list.size(); i++){ %>
            <div class="card card-body mt-3">
                <div class="media align-items-center align-items-lg-start text-center text-lg-left flex-column flex-lg-row">
                    <div class="mr-2 mb-3 mb-lg-0"> <img src="/resources/data/basic/<%=order_detail_list.get(i).getProduct_id()%>.<%=order_detail_list.get(i).getFilename()%>" width="150" height="150" alt=""> </div>
                    <div class="media-body">
                        <h6 class="media-title font-weight-semibold"> <a href="/shop/product/detail?product_id= <%=order_detail_list.get(i).getProduct_id()%> " data-abc="true"><h3 style="color:green;"><%=order_detail_list.get(i).getProduct_name() %></h3></a> </h6>
                      	<br>
                        <ul class="list-inline list-inline-dotted mb-0">
                            <li class="list-inline-item"><h5>수량: <%=order_detail_list.get(i).getQuantity() %></h5></li>
                        </ul>
                    </div>
                    <div class="mt-3 mt-lg-0 ml-lg-3 text-center">
                        <h3 class="mb-0 font-weight-semibold"><%=Formatter.getCurrency(order_detail_list.get(i).getProduct_price())%></h3>
                        <div> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>
                        <!--리뷰쓰기 모달 버튼-->
                        <!-- Trigger the modal with a button -->
						<button type="button" class="btn btn-warning mt-4 text-white" data-toggle="modal" data-target="#myModal">리뷰 쓰기</button>
						
						<!-- Modal -->
						<div id="myModal" class="modal fade" role="dialog">
						  <div class="modal-dialog">
						
						    <!-- Modal content-->
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						        <h4 class="modal-title">Modal Header</h4>
						      </div>
						      <div class="modal-body">
						        <p>Some text in the modal.</p>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						      </div>
						    </div>
						
						  </div>
						</div>
						<!-- 모달 끝 -->
                    </div>
                </div>
            </div>
					<%}%>
        </div>
    </div>
	</div>  
  
	<!-- footer -->
	<%@ include file="../inc/footer.jsp" %>
    
</body>
</html>
</body>
</html>