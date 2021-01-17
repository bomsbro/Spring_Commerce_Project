<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<%@ include file="../inc/header.jsp" %>
<style>
.textTable {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

.buttonTable {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.buttonTable:hover {
  background-color: #45a049;
}

.textcontainer {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
$(function(){
	$("#emailSubmit").click(function(){
		$.ajax({
			url:"/admin/customer/emailSubmit",
			type:"post",
			data:{
				title:$("#title").val(),
				writer:$("#writer").val(),
				writer_server:$("#writer_server").val(),
				content:$("#content").val()
			},
			success:function(data){					

				alert(data);
				location.href="/admin/customer/list";
				// 문의 성공 날리기
			}
		});
	});
});
</script>
</head>
<head>
</head>
<body>
<%@ include file="../inc/top.jsp"%>	
<div class="textcontainer">
  <div class="navbar">
  <a href="/admin">Home</a>
  <a href="/admin/product/list">Products</a>
  <a href="/admin/recipe/list">Recipes</a>
  <a href="/admin">Order</a>
  <a href="/admin/notice/list">Notice</a>
  <a href="/shop/customer/customer_list">1:1문의</a>
  
<!--   <div class="dropdown">
    <button class="dropbtn">주문관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">Link 1</a>
      <a href="#">Link 2</a>
      <a href="#">Link 3</a>
    </div>
  </div> --> 
</div>
</div>

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
