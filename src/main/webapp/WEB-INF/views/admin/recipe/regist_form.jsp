<%@page import="com.gumzima.shopping.model.domain.Product"%>
<%@page import="com.gumzima.shopping.model.domain.R_category"%>
<%@page import="com.gumzima.shopping.model.domain.P_topcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<R_category> categoryList = (List) request.getAttribute("categoryList");
	List<Product> productList=(List) request.getAttribute("productList");
	
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
#registRepDragArea{
	width: 100%;
	height: 180px;
	border: 1px solid #ccc;
}
#registFoodDiv {
	width: 20%;
	height: 200px;
	border: 1px solid #ccc;
	float: left;
}
#registAddDragArea {
	width: 100%;
	height: 180px;
	border: 1px solid #ccc;
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

.close {
	color: red;
	cursor: pointer;
}
</style>
<%@ include file="../inc/header.jsp"%>
<script type="text/javascript">
	var previewRepImg = [];//미리보기 이미지 목록
	var uploadRepImg = [];//전송할 추가 이미지 목록
	var materialList = [];

	$(function() {
		CKEDITOR.replace("content");
		
		$("#cooking_time").on("keyup", function(event) {//가격란에 숫자만 입력
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			return false;
		});

		//대표 이미지 관련 이벤트
		$("#registRepDragArea").on("dragenter", function(e) {//드래그로 영역에 진입했을떄
			$(this).addClass("dragBorder");
		});

		$("#registRepDragArea").on("dragover", function(e) {
			e.preventDefault();//여타 다른 이벤트를 비활성화 시키자
		});

		$("#registRepDragArea").on("drop", function(e){ //드래그영역 위에서 이미지를 떨구면..
			e.preventDefault();
			
			var fileList = e.originalEvent.dataTransfer.files;
			
			previewRepImg=[];
			for(var i=0;i<fileList.length;i++){
				uploadRepImg.push(fileList[i]);
				if(uploadRepImg.length>1){
					alert("대표이미지는 1개까지만 등록됩니다.");
					uploadRepImg.splice(1, uploadRepImg.length);
					break;
				}
				previewRepImg.push(fileList[i]);
				preview(previewRepImg[i], i, 1);
			}
		});

		$("#registRepDragArea").on("dragleave", function(e) {//드래그로 영역에 벗어났을때
			$(this).removeClass("dragBorder");
		});

		$("#registRepDragArea").on("click", ".close", function(e) {
			var f = uploadRepImg[e.target.id];
			var index = uploadRepImg.indexOf(f);

			uploadRepImg.splice(index, 1);

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
				$("#registRepDragArea").append(tag);
			}else{
				$("#registAddDragArea").append(tag);
			}
		};
		reader.readAsDataURL(file);//지정한 파일을 읽는다.
	}

	function regist() {
		if(uploadRepImg!=""){
			$("textarea").val(CKEDITOR.instances.content.getData());
	
			var formData = new FormData($("form")[0]);
			
			formData.append("foodImg", uploadRepImg[0], uploadRepImg[0].name);
			
			for(var i=0;i<$("input[type='checkBox']").length;i++){
				if($("input[type='checkBox']")[i].checked){
					formData.append("materialList", $("input[type='checkBox']")[i].id);
				}
			}
			
			$.ajax({
				url : "/admin/recipe/regist",
				data : formData,
				contentType : false,
				processData : false,
				type : "post",
				success:function(responseData){
					var json=JSON.parse(responseData);
					if(json.result==1){
						alert(json.msg);
						location.href="/admin/recipe/list";
					}else{
						alert("레시피 등록 실패");
					}
				}
			});
		}else{
			alert("대표이미지를 추가해주세요");
		}
	}
	function test() {
		for(var i=0;i<$("input[type='checkBox']").length;i++){
			if($("input[type='checkBox']")[i].checked){
				materialList.push($("input[type='checkBox']")[i].id);
			}
		}
	}
</script>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<div class="container">
		<form>
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
			<input type="text" name="title" placeholder="제목">
			<label for="cooking_time"><b>소요 시간 (분)</b></label>
			<input type="text" id="cooking_time" name="cooking_time" placeholder="소요시간 (분)">
			
			
			<div id="registFoodDiv">
				<label for="registRepDragArea"><b>요리이미지 (최대 1개)</b></label>
				<div id="registRepDragArea"></div>
			</div>

			<div name="material" id="material">
			<label for="material"><b>사용 재료</b></label>
				<%for(Product product : productList){ %>
				<input type="checkbox" id="<%=product.getProduct_id()%>"><%=product.getProduct_name() %>
				<%} %>
			</div>
			<h3>조리방법</h3>
			<textarea id="content" name="content" placeholder="조리방법"	style="height: 200px"></textarea>

			<input type="button" value="레세피 등록" onClick="regist()">
			<input type="button" value="목록보기" onClick="location.href='/admin/recipe/list'">
		</form>
	</div>

</body>
</html>
