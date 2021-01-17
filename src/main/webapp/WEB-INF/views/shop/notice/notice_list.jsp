<%@page import="com.gumzima.shopping.model.common.Pager"%>
<%@page import="com.gumzima.shopping.model.domain.Notice"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<Notice> noticeList = (List)request.getAttribute("noticeList");
	Pager pager = new Pager();
	pager.init(request, noticeList);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<%@ include file="../inc/header.jsp" %>
<style>
.textcontainer {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
#searchType {
	width:200px;
	height:30px;
	font-size:15pt;
}
#noticetable {
   border-collapse: collapse;
   border-spacing: 0;
   width: 100%;
   border: 1px solid #ddd;
}

.noticeth {
   text-align: left;
   padding: 16px;
}

.noticeth tr:nth-child(even) {
   background-color: #f2f2f2;
}
.noticea{text-decoration:none;}
.pageNum{
   font-size:20pt;
   color:blue;
   font-weight:bold;
}
#category{
	float:left;
	margin-right:1000px;
}
#search{
	float:right;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>

</script>
</head>
<head>
</head>
<body>
<%@ include file="../inc/top.jsp"%>	
<div class="textcontainer">
<table id="noticetable">
   <h3>공지사항</h3>
   
   <div>
   		<select id="searchType" name="searchType">
			<option value="title">제목</option>
			<option value="new">최신순</option>
			<option value="past">과거순</option>
		</select>
	</div>	
	<div id="search">		
			<input type="text" id="keyword" name="keyword" width="50px" height="30px"/>	
			<button id="searchBtn" onclick="setSearchType()">검색</button>
	</div>   
      <tr>
         <th class="noticeth">No</th>
         <th class="noticeth">제목</th>
         <th class="noticeth">작성자</th>
         <th class="noticeth">등록일</th>
         <th class="noticeth">조회수</th>
      </tr>
      <%-- <%
         //++혹은 --할 대상은 변수로 받아놓고 처리해야 편하다
         int curPos = pager.getCurPos();
         int num = pager.getNum();
      %>
      <%for(int i = 1; i<=pager.getPageSize();i++){ %>
      <%if(num<1)break; %> --%>
      <%for(int i = 1; i<noticeList.size();i++){ %>
      <%Notice notice = noticeList.get(i);%>
      <tr>
         <td class="noticeth"><%=1%></td> 
         <td class="noticeth"><a class="noticea" href = "/admin/notice/detail?notice_id=<%=notice.getNotice_id()%>"><%=notice.getTitle()%></a></td>
         <td class="noticeth"><%=notice.getWriter() %></td>
         <td class="noticeth"><%=notice.getRegdate() %></td>
         <td class="noticeth"><%=notice.getHit() %></td>
      </tr>
      <%} %>
      <tr>
<!--    <td colspan="5" style="text-align:center">
			<div align="center">
				<a href="/admin/notice/list?currentPage=<%if(pager.getFirstPage()==1){%>1<%}else{ %><%=pager.getFirstPage()-1%><%}%>">◀</a>
				<%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){ %>
				<%if(i>pager.getTotalPage())break;%>   
					<a  <%if(pager.getCurrentPage()==i){%>class="pageNum"<%}%>   href="/admin/notice/list?currentPage=<%=i%>">[<%=i %>]</a>
				<%} %>
				<a href="/admin/notice/list?currentPage=<%if(pager.getLastPage()>=pager.getTotalPage()){%><%=pager.getTotalPage()%><%}else{ %><%=pager.getLastPage()+1%><%}%>">▶</a>
			</div>
         </td>
 -->
      </tr>
   </table>
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
