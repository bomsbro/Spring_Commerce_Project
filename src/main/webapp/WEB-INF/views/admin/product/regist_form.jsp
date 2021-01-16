<%@page import="com.gumzima.shopping.model.domain.P_topcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<P_topcategory> topList = (List) request.getAttribute("topList");
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
#registRepDiv {
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
#registAddDiv {
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
	var previewAddImg = [];//미리보기 이미지 목록
	var uploadRepImg = [];//전송할 추가 이미지 목록
	var uploadAddImg = [];//전송할 추가 이미지 목록

	$(function() {
		CKEDITOR.replace("detail");
		
		$("#price").on("keyup", function(event) {//가격란에 숫자만 입력
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			return false;
		});
		
		$("#stock").on("keyup", function(event) {//재고란에 숫자만 입력
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			return false;
		});
		
		//상위 카테고리 선택하면
		$($("select")[0]).change(function() {
			getSubList(this);
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
		
		//추가 이미지 관련 이벤트
		$("#registAddDragArea").on("dragenter", function(e) {//드래그로 영역에 진입했을떄
			$(this).addClass("dragBorder");
		});

		$("#registAddDragArea").on("dragover", function(e) {
			e.preventDefault();//여타 다른 이벤트를 비활성화 시키자
		});
		$("#registAddDragArea").on("drop", function(e){ //드래그영역 위에서 이미지를 떨구면..
			e.preventDefault();
			
			var fileList = e.originalEvent.dataTransfer.files;
			
			previewAddImg=[];
			for(var i=0;i<fileList.length;i++){
				uploadAddImg.push(fileList[i]);
				if(uploadAddImg.length>4){
					alert("추가이미지는 4개까지만 등록됩니다.");
					uploadAddImg.splice(4, uploadAddImg.length);
					break;
				}
				previewAddImg.push(fileList[i]);
				preview(previewAddImg[i], i, 2);
			}
		});

		$("#registAddDragArea").on("dragleave", function(e) {//드래그로 영역에 벗어났을때
			$(this).removeClass("dragBorder");
		});

		$("#registAddDragArea").on("click", ".close", function(e) {
			for(var i=0;i<uploadAddImg.length;i++){
				if(uploadAddImg[i].name==e.target.id){
					uploadAddImg.splice(i, 1);
				}
			}

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

	//비동기 방식으로 하위 카테고리 요청하기!!
	function getSubList(obj) {
		//alert($(obj).val());
		$.ajax({
			url : "/admin/product/sublist",
			type : "get",
			data : {
				p_topcategory_id : $(obj).val()
			},
			success : function(result) {
				$($("select")[1]).empty();
				$($("select")[1]).append("<option>하위 카테고리 선택</option>");

				for (var i = 0; i < result.length; i++) {
					var p_subcategory = result[i]; //subcategory 1건에 대한 json 객체얻기!!
					$($("select")[1]).append("<option value=\""+p_subcategory.p_subcategory_id+"\">"+ p_subcategory.name + "</option>");
				}
			}
		});
	}

	function regist() {
		if(uploadRepImg!=""){
			$("textarea").val(CKEDITOR.instances.detail.getData());
	
			var formData = new FormData($("form")[0]);
			
			formData.append("repImg", uploadRepImg[0], uploadRepImg[0].name);
			
			$.each(uploadAddImg, function(i, file) {
				formData.append("addImg", file, file.name);
			});
			
			$.ajax({
				url : "/admin/product/regist",
				data : formData,
				contentType : false,
				processData : false,
				type : "post",
				success:function(responseData){
					var json=JSON.parse(responseData);
					if(json.result==1){
						alert(json.msg);
						location.href="/admin/product/list";
					}else{
						alert(json.msg);
					}
				}
			});
		}else{
			alert("대표이미지를 추가해주세요");
		}
	}
</script>
</head>
<body>
	<%@ include file="../inc/main_navi.jsp"%>
	<div class="container">
		<form>
			<h3>상품 등록</h3>
			<select>
				<option>상위 카테고리 선택</option>
				<%
				for (P_topcategory p_topcategory : topList) {
				%>
				<option value="<%=p_topcategory.getP_topcategory_id()%>"><%=p_topcategory.getName()%></option>
				<%
				}
				%>
			</select>
			<select name="p_subcategory.p_subcategory_id">
				<option>하위 카테고리 선택</option>
			</select>
			<label for="product_name"><b>상품명</b></label>
			<input type="text" name="product_name" placeholder="상품명">
			<label for="price"><b>가격</b></label>
			<input type="text" id="price" name="price" placeholder="가격">
			<label for="stock"><b>재고</b></label>
			<input type="text" id="stock" name="stock" placeholder="재고">
			
			<div id="registRepDiv">
				<label for="registRepDragArea"><b>대표이미지 (최대 1개)</b></label>
				<div id="registRepDragArea"></div>
			</div>
			
			<div id="registAddDiv">
				<label for="registAddDragArea"><b>추가이미지 (최대 4개)</b></label>
				<div id="registAddDragArea"></div>
			</div>

			<textarea id="detail" name="detail" placeholder="상세정보"	style="height: 200px"></textarea>

			<input type="button" value="상품 등록" onClick="regist()">
			<input type="button" value="목록보기" onClick="location.href='/admin/product/list'">
		</form>
	</div>

</body>
</html>
