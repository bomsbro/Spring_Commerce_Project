<%@page import="com.gumzima.shopping.model.domain.P_topcategory"%>
<%@page import="java.util.List"%>
<%
	List<P_topcategory> topList = (List) request.getAttribute("topList");
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
<%@ include file="../inc/product_list_function.jsp"%>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<form>
		<div class="container">
			<div id="category">
				<select name="p_topcategory_id">
					<option value="0">상위 카테고리</option>
					<%for (P_topcategory p_topcategory : topList) {	%>
					<option value="<%=p_topcategory.getP_topcategory_id()%>"><%=p_topcategory.getName()%></option>
					<%}%>
				</select> <select name="p_subcategory_id">
					<option value="0">하위 카테고리</option>
				</select>
			</div>
			<div id="search">
				<input type="button" class="buttons" id="reset" value="검색조건 초기화">
				<label style="margin-left:30px">상품명 검색 : </label>
				<input type="text" id="searchText"/>
				<label>가격 검색 : </label>
				<input type="text" id="minPrice"/>
				<label>~</label>
				<input type="text" id="maxPrice"/>
				<label>재고 검색 : </label>
				<input type="text" id="minStock"/>
				<label>~</label>
				<input type="text" id="maxStock"/>
			</div>
		</div>
	</form>
	<p>
   <table>
   </table>


	<tr colsapn="8">
		<button id="regist" class="buttons">상품등록</button>
	</tr>
	</p>


</body>
</html>
