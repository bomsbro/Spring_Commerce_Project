<%@page import="com.gumzima.shopping.model.domain.Recipe"%>
<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@page import="com.gumzima.shopping.model.domain.R_category"%>
<%@page import="com.gumzima.shopping.model.domain.P_topcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<R_category> categoryList = (List) request.getAttribute("categoryList");
	List<Product> productList=(List) request.getAttribute("productList");
	Recipe recipe=(Recipe)request.getAttribute("recipe");
	List<Integer> selectProductList=(List)request.getAttribute("selectProductList");
	String foodImg=recipe.getRecipe_id()+"."+recipe.getFilename();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=button] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=botton]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}
/* 드래그 관련 */
#detailRepDragArea{
	width: 100%;
	height: 180px;
	border: 1px solid #ccc;
}
#detailRepDiv {
	width: 20%;
	height: 200px;
	border: 1px solid #ccc;
	float: left;
}

#material {
	width: 80%;
	height: 200px;
	border: 1px solid #ccc;
	float: left;
}
.dragBorder {
	background: #ffffff;
}

.box {
	width: 180px;
	height: 180px;
	float: left;
	padding: 5px;
}

.box>img {
	width: 80%;
	height:80%;
}

.close, .basicClose {
	color: red;
	cursor: pointer;
}
</style>
<%@ include file="../inc/header.jsp"%>
<script type="text/javascript">
	var previewRepImg = [];//미리보기 이미지 목록
	var uploadRepImg = [];//전송할 추가 이미지 목록
	var materialList = [];
	var basicRepImg = []; //기존 대표 이미지 목록
	var delBasicRepImg = [];
	var date = new Date();

	$(function() {
		CKEDITOR.replace("content");
		
		$("select").val(<%=recipe.getR_category_id()%>);
		
		basicImgview();
		
		$("#cooking_time").on("keyup", function(event) {//가격란에 숫자만 입력
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			return false;
		});

		//대표 이미지 관련 이벤트
		$("#detailRepDragArea").on("dragenter", function(e) {//드래그로 영역에 진입했을떄
			$(this).addClass("dragBorder");
		});

		$("#detailRepDragArea").on("dragover", function(e) {
			e.preventDefault();//여타 다른 이벤트를 비활성화 시키자
		});

		$("#detailRepDragArea").on("drop", function(e){ //드래그영역 위에서 이미지를 떨구면..
			e.preventDefault();
			
			var fileList = e.originalEvent.dataTransfer.files;
			
			previewRepImg=[];
			for(var i=0;i<fileList.length;i++){
				uploadRepImg.push(fileList[i]);
				if(basicRepImg.length+uploadRepImg.length>1){
					alert("대표이미지는 1개까지만 등록됩니다.");
					uploadRepImg.splice(1-basicRepImg.length, uploadRepImg.length);
					break;
				}
				previewRepImg.push(fileList[i]);
				preview(previewRepImg[i], i, 1);
			}
		});

		$("#detailRepDragArea").on("dragleave", function(e) {//드래그로 영역에 벗어났을때
			$(this).removeClass("dragBorder");
		});

		$("#detailRepDragArea").on("click", ".close", function(e) {
			var f = uploadRepImg[e.target.id];
			var index = uploadRepImg.indexOf(f);

			uploadRepImg.splice(index, 1);
			delBasicRepImg.push(basicRepImg[0]);
			basicRepImg=[];
			
			//대상 요소 삭제
			$(e.target).parent().remove();
		});
	});
	
	//업로드 이미지 미리보기
	function preview(file, index, area){
		//js로 이미지 미리보기를 구현하려면, 파일리더를 이용하면 된다 FileReader
		var reader = new FileReader(); //아직은 읽을 대상 파일이 결정되지 않음..
		//파일일 읽어들이면, 이벤트 발생시킴 
		reader.onload=function(e){
			console.log(e.currentTarget.result);
			
			var tag="<div class=\"box\">";
			tag+="<div class=\"close\" id=\""+index+"\">X</div>";
			tag+="<img src=\""+e.currentTarget.result+"\">";
			tag+="</div>";
			
			if(area==1){
				$("#detailRepDragArea").append(tag);
			}else{
				$("#registAddDragArea").append(tag);
			}
		};
		reader.readAsDataURL(file);//지정한 파일을 읽는다.
	}
	
	function basicImgview(){
		var tag="<div class='box'>";
		tag+="<div class='close' id='"+0+"'>X</div>";
		tag+="<img src='/resources/data/food/<%=foodImg%>?time=date.getTime()'>";
		tag+="</div>";
		
		$("#detailRepDragArea").append(tag);
		basicRepImg.push("<%=foodImg%>");
	}
	
	function edit() {
		if(uploadRepImg!="" || basicRepImg!=""){
			$("textarea").val(CKEDITOR.instances.content.getData());
			
			var formData = new FormData($("form")[0]);
			
			if(uploadRepImg!=""){
				formData.append("foodImg", uploadRepImg[0], uploadRepImg[0].name);
			}
						
			formData.append("basicRepImg", basicRepImg);
			
			formData.append("delBasicRepImg", delBasicRepImg);
			
			for(var i=0;i<$("input[type='checkBox']").length;i++){
				if($("input[type='checkBox']")[i].checked){
					formData.append("materialList", $("input[type='checkBox']")[i].id);
				}
			}

			if(confirm("수정하겠습니까?")){
				$.ajax({
					url : "/admin/recipe/edit",
					data : formData,
					contentType : false,
					processData : false,
					type : "post",
					success:function(responseData){
						var json=JSON.parse(responseData);
						if(json.result==1){
							alert(json.msg);
							location.href="/admin/recipe/detail?recipe_id=<%=recipe.getRecipe_id()%>";
						}else{
							alert(json.msg);
						}
					}
				});
			}
		}else{
			alert("대표이미지를 추가해주세요");
		}
	}	

	function del(){
		if(confirm("레시피를 삭제하시겠습니까?")){
			location.href="/admin/recipe/del?recipe_id=<%=recipe.getRecipe_id()%>";
		}
	}
</script>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<div class="container">
		<form>
			<input type="hidden" name="recipe_id" value="<%=recipe.getRecipe_id()%>">
			<h3>레시피 등록</h3>
			<select name="r_category_id">
				<option>카테고리 선택</option>
				<%
				for (R_category r_category : categoryList) {
				%>
				<option value="<%=r_category.getR_category_id()%>"><%=r_category.getName()%></option>
				<%
				}
				%>
			</select>
			<label for="title"><b>제목</b></label>
			<input type="text" name="title" value="<%=recipe.getTitle() %>">
			<label for="cooking_time"><b>소요 시간 (분)</b></label>
			<input type="text" id="cooking_time" name="cooking_time" value="<%=recipe.getCooking_time()%>">
			
			
			<div id="detailRepDiv">
				<label for="detailRepDragArea"><b>요리이미지 (최대 1개)</b></label>
				<div id="detailRepDragArea"></div>
			</div>

			<div name="material" id="material">
			<label for="material"><b>사용 재료</b></label>
				<%for(Product product : productList){ %>
					<%int checked=0; %>
					<%for(int selectProduct : selectProductList){ %>
						<%if(product.getProduct_id()==selectProduct){ %>
							<%checked=1; %>
						<%} %>
					<%} %>
					<%if(checked==1){ %>
						<input type="checkbox" id="<%=product.getProduct_id()%>" checked="true"><%=product.getProduct_name() %>
					<%}else{ %>
						<input type="checkbox" id="<%=product.getProduct_id()%>"><%=product.getProduct_name() %>
					<%} %>
				<%} %>
			</div>
			<h3>조리방법</h3>
			<textarea id="content" name="content" style="height: 200px"><%=recipe.getContent() %></textarea>

			<input type="button" value="수정하기" onClick="edit()">
			<input type="button" value="삭제하기" onClick="del()">
			<input type="button" value="목록보기" onClick="location.href='/admin/recipe/list'">
		</form>
	</div>

</body>
</html>
