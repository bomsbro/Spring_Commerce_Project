<%@page import="com.gumzima.shopping.model.domain.R_category"%>
<%@page import="com.gumzima.shopping.common.Pager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@page import="com.gumzima.shopping.model.domain.P_topcategory"%>
<%@page import="java.util.List"%>
<%
	List<R_category> categoryList=(List)request.getAttribute("categoryList");
	List<Product> productList=(List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <%@ include file="../inc/header.jsp" %>
  </head>
<style>
	img{
		width:100%;
		height:100%;
	}
</style>
  <%@include file="../inc/shop_recipe_list_function.jsp" %>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
    <section class="ftco-section">
    	<div class="container">
			<h1><b><i>레시피 목록</i></b></h1>
    		<div class="row justify-content-center">
    			<div class="col-md-10 mb-5 text-center">
    			<div class="col-lg-4 sidebar ftco-animate">
					<div class="sidebar-box">
						<form action="#" class="search-form">
							<div class="form-group">
								<span id="searchIcon" class="icon ion-ios-search"></span>
								<input type="text" id="searchText" class="form-control" placeholder="Search...">
							</div>
						</form>
					</div>
				</div>
   				<ul class="product-category">
   					<li class="topcategory" value="0" ><a href="#" class="top">All</a></li>
   					<%for(R_category r_category : categoryList){ %>
   					<li class="topcategory" value="<%=r_category.getR_category_id() %>"><a href="#" class="top"><%=r_category.getName() %></a></li>
   					<%} %>
   				</ul>
   				<ul class="product-category">
   				
   					<li class="subcategory" value="0" ><a href="#" class="sub">All</a></li>
   					<%for(Product product : productList){ %>
   					<li class="subcategory" value="<%=product.getProduct_id() %>"><a href="#" class="sub"><%=product.getProduct_name() %></a></li>
   					<%} %>
   				</ul>
    		</div>
    			<div class="select-wrap">
	                  <select name="sort" id="sort" class="form-control">
	                  	<option value="0">최신순</option>
	                    <option value="1">짧은 조리시간순</option>
	                    <option value="2">긴 조리시간순</option>
	                    <option value="3">조회수순</option>
	                  </select>
	                </div>
    			</div>
    		
    		<div class="row" id="productBox">
    		</div>    		
    		
    	<div id="page" class="row mt-5">
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
            <form class="subscribe-form">
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