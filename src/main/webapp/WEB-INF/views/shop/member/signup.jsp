<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@ include file="../inc/header.jsp" %>  
    
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
  <script type="text/javascript">
  var idcheck=false;
	$(function () {
		$("#m_phone").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		})	
	})

	function idCheck(){
		 $.ajax({	
				url:"/shop/member/Id_Check",
				type:"get",			
				data:{
					"m_id" : $("#m_id").val()  
				},				
				success:function(data){
					if(data==1){						
						alert("해당 아이디는 사용중입니다.");	
						idcheck=false;
					}else if(data==0){
						$("#m_id").attr("value","Y");						
						alert("사용가능한 아이디입니다.");
						idcheck=true;
					}			
				}
		});
		 
	};
	 
	//요청이 완료되는 시점에 프로그래스바를 감춘다!!
	function regist(){
		if(idcheck==true){
			if($("#m_id").val()==""){//id
				alert("아이디를 입력해주세요");
			}else if($("#m_pass").val()==""){//pass
				alert("비밀번호를 입력해주세요");
			}else if($("#m_name").val()==""){//name
				alert("이름을 입력해주세요");
			}else if($("#m_email").val()==""){//email
				alert("이메일을 입력해주세요");
			}else if($("#m_phone").val()==""){//phone
				alert("연락처를 입력해주세요");
			}else if($("#m_addr2").val()=="" || $("#m_addr3").val()==""){//addr
				alert("주소를 입력해주세요");
			}else{
				var formData = $("#member_form").serialize(); //전부 문자열화 시킨다!!
				if(confirm("회원가입 하시겠습니까?")){
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
								location.href="/shop/member/loginForm"; // 로그인폼으로..
							}else{
								alert(json.msg);
							}
						}
					});
				}
			}
		}else{
			alert("아이디 중복체크를 해주세요");
		}
	}
    function execPostCode() {
    	daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = 'data.address'; // 주소 변수	                
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }	
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('m_addr1').value = data.zonecode;
	                document.getElementById("m_addr2").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("m_addr3").focus();
	            },
	            theme: {
	                searchBgColor: "#0B65C8", //검색창 배경색
	                queryTextColor: "#FFFFFF" //검색창 글자색
	            }
	        }).open();
    		
    	});
    }
  </script>
  </head>
  <body class="goto-here">
	<%@ include file="../inc/top.jsp" %>
	
    <section class="ftco-section">
      <div class="container">      
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
						<form id="member_form" class="billing-form">
							<h3 class="mb-4 billing-heading">Join</h3>
	          	<div class="row align-items-end">
	          		<div class="col-md-6">
	                <div class="form-group">
	                	<label for="userid">UserID</label>
	                  <input type="text" id="m_id" name="m_id" class="form-control" ><button type="button" onclick="idCheck()" class="btn btn-primary py-3 px-4">Check</button>	                  
	                </div>
	              </div>
	              <div class="w-100"></div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="password">Password</label>
	                  <input type="password" id="m_pass" name="m_pass" class="form-control" placeholder="">
	                </div>
                </div>
                <div class="w-100"></div>
                <div class="col-md-6">
	                <div class="form-group">
	                	<label for="name">Name</label>
	                  <input type="text" id="m_name" name="m_name" class="form-control" placeholder="">
	                </div>
                </div>
                <div class="w-100"></div>
                <div class="col-md-6">
	                <div class="form-group">
	                	<label for="email">Email</label>
	                  <input type="text" id="m_email" name="m_email" class="form-control" placeholder="">
	                </div>
                </div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<label for="emailserver">emailServer</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down"></span></div>
		                  <select name="m_email_server" id="m_email_server" class="form-control">
		                  	<option value="gmail.com">gmail.com</option>
		                    <option value="naver.com">naver.com</option>
		                    <option value="daum.net">daum.net</option>
		                  </select>
		                </div>
		            	</div>
		            </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="phone">Phone</label>
	                  <input type="text" id="m_phone" name="m_phone" class="form-control" placeholder="(-)를 제외하고 입력바랍니다.">
	                </div>
	              </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                	<label for="address">Address</label>
	                		<input type="text" id="m_addr1" name="m_addr1" class="form-control" placeholder="우편번호">
							<input type="button" onclick="execPostCode()" value="찾기"><br>						
	                </div>
		            </div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<input type="text" id="m_addr2" name="m_addr2" class="form-control" placeholder="기본주소"><br>
							<input type="text" id="m_addr3" name="m_addr3" class="form-control" placeholder="상세주소">	                  
	                </div>
		            </div>
	            </div>
	          </form><!-- END -->
					</div>
					<div class="col-xl-5">
	          <div class="row mt-5 pt-3">
	          	<div class="col-md-12">
	          		<input type="button" onclick="regist()" id="submit" value="Join" class="form-control" >
	          	</div>
	          </div>
          </div> <!-- .col-md-8 -->
        </div>
      </div>
    </section> <!-- .section -->

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