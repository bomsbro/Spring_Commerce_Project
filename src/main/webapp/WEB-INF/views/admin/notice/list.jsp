<%@page import="com.gumzima.shopping.model.domain.Notice"%>
<%@page import="com.gumzima.shopping.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<Notice> noticeList = (List)request.getAttribute("noticeList");
	Pager pager = new Pager();
	pager.init(request, noticeList);
	//out.print(request.getAttribute("currentPage"));
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.container {
	padding: 20px;
	font-size:15pt;
	overflow: hidden;
}
select {
	width:200px;
	height:30px;
	font-size:15pt;
}
table {
   border-collapse: collapse;
   border-spacing: 0;
   width: 100%;
   border: 1px solid #ddd;
}

th, td {
   text-align: left;
   padding: 16px;
}

tr:nth-child(even) {
   background-color: #f2f2f2;
}
a{text-decoration:none;}
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
<script type="text/javascript">
$(function(){
	$("button").click(function(){
		setSearchType();
	});
});

</script>
</head>
<body>
   <table>
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
         <th>No</th>
         <th>제목</th>
         <th>작성자</th>
         <th>등록일</th>
         <th>조회수</th>
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
         <td><%=1%></td> 
         <td><a href = "/admin/notice/detail?notice_id=<%=notice.getNotice_id()%>"><%=notice.getTitle()%></a></td>
         <td><%=notice.getWriter() %></td>
         <td><%=notice.getRegdate() %></td>
         <td><%=notice.getHit() %></td>
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
      <tr>
         <td colspan="5">
            <button onClick="location.href='/admin/notice/registform'"> 글등록</button>
         </td>
      </tr>
   </table>

</body>
</html>
