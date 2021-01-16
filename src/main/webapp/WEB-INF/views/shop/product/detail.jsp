<%@page import="com.gumzima.shopping.model.domain.Recipe"%>
<%@page import="com.gumzima.shopping.common.Formatter"%>
<%@page import="com.gumzima.shopping.model.domain.Image"%>
<%@page import="java.util.List"%>
<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	Product product=(Product)request.getAttribute("product");
	List<Image> imgList=product.getImageList();
	List<Recipe> recipeList=(List)request.getAttribute("recipeList");
	System.out.print(recipeList.size());
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <%@ include file="../inc/header.jsp" %>
    <%@ include file="../inc/detailCSS.jsp" %>
  <script>
$(document).ready(function(){
	var quantitiy=0;
   $('.quantity-right-plus').click(function(e){
        
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt($('#quantity').val());
        
        // If is not undefined
            
            $('#quantity').val(quantity + 1);

          
            // Increment
        
    });

     $('.quantity-left-minus').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt($('#quantity').val());
        
        // If is not undefined
      
            // Increment
            if(quantity>0){
            $('#quantity').val(quantity - 1);
            }
    });
     
	$("#quantity").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		return false;
	});
});
	function addCart() {
		$.ajax({
			url:"/shop/cart/regist",
			type:"post",
			data:{
				product_id : <%=product.getProduct_id()%>,
				quantity : $("#quantity").val()
			},
			success : function(messageData) {
				alert(messageData.msg);
				location.href=messageData.url;
			}
		});
	} 
	</script>
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
    <section id="detailProduct" class="ftco-section">
    	<div class="container">
    		<div class="row">
						<table class="table">
						<thead class="thead-primary">
						<tr class="text-center">
						<td width="33%" style="background:blue"><a style="color:white" href="#detailProduct">상세정보</a></td>
						<td width="33%"><a style="color:white" href="#detailRecipe">리뷰보기</a></td>
						<td width="33%"><a style="color:white" href="#relevantRecipe">관련 레시피</a></td>
						</tr>
						</thead>
						</table>
    			<div class="preview col-md-6">
						<div class="preview-pic tab-content">
						  <div class="tab-pane active" id="pic-0"><img src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>"/></div>
						  <%for(int i=0;i<imgList.size();i++){ %>
						  <%Image image=imgList.get(i); %>
						  <div class="tab-pane" id="pic-<%=image.getImage_id()%>"><img src="/resources/data/addon/<%=image.getImage_id()%>.<%=image.getFilename()%>" /></div>
						  
						  <%} %>
						</div>
						<ul class="preview-thumbnail nav nav-tabs">
						  <li class="active"><a data-target="#pic-0" data-toggle="tab"><img src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" /></a></li>
						  <%for(int a=0;a<imgList.size();a++){ %>
						  <%Image image=imgList.get(a); %>
						  <li><a data-target="#pic-<%=image.getImage_id()%>" data-toggle="tab"><img src="/resources/data/addon/<%=image.getImage_id()%>.<%=image.getFilename()%>" /></a></li>
						  <%} %>
						</ul>
						
					</div>
    			<div class="col-lg-6 product-details pl-md-5 ftco-animate">
    				<h3><%=product.getProduct_name() %></h3>
    				<div class="rating d-flex">
							<p class="text-left mr-4">
								<a href="#" class="mr-2">5.0</a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
								<a href="#"><span class="ion-ios-star-outline"></span></a>
							</p>
							<p class="text-left mr-4">
								<a href="#" class="mr-2" style="color: #000;">100 <span style="color: #bbb;">Rating</span></a>
							</p>
							<p class="text-left">
								<a href="#" class="mr-2" style="color: #000;">500 <span style="color: #bbb;">Sold</span></a>
							</p>
						</div>
    				<p class="price"><span><%=Formatter.getCurrency(product.getPrice()) %></span></p>
    				<p><%=product.getDetail() %></p>
						<div class="row mt-4">
							<div class="col-md-6">
								<div class="form-group d-flex">
		            </div>
							</div>
							<div class="w-100"></div>
							<div class="input-group col-md-6 d-flex mb-3">
	             	<span class="input-group-btn mr-2">
	                	<button type="button" class="quantity-left-minus btn"  data-type="minus" data-field="">
	                   <i class="ion-ios-remove"></i>
	                	</button>
	            		</span>
	            		<input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
	             		<input type="text" id="quantity" name="quantity" class="form-control input-number" value="1" min="1" max="100">
	             	<span class="input-group-btn ml-2">
	                	<button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
	                     <i class="ion-ios-add"></i>
	                 </button>
	             	</span>
	          	</div>
	          	<div class="w-100"></div>
	          	<div class="col-md-12">
	          		<p style="color: #000;">　</p>
	          	</div>
          	</div>
          	<p><a onclick="addCart()" class="btn btn-black py-3 px-5">Add to Cart</a></p></div>
    		</div>
    	</div>
    </section>

    <section id="relevantRecipe" class="ftco-section">
    	<div class="container">
				<div class="row justify-content-center mb-3 pb-3">
				<table class="table">
						<thead class="thead-primary">
						<tr class="text-center">
						<td width="33%"><a style="color:white" href="#detailProduct">상세정보</a></td>
						<td width="33%"><a style="color:white" href="#detailRecipe">리뷰보기</a></td>
						<td width="33%" style="background:blue"><a style="color:white" href="#relevantRecipe">관련 레시피</a></td>
						</tr>
						</thead>
						</table>
          <div class="col-md-12 heading-section text-center ftco-animate">
            <h2 class="mb-4">관련 레시피</h2>
          </div>
        </div>   		
    	</div>
    	<div class="container">
    		<div class="row">
    			<%for(int i=0;i<recipeList.size();i++){ %>
    			<%Recipe recipe=recipeList.get(i); %>
    			<div class="col-md-6 col-lg-3 ftco-animate">
    				<div class="product">
    					<a href="/shop/recipe/detail?recipe_id=<%=recipe.getRecipe_id()%>" class="img-prod">
    					<img width="100%" height="100%" class="img-fluid" src="/resources/data/food/<%=recipe.getRecipe_id()%>.<%=recipe.getFilename() %>" alt="Colorlib Template">
    						<div class="overlay"></div>
    					</a>
    					<a href="/shop/recipe/detail?recipe_id=<%=recipe.getRecipe_id()%>"><div class="text py-3 pb-4 px-3 text-center">
    						<h3>[<%=recipe.getTitle() %>]</h3>
    						<h3>조리시간 : <%=recipe.getCooking_time() %>분</h3>
    						<h3>조회수 : <%=recipe.getHit() %></h3>
    					</div></a>
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