<%@ page contentType="text/html; charset=utf-8"%>
<script>
	var titleSort = true;
	var cookingSort = true;
	var regdateSort = true;
	var hitSort = true;
	var data=[];
	var backUpData=[];
	var minPriceVal=0;
	var maxPriceVal;
	var minStockVal=0;
	var maxStockVal;
	
	//페이징 처리 변수
	var totalRecord;//총 게시물
	var pageSize=10;//페이지에 나타날 게시물 수
	var totalPage;//총 페이지
	var blockSize=10;//블록별 나타날 페이지 수
	var currentPage; //시작페이지
	var firstPage; //각 블록의 첫 페이지
	var lastPage; //각 블록의 끝 페이지
	var curPos; //보고 있는 페이지
	var num; //시작 숫자
	
	var date=new Date();
	
	$(function() {
		getRecipeList(0);
		$("#recipeRegist").click(function() {//등록 버튼을 누르면 상품 등록 폼으로 이동
			location.href = "/admin/recipe/registform";
		});
		$($("select")[0]).change(function() {//상위 카테고리 select 바꾸면
			getRecipeList($(this).val());
			console.log($(this).val());
		});
		$("#searchText").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			getRecipeList($($("select")[0]).val());
			return false;
		});
		
		$(".buttons").click(function(e) {
			data=[]
			for(var i=0;i<backUpData.length;i++){
				var recipe=backUpData[i]
				if(e.target.id==0){
					data.push(recipe);
				}else{
					for(var a=0;a<recipe.materialList.length;a++){
						if(recipe.materialList[a]==e.target.id){
							data.push(recipe);						
						}
					}
				}
			}
			paging(data.length, 1)
			createTable(data);
		})
	});
	
	//레시피 가져오기
	function getRecipeList(num) {
		$.ajax({
			url : "/admin/recipe/getRecipe",
			type : "post",
			data : {
				r_category_id: num,
				text : $("#searchText").val()
			},
			success : function(result) {
				data=result;
				backUpData=result;
				if(currentPage==null){
					currentPage=1;
				}
				paging(data.length, currentPage);
				createTable(data);
			}
		});
	}
	
	//정렬버튼기능
	function sort(code, data) {
		//제목순 정렬
		if (code == 0) {
			if (titleSort) {
			data.sort(function(a, b) {
					return a.title < b.title ? -1	: a.title > b.title ? 1 : 0;
				});
				titleSort = !titleSort;
			} else {
				data.sort(function(a, b) {
					return a.title > b.title ? -1 : a.title < b.title ? 1 : 0;
				});
				titleSort = !titleSort;
			}
		}else if (code == 1) {
			//조리시간순 정렬
			if (cookingSort) {
				data.sort(function(a, b) {
					return a.cooking_time < b.cooking_time ? -1 : a.cooking_time > b.cooking_time ? 1 : 0;
			});
				cookingSort = !cookingSort;
			} else {
				data.sort(function(a, b) {
					return a.cooking_time > b.cooking_time ? -1 : a.cooking_time < b.cooking_time ? 1 : 0;
				});
				cookingSort = !cookingSort;
			}
		}else if (code == 2) {
			//등록일순 정렬
			if (regdateSort) {
				data.sort(function(a, b) {
					return a.regdate < b.regdate ? -1 : a.regdate > b.regdate ? 1 : 0;
			});
			regdateSort = !regdateSort;
			} else {
				data.sort(function(a, b) {
					return a.regdate > b.regdate ? -1 : a.regdate < b.regdate ? 1 : 0;
				});
				regdateSort = !regdateSort;
			}
		} else if (code == 3) {
			//조회수순 정렬
			if (hitSort) {
				data.sort(function(a, b) {
					return a.hit < b.hit ? -1 : a.hit > b.hit ? 1 : 0;
				});
				hitSort = !hitSort;
			} else {
				data.sort(function(a, b) {
					return a.hit > b.hit ? -1 : a.hit < b.hit ? 1 : 0;
				});
				hitSort = !hitSort;
			}
		}
		createTable(data);
	}
	
	//페이징 함수
	function paging(length, number){
		totalRecord = length;
		totalPage=Math.ceil(totalRecord/pageSize);
		currentPage=number;
		firstPage=currentPage-(currentPage-1)%blockSize;
		lastPage=firstPage+(blockSize-1);
		curPos=(currentPage-1)*pageSize;
		num=totalRecord-curPos;
		createTable(data);
		$("#"+currentPage).className="pageNum";
	}
	
	//데이터를 기반으로 테이블 생성
	function createTable(result) {
		$("table").html("");
		var str = "<tr><th>No</th><th>이미지</th>";
		str += "<th>재목 <input type='button' onClick='sort(0, data)' value='↑↓'/></th>";
		str += "<th>조리시간 <input type='button' onClick='sort(1, data)' value='↑↓'/></th>";
		str += "<th>등록일 <input type='button' onClick='sort(2, data)' value='↑↓'/></th>";
		str += "<th>조회수 <input type='button' onClick='sort(3, data)' value='↑↓'/></th>";
		var pageNum=num;
		var index=curPos;
		if(totalRecord==0){
			str+="<tr><td colspan='8'><div align='center'><h1>일치하는 결과가 없습니다.</h1></div></td></tr>"
		}else{
			for(var i=0;i<pageSize;i++) {
				if(num<=i) break;
				var recipe=result[index++];
				str += "<tr><td>" + pageNum + "</td>";
				str += "<td><img src=/resources/data/food/"+recipe.recipe_id+"."+recipe.filename+"?time="+date.getTime()+" width='50px' height='50px'></td>";
				str += "<td><a href='/admin/recipe/detail?recipe_id="+recipe.recipe_id+"'><b>" + recipe.title + "</b></a></td>";
				str += "<td>" + recipe.cooking_time + "</td>";
				str += "<td>" + recipe.regdate.split(" ", 1) + "</td>";
				str += "<td>" + recipe.hit + "</td></tr>";
				pageNum--;
			}
		}
		str+="<tr><td colspan='8'><div align='center'>";
		str+="<a href='javascript:paging("+result.length+", "+1+")'>[처음으로] </a>";
		if((currentPage-10)>=1){
        	str+="<a href='javascript:paging("+result.length+", "+(currentPage-10)+")'>[-10] </a>";
        }else{
        	str+="<a>[-10] </a>"
        }
		if(currentPage!=1){
        	str+="<a href='javascript:paging("+result.length+", "+(currentPage-1)+")'>◀</a>";
        }else{
        	str+="<a>◀</a>"
        }
		for(var i=firstPage;i<=lastPage;i++){
        	if(i>totalPage)break;
        	if(currentPage==i){
        		str+="<a href='javascript:paging("+result.length+", "+i+")' class='pageNum'>["+i+"]</a>";
        	}else{
        		str+="<a href='javascript:paging("+result.length+", "+i+")'>["+i+"]</a>";
        	}
        }
		if(currentPage<totalPage){
			str+="<a href='javascript:paging("+result.length+", "+(currentPage+1)+")'>▶ </a>";
		}else{
        	str+="<a>▶ </a>"
        }
		if((currentPage+10)<=totalPage){
			str+="<a href='javascript:paging("+result.length+", "+(currentPage+10)+")'>[+10] </a>";
		}else{
        	str+="<a>[+10] </a>"
        }
		str+="<a href='javascript:paging("+result.length+", "+totalPage+")'>[끝으로] </a>";
        str+="</div></td></tr>";
		$("table").append(str);
	}
</script>