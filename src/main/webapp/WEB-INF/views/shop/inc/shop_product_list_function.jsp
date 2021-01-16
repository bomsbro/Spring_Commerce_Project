<%@ page contentType="text/html; charset=utf-8"%>
  <script>
	var data=[];
	var backUpData=[];
	var subId=[0];
	
	//페이징 처리 변수
	var totalRecord;//총 게시물
	var pageSize=8;//페이지에 나타날 게시물 수
	var totalPage;//총 페이지
	var blockSize=10;//블록별 나타날 페이지 수
	var currentPage; //시작페이지
	var firstPage; //각 블록의 첫 페이지
	var lastPage; //각 블록의 끝 페이지
	var curPos; //보고 있는 페이지
	var num; //시작 숫자
	
	var p_topcategory_id;
	$(function() {
		getSubcategory(0);
		getProductList();
		$($(".topcategory")[0]).find("a").addClass('active');
		
		$(".topcategory").click(function(e) {
			e.preventDefault();
		});
		
		var topcategory = $(".topcategory");
		topcategory.click(function () {
			p_topcategory_id=$(this).val();
			$(this).find("a").addClass('active');
			topcategory.not($(this)).find("a").removeClass('active');
			getSubcategory($(this).val());
		});
		
		selectSub();
		
		$("#searchText").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			getProductList();
			return false;
		});
		
		$("#sort").on("change", function() {
			sort($(this).val(), data);
		})
	});
	
	function selectSub(){
		$(this).click(function (e){
 			if(e.target.className=="sub"){
				$(".sub").removeClass("active");
				$(e.target).addClass('active');
				if(e.target.id!=0){
					subId=[e.target.id];
				}else{
					getSubcategory(p_topcategory_id);
				}
				getProductList();
			}
		});
	}
	
	function getSubcategory(num) {
		$.ajax({
			url : "/shop/product/sublist",
			type : "get",
			data : {
				p_topcategory_id : num
			},
			success : function(result) {
				$($(".product-category")[1]).html("");
				$($(".product-category")[1]).append("/　")
				if(num!=0){
					$($(".product-category")[1]).append("<li class='subcategory'><a href='javascript:selectSub()' class='sub active' id='0'> All</a></li>");
				}
				subId=[];
				for (var i = 0; i < result.length; i++) {
					var p_subcategory = result[i];
					subId.push(p_subcategory.p_subcategory_id);
					$($(".product-category")[1]).append("<li class='subcategory'><a href='javascript:selectSub()' class='sub' id='"+p_subcategory.p_subcategory_id+"'>"+ p_subcategory.name+"</a></li>");
				}
				$($(".product-category")[1]).append(" /")
				if(num==0){
					subId=[0];
				}
				getProductList();
			}
		});
	}
	
	//상품 가져오기
	function getProductList() {
		$.ajax({
			url : "/admin/product/getProduct",
			type : "post",
			data : {
				subId : subId,
				text : $("#searchText").val()
			},
			success : function(result) {
				data=result;
				backUpData=result;
				if(currentPage==null){
					currentPage=1;
				}
				paging(data.length, 1);
				createTable(data);
				sort($("#sort").val(), data);
			}
		});
	}
	
	//정렬버튼기능
	function sort(code, data) {
		if (code == 0){
			data.sort(function(a, b) {
				return a.regdate < b.regdate ? -1 : a.regdate > b.regdate ? 1 : 0;
			});
		} else if (code == 1) {
			data.sort(function(a, b) {
					return a.price < b.price ? -1	: a.price > b.price ? 1 : 0;
			});
		} else if (code == 2) {
			data.sort(function(a, b) {
				return a.price > b.price ? -1 : a.price < b.price ? 1 : 0;
			});
		} else if (code == 3) {
			data.sort(function(a, b) {
				return a.hit < b.hit ? -1 : a.hit > b.hit ? 1 : 0;
			});
		}
		createTable(data);
	}
	
	function paging(length, number){
		totalRecord = length;
		totalPage=Math.ceil(totalRecord/pageSize);
		currentPage=number;
		firstPage=currentPage-(currentPage-1)%blockSize;
		lastPage=firstPage+(blockSize-1);
		curPos=(currentPage-1)*pageSize;
		num=totalRecord-curPos;
		createTable(data);
	}
	
	function alert(num) {
		alert(num);
	}

	//데이터를 기반으로 테이블 생성
	function createTable(result) {
		var index=curPos;
		$("#productBox").empty();
		if(result.length==0){
			var str="<h1>해당 상품이 없습니다.<h1>";
			$("#productBox").append(str);
		}
		for(var i=0;i<pageSize;i++) {
			if(num<=i) break;
			var product=result[index++];
			var str="<div class='col-md-6 col-lg-3 ftco-animate fadeInUp ftco-animated'>";
			if(product.stock==0){
				str+="<div class='product'><aclass='img-prod'>";
			}else{
				str+="<div class='product'><a href='/shop/product/detail?product_id="+product.product_id+"' class='img-prod'>";
			}
			str+="<img class='img-fluid' src='/resources/data/basic/"+product.product_id+"."+product.filename+"' alt='Colorlib Template'>";
			str+="<!-- <span class='status'>30%</span> --><div class='overlay'></div></a><div class='text py-3 pb-4 px-3 text-center'>";
			if(product.stock==0){
				str+="<h2 style='color:red'><a>"+product.product_name+"</a></h2>";
			}else{
				str+="<h2><a href='/shop/product/detail?product_id="+product.product_id+"'>"+product.product_name+"</a></h2>";
			}
			
			str+="<div class='d-flex'><div class='pricing'><p class='price'>";
			if(product.stock==0){
				str+="<span class='price-sale' style='color:red'>₩ "+product.price.toLocaleString()+"</span></p></div></div>";
			}else{
				str+="<span class='price-sale'>₩ "+product.price.toLocaleString()+"</span></p></div></div>";
			}
			str+="<div class='bottom-area d-flex px-3'><div class='m-auto d-flex'>";
			if(product.stock==0){
				str+="<a class='add-to-cart d-flex justify-content-center align-items-center text-center'>";
			}else{
				str+="<a href='/shop/product/detail?product_id="+product.product_id+"' class='add-to-cart d-flex justify-content-center align-items-center text-center'>";
			}
			str+="<span><i class='ion-ios-menu'></i></span></a>";
			if(product.stock==0){
				str+="<a class='buy-now d-flex justify-content-center align-items-center mx-1'><span><i class='ion-ios-cart'></i></span></a>";
			}else{
				str+="<a href='#장바구니' class='buy-now d-flex justify-content-center align-items-center mx-1'><span><i class='ion-ios-cart'></i></span></a>";
			}
			if(product.stock==0){
				str+="<a class='heart d-flex justify-content-center align-items-center '><span style='color:red'>"+product.stock+"</span></a></div></div></div></div></div>";
			}else{
				str+="<a class='heart d-flex justify-content-center align-items-center '><span>"+product.stock+"</span></a></div></div></div></div></div>";
			}
			$("#productBox").append(str);
		}
		$("#page").empty();
		var pagestr="<div class='col text-center'><div class='block-27'><ul>";
		pagestr+="<li><a href='javascript:paging("+result.length+", "+1+")'>처음</a></li>";
		if((currentPage-10)>=1){
			pagestr+="<li><a href='javascript:paging("+result.length+", "+(currentPage-10)+")'>&lt;&lt;</a></li>";
        }else{
			pagestr+="<li><a>&lt;&lt;</a></li>";
        }
		if(currentPage!=1){
			pagestr+="<li><a href='javascript:paging("+result.length+", "+(currentPage-1)+")'>&lt;</a></li>";
        }else{
			pagestr+="<li><a>&lt;</a></li>";
        }
		for(var i=firstPage;i<=lastPage;i++){
        	if(i>totalPage)break;
        	if(currentPage==i){
				pagestr+="<li class='active'><a href='javascript:paging("+result.length+", "+i+")'><span>"+i+"</span></a></li>";
        	}else{
				pagestr+="<li><a href='javascript:paging("+result.length+", "+i+")'><span>"+i+"</span></a></li>";
        	}
        }
		if(currentPage<totalPage){
			pagestr+="<li><a href='javascript:paging("+result.length+", "+(currentPage+1)+")'>&gt;</a></li>";
		}else{
			pagestr+="<li><a>&gt;</a></li>";
        }
		if((currentPage+10)<=totalPage){
			pagestr+="<li><a href='javascript:paging("+result.length+", "+(currentPage+10)+")'>&gt;&gt;</a></li>";
		}else{
			pagestr+="<li><a>&gt;&gt;</a></li>";
        }
		pagestr+="<li><a href='javascript:paging("+result.length+", "+totalPage+")'>끝</a></li>";
		$("#page").append(pagestr);
	}
  </script>