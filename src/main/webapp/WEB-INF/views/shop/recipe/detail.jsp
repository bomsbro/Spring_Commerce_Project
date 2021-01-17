<%@page import="com.gumzima.shopping.model.domain.Recipe"%>
<%@page import="com.gumzima.shopping.model.domain.R_category"%>
<%@page import="com.gumzima.shopping.model.common.Formatter"%>
<%@page import="com.gumzima.shopping.model.domain.Image"%>
<%@page import="java.util.List"%>
<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Recipe recipe=(Recipe)request.getAttribute("recipe");
	List<Product> productList=(List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <%@ include file="../inc/header.jsp" %>
    <%@ include file="../inc/detailCSS.jsp" %>
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
    <section id="detailRecipe" class="ftco-section ftco-degree-bg">
    	<div class="container">
    		<div class="row">
    			<table class="table">
				<thead class="thead-primary">
				<tr class="text-center">
				<td style="background:blue"><a style="color:white" href="#detailRecipe">상세정보</a></td>
				<td><a style="color:white" href="#relevantProduct">관련 상품</a></td>
				</tr>
				</thead>
				</table>
    			<div class="col-lg-8 ftco-animate" style="margin:auto; word-break:break-all">
    				<h1 class="mb-3"><%=recipe.getTitle() %></h1>
    		        <p align="center"><img src="/resources/data/food/<%=recipe.getRecipe_id()%>.<%=recipe.getFilename() %>" alt="" class="img-fluid"></p>
                    <p style=""><h4><%=recipe.getContent()%></h4></p>
            	</div>
    		</div>
    	</div>
    </section>

		<section id="relevantProduct" class="ftco-section">
    	<div class="container">
    	<table class="table">
		<thead class="thead-primary">
		<tr class="text-center">
		<td><a style="color:white" href="#detailRecipe">상세정보</a></td>
		<td style="background:blue"><a style="color:white" href="#relevantProduct">관련 상품</a></td>
		</tr>
		</thead>
		</table>
		<div class="row justify-content-center mb-3 pb-3">
          <div class="col-md-12 heading-section text-center ftco-animate">
            <h2 class="mb-4">관련 상품</h2>
          </div>
        </div>   		
    	</div>
    	<div class="container">
    		<div class="row">
    			<%for(int i=0;i<productList.size();i++){ %>
    			<%Product product=productList.get(i);%>
    			<div class="col-md-6 col-lg-3 ftco-animate">
    				<div class="product">
    					<%if(product.getStock()==0){ %>
    					<a>
    					<%}else{ %>
    					<a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>" class="img-prod">
    					<%} %>
    					<img width="100%" height="100%" class="img-fluid" src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" alt="Colorlib Template">
    						<div class="overlay"></div>
    					</a>
    					<div class="text py-3 pb-4 px-3 text-center">
    						<%if(product.getStock()==0){ %>
	    					<h2 style="color:red"><%=product.getProduct_name() %></h2>
    						<%}else{ %>
	    						<a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>"><h2><%=product.getProduct_name() %></h2></a>
    						<%} %>
    						<div class="d-flex">
    							<div class="pricing">
    							<%if(product.getStock()==0){ %>
		    						<p class="price"><span style="color:red" class="price-sale" ><%=Formatter.getCurrency(product.getPrice()) %></span></p>
		    					<%}else{ %>
		    						<p class="price"><span class="price-sale" ><%=Formatter.getCurrency(product.getPrice()) %></span></p>
		    					<%} %>
		    					</div>
	    					</div>
	    					<div class="bottom-area d-flex px-3">
	    						<div class="m-auto d-flex">
	    							<%if(product.getStock()==0){ %>
	    							<a class="add-to-cart d-flex justify-content-center align-items-center text-center">
	    							<%}else{ %>
	    							<a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>" class="add-to-cart d-flex justify-content-center align-items-center text-center">
	    							<%} %>
	    								<span><i class="ion-ios-menu"></i></span>
	    							</a>
	    							<%if(product.getStock()==0){ %>
	    							<a class="buy-now d-flex justify-content-center align-items-center mx-1">
	    							<%}else{ %>
	    							<a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>" class="buy-now d-flex justify-content-center align-items-center mx-1">
	    							<%} %>
	    								<span><i class="ion-ios-cart"></i></span>
	    							</a>
	    							<a class="heart d-flex justify-content-center align-items-center ">
	    								<%if(product.getStock()==0){ %>
	    								<span style="color:red"><%=product.getStock() %></span>
	    								<%}else{ %>
	    								<span><%=product.getStock() %></span>
	    								<%} %>
	    							</a>
    							</div>
    						</div>
    					</div>
    				</div>
    			</div>
    			<%} %>
    		</div>
    	</div>
    </section>

		<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
      <div class="container py-4">
        <div class="row d-flex justify-content-center py-5">
          <div class="col-md-6">
          	<h2 style="font-size: 22px;" class="mb-0">Subcribe to our Newsletter</h2>
          	<span>Get e-mail updates about our latest shops and special offers</span>
          </div>
          <div class="col-md-6 d-flex align-items-center">
            <form action="#" class="subscribe-form">
              <div class="form-group d-flex">
                <input type="text" class="form-control" placeholder="Enter email address">
                <input type="submit" value="Subscribe" class="submit px-3">
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
    <%@ include file="../inc/footer.jsp" %>
  </body>
</html>