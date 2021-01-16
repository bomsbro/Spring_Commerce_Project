<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@page import="com.gumzima.shopping.model.domain.R_category"%>
<%@page import="java.util.List"%>
<%
	List<R_category> categoryList = (List) request.getAttribute("categoryList");
	List<Product> productList = (List)request.getAttribute("productList");
%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
a {
	text-decoration: none;
	color:black;
}

.pageNum {
	font-size: 20pt;
	color: blue;
	font-weight: bold;
}

#category {
	float: left;
	margin-right:50px;
}

#search {
	float: left;
}

.container {
	padding: 20px;
	font-size: 15pt;
	overflow: hidden;
}

#searchText{
	font-size: 15pt;
	width:200px;
	margin-left:20px;
	margin-right:20px;
}

#minPrice,  #maxPrice{
	font-size: 15pt;
	width:120px;
	margin-left:20px;
	margin-right:20px;
}
#minStock, #maxStock{
	font-size: 15pt;
	width:70px;
	margin-left:20px;
	margin-right:20px;
}
select {
	width: 200px;
	height: 30px;
	font-size: 15pt;
}
.buttons {
  background-color: #ddd;
  border: none;
  color: black;
  padding: 10px 10px;
  text-align: center;
  font-size: 16px;
  margin: 4px 2px;
  transition: 0.3s;
}
.buttons:hover {
  background-color: #3e8e41;
  color: white;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/recipe_list_function.jsp"%>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<form>
		<div class="container">
			<div id="category">
				<select name="r_category_id">
					<option value="0">음식분류</option>
					<%for (R_category r_category : categoryList) {	%>
					<option value="<%=r_category.getR_category_id()%>"><%=r_category.getName()%></option>
					<%}%>
			</div>
			<div id="search">
				<input type="text" id="searchText" placeholder="레시피 검색"/>
				<input type="button" class="buttons" id="0" value="전체">
				<%for(int i=0;i<productList.size();i++){ %>
				<%Product product = productList.get(i); %>
				<input type="button" class="buttons" id="<%=product.getProduct_id() %>" value="<%=product.getProduct_name()%>">
				<%} %>
				
			</div>
		</div>
	</form>
	<p>
   <table>
   </table>


	<tr colsapn="8">
		<button id="recipeRegist" class="buttons">상품등록</button>
	</tr>
	</p>


</body>
</html>
