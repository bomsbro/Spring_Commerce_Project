<%@ page contentType="text/html; charset=utf-8"%>
<script>
	var categorySort = true;
	var productSort = true;
	var	priceSort = true;
	var stockSort = true;
	var regdateSort = true;
	var hitSort = true;
	var data=[];
	var backUpData=[];
	var subId=[];
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
		getProductList();
		$("#regist").click(function() {//등록 버튼을 누르면 상품 등록 폼으로 이동
			location.href = "/admin/product/registform";
		});
		$($("select")[0]).change(function() {//상위 카테고리 select 바꾸면
			getSubList(this);//하위 카테고리 가져오기
		});
		$($("select")[1]).change(function() {//하위 카테고리 select 바꾸면
			getProductList();
		});
		$("#searchText").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			getProductList();
			return false;
		});
		$("#minPrice").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			valParseInt($(this).val(), "minPriceVal");
			sortPriceStock();
			return false;
		});
		$("#maxPrice").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			valParseInt($(this).val(), "maxPriceVal");
			sortPriceStock();
			return false;
		});
		$("#minStock").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			valParseInt($(this).val(), "minStockVal");
			sortPriceStock();
			return false;
		});
		$("#maxStock").on("keyup", function(event) {//상품명 검색에 단어를 넣을때마다 검색
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			valParseInt($(this).val(), "maxStockVal");
			sortPriceStock();
			return false;
		});
		$("#reset").on("click", function() {
			$("#searchText").val("");
			$("#minPrice").val("");
			$("#maxPrice").val("");
			$("#minStock").val("");
			$("#maxStock").val("");
			getProductList();
		})
	});
		
	//하위 카테고리 목록 가져오기
	function getSubList(obj) {
		$.ajax({
			url : "/admin/product/sublist",
			type : "get",
			data : {
				p_topcategory_id : $(obj).val()
			},
			success : function(result) {
				$($("select")[1]).empty();
				$($("select")[1]).append("<option value='0'>하위 카테고리</option>");
				subId=[];
				for (var i = 0; i < result.length; i++) {
					var p_subcategory = result[i]; //subcategory 1건에 대한 json 객체얻기!!
					subId.push(p_subcategory.p_subcategory_id);
					$($("select")[1]).append("<option value=\""+p_subcategory.p_subcategory_id+"\">"+ p_subcategory.name + "</option>");
				}
				getProductList();
			}
		});
	}
	
	//재고 및 가격 숫자화
	function valParseInt(number, val) {
		if(number==""){
			if(val=="minPriceVal"){
				minPriceVal=0;
			}else if(val=="minStockVal"){
				minStockVal=0;
			}
		}else{
			if(val=="minPriceVal"){
				minPriceVal=parseInt(number);
			}else if(val=="maxPriceVal"){
				maxPriceVal=parseInt(number);
			}else if(val=="minStockVal"){
				minStockVal=parseInt(number);
			}else if(val=="maxStockVal"){
				maxStockVal=parseInt(number);
			}
		}
	}
	
	//재고, 가격에 따른 검색
	function sortPriceStock() {
		if($("#minPrice").val()=="" && $("#maxPrice").val()=="" && $("#minStock").val()=="" && $("#maxStock").val()==""){
			data=backUpData;
			paging(backUpData.length, 1);
			createTable(backUpData);
		}else{
			data=[];
			if($("#maxPrice").val()=="" && $("#maxStock").val()==""){
				for(var i=0;i<backUpData.length;i++){
					if(backUpData[i].price>=minPriceVal && backUpData[i].stock>=minStockVal){
						data.push(backUpData[i]);
					}
				}
			}else if($("#maxPrice").val()==""){
				for(var i=0;i<backUpData.length;i++){
					if(backUpData[i].price>=minPriceVal && backUpData[i].stock>=minStockVal && backUpData[i].stock<=maxStockVal){
						data.push(backUpData[i]);
					}
				}
			}else if($("#maxStock").val()==""){
				for(var i=0;i<backUpData.length;i++){
					if(backUpData[i].price>=minPriceVal && backUpData[i].stock>=minStockVal && backUpData[i].price<=maxPriceVal){
						data.push(backUpData[i]);
					}
				}
			}else{
				for(var i=0;i<backUpData.length;i++){
					if(backUpData[i].price>=minPriceVal && backUpData[i].stock>=minStockVal && backUpData[i].price<=maxPriceVal && backUpData[i].stock<=maxStockVal){
						data.push(backUpData[i]);
					}
				}
			}
			paging(data.length, 1);
			createTable(data);
		}
	}
	
	//상품 가져오기
	function getProductList() {
		if(subId[0]==null || subId[0]==0){
			subId=[0];
		}else if($($("select")[1]).val()!=0){
			subId=[];
			subId.push($($("select")[1]).val());
		}else{
			subId=[];
			for(var i=1;i<=($($("select")[1])[0].length)-1;i++){
				subId.push($($("select")[1])[0][i].value);
			}
		}
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
				sortPriceStock();
			}
		});
	}
	
	//정렬버튼기능
	function sort(code, data) {
		if (code == 0){
			if (categorySort) {
				data.sort(function(a, b) {
					return a.p_subcategory.name < b.p_subcategory.name ? -1	: a.p_subcategory.name > b.p_subcategory.name ? 1 : 0;
				});
				categorySort = !categorySort;
			} else {
				data.sort(function(a, b) {
					return a.p_subcategory.name > b.p_subcategory.name ? -1 : a.p_subcategory.name < b.p_subcategory.name ? 1 : 0;
				});
				categorySort = !categorySort;
			}
		} else if (code == 1) {
			if (productSort) {
			data.sort(function(a, b) {
					return a.product_name < b.product_name ? -1	: a.product_name > b.product_name ? 1 : 0;
				});
				productSort = !productSort;
			} else {
				data.sort(function(a, b) {
					return a.product_name > b.product_name ? -1 : a.product_name < b.product_name ? 1 : 0;
				});
				productSort = !productSort;
			}
		}else if (code == 2) {
			if (priceSort) {
				data.sort(function(a, b) {
						return a.price < b.price ? -1	: a.price > b.price ? 1 : 0;
					});
					priceSort = !priceSort;
			} else {
				data.sort(function(a, b) {
					return a.price > b.price ? -1 : a.price < b.price ? 1 : 0;
				});
				priceSort = !priceSort;
			}
		}else if (code == 3) {
			if (stockSort) {
				data.sort(function(a, b) {
						return a.product_name < b.product_name ? -1	: a.product_name > b.product_name ? 1 : 0;
					});
					stockSort = !stockSort;
			} else {
				data.sort(function(a, b) {
					return a.stock > b.stock ? -1 : a.stock < b.stock ? 1 : 0;
				});
				stockSort = !stockSort;
			}
		} else if (code == 4) {
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
		} else if (code == 5) {
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
		var str = "<tr><th>No</th><th>이미지</th><th>카테고리 명 <input type='button' onClick='sort(0, data)' value='↑↓'/>";
		str += "</th><th>상품명 <input type='button' onClick='sort(1, data)' value='↑↓'/></th>";
		str += "<th>가격 <input type='button' onClick='sort(2, data)' value='↑↓'/></th>";
		str += "<th>재고 <input type='button' onClick='sort(3, data)' value='↑↓'/></th>";
		str += "<th>등록일 <input type='button' onClick='sort(4, data)' value='↑↓'/></th>";
		str += "<th>조회수 <input type='button' onClick='sort(5, data)' value='↑↓'/></th></tr>";
		var pageNum=num;
		var index=curPos;
		if(totalRecord==0){
			str+="<tr><td colspan='8'><div align='center'><h1>일치하는 결과가 없습니다.</h1></div></td></tr>"
		}else{
			for(var i=0;i<pageSize;i++) {
				if(num<=i) break;
				var product=result[index++];
				str += "<tr><td>" + pageNum + "</td>";
				str += "<td><img src=/resources/data/basic/"+product.product_id+"."+product.filename+"?time="+date.getTime()+" width='50px' height='50px'></td>";
				str += "<td>"+product.p_subcategory.name + "</td>";
				str += "<td><a href='/admin/product/detail?product_id="+product.product_id+"'><b>" + product.product_name + "</b></a></td>";
				str += "<td>" + product.price + "</td>";
				str += "<td>" + product.stock + "</td>";
				str += "<td>" + product.regdate.split(" ", 1) + "</td>";
				str += "<td>" + product.hit + "</td></tr>";
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