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
	
	var r_category_id=0;
	var product_id=0;
	$(function() {
		getRecipeList();
		$($(".topcategory")[0]).find("a").addClass('active');
		$($(".subcategory")[0]).find("a").addClass('active');
		
		$(".topcategory").click(function(e) {
			e.preventDefault();
		});
		
		$(".subcategory").click(function(e) {
			e.preventDefault();
		});
		var topcategory = $(".topcategory");
		topcategory.click(function () {
			r_category_id=$(this).val();
			$(this).find("a").addClass('active');
			topcategory.not($(this)).find(".top").removeClass('active');
			getRecipeList();
		});
		
		var subcategory = $(".subcategory");
		subcategory.click(function () {
			product_id=$(this).val();
			$(this).find("a").addClass('active');
			subcategory.not($(this)).find(".sub").removeClass('active');
			searchByProduct();
		});
		
		$("#searchText").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			getRecipeList()
			return false;
		});
		
		$("#sort").on("change", function() {
			sort($(this).val(), data);
		})
	});
	
	//레시피 가져오기
	function getRecipeList() {
		$.ajax({
			url : "/admin/shop/getShopRecipe",
			type : "post",
			data : {
				r_category_id : r_category_id,
				text : $("#searchText").val()
			},
			success : function(result) {
				data=result;
				backUpData=result;
				if(currentPage==null){
					currentPage=1;
				}
				paging(data.length, 1);
				searchByProduct();
				sort($("#sort").val(), data);
			}
		});
	}
	
	function searchByProduct(){
		data=[]
		for(var i=0;i<backUpData.length;i++){
			var recipe=backUpData[i];
			if(product_id==0){
				data=backUpData;
			}else{
				if(recipe.materialList.length>0){
					for(var a=0;a<recipe.materialList.length;a++){
						if(recipe.materialList[a]==product_id){
							data.push(recipe)
						}
					}
				}
			}
		}
		createTable(data);
		sort($("#sort").val(), data);
	}
	
	//정렬버튼기능
	function sort(code, data) {
		if (code == 0){
			data.sort(function(a, b) {
				return a.regdate < b.regdate ? -1 : a.regdate > b.regdate ? 1 : 0;
			});
		} else if (code == 1) {
			data.sort(function(a, b) {
					return a.cooking_time < b.cooking_time ? -1	: a.cooking_time > b.cooking_time ? 1 : 0;
			});
		} else if (code == 2) {
			data.sort(function(a, b) {
				return a.cooking_time > b.cooking_time ? -1 : a.cooking_time < b.cooking_time ? 1 : 0;
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
	
	//데이터를 기반으로 테이블 생성
	function createTable(result) {
		var index=curPos;
		$("#productBox").empty();
		if(result.length==0){
			var str="<h1>해당 레시피가 없습니다.<h1>";
			$("#productBox").append(str);
		}else{
			for(var i=0;i<pageSize;i++) {
				if(num<=i) break;
				var recipe=result[index++];
				var str="<div class='col-md-6 col-lg-3 ftco-animate fadeInUp ftco-animated'>";
				str+="<div class='product'><a href='/shop/recipe/detail?recipe_id="+recipe.recipe_id+"' class='img-prod'>";
				str+="<img class='img-fluid' src='/resources/data/food/"+recipe.recipe_id+"."+recipe.filename+"' alt='Colorlib Template'>";
				str+="<!-- <span class='status'>30%</span> --><div class='overlay'></div></a><div class='text py-3 pb-4 px-3 text-center'>";
				str+="<h3><a href='/shop/recipe/detail?recipe_id="+recipe.recipe_id+"'>"+recipe.title+"</a></h3>";
				str+="<h3>조리시간 : "+recipe.cooking_time+"분 / 조회수 : "+recipe.hit+"</h3></div></div></div>";	
				$("#productBox").append(str);
			}
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