<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
input[type=text], select, textarea,input[type=password] {
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

input[type=button]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}
.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid blue;
  border-right: 16px solid green;
  border-bottom: 16px solid red;
  border-left: 16px solid pink;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	//아이디 중복체크 
	$("input[type='button']").click(function(){
		if(confirm("회원가입을 하시겠습니까?")){
			
			regist();
		}
	});	
});

 function idCheck(){
	 console.log($("#m_id").val());
	 $.ajax({	
		 
			url:"/shop/member/Id_Check",
			type:"get",			
			data:{
				"m_id" : $("#m_id").val()  
			},				
			success:function(data){
				if(data==1){						
					alert("해당 아이디는 사용중입니다.");						
				}else if(data==0){
					$("#m_id").attr("value","Y");						
					alert("사용가능한 아이디입니다.");
				}			
			}
	});
	 
};
 
//요청이 완료되는 시점에 프로그래스바를 감춘다!!
function regist(){
	//로딩바 시작
	$("#loader").addClass("loader"); //class 동적 적용
	
	//form 태그의 파라미터들을 전송할수있는 상태로 둬야  data키값에 form 자체를 넣을 수 있다.
	var formData = $("#member_form").serialize(); //전부 문자열화 시킨다!!
	
	$.ajax({
		url:"/shop/member/regist",
		type:"post",
		data:formData,
		success:function(responseData){			
			//서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
			$("#loader").removeClass("loader"); //class 동적 제거
			var json = JSON.parse(responseData);
			if(json.result==1){
				alert(json.msg);
				alert("회원가입이 완료되었습니다. 감사합니다.");
				location.href="/shop/member/list"; // 회원목록으로 넘어가기!!!!
			}else{
				alert(json.msg);
			}
		}
	});
}

function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("/shop/member/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr,roadAddrPart1,roadAddrPart2){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		var addr1 = document.querySelector("m_addr1");
		var addr2 = document.querySelector("m_addr2");	
		addr1.value=	roadFullAddr;
		addr2.value=	roadAddrPart1;		
}
</script>
</head>
<body>
	<%-- <%@ include file="../inc/top.jsp"%> --%>
	<div class="container">
	<div id="loader" style="margin:auto"></div>	
	<form id="member_form" class="form" >
		<h3 class="text-center text-info">회원가입</h3>
		<div class="form-group">
			<label for="username" class="text-info">Username:</label><br> <input
				type="text" name="m_id" id="m_id" class="form-control"><button type="button" onclick="idCheck()">중복확인</button>
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Password:</label><br> <input
				type="password" name="m_pass" id="m_pass" class="form-control">
		</div>
		<div class="form-group">
			<label for="password" class="text-info">nickName:</label><br> <input
				type="text" name="m_name" id="m_name" class="form-control">
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Email:</label><br> <input
				type="text" name="m_email" id="m_email" class="form-control">
		</div>
		<div class="form-group">
			<select name="m_email_server" class="form-control">
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="naver.com">naver.com</option>
			</select>
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Phone:</label><br> <input
				type="text" name="m_phone" id="m_phone" class="form-control" value="(-)를 제외하고 입력해주세요.">
		</div>
		<div class="form-group">
			<label for="password" class="text-info">Addr:</label><br><input 
				type="button" onclick="goPopup();" value="찾기" > <input
				type="text" name="m_addr1" id="m_addr1" class="form-control">
		</div>	
		<div id="register-link" class="text-right">
			<input type="button" id="submit" value="Join">					
		</div>
	</form>
	</div>
</body>

</html>