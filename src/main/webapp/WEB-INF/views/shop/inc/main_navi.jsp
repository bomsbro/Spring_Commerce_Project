<%@ page contentType="text/html; charset=utf-8"%>
<div class="navbar">
  <a href="/admin">Home</a>
  <div class="dropdown">
    <button class="dropbtn">회원관리 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/shop/member/registForm">회원가입</a>
      <a href="/shop/member/loginForm">로그인</a>
      <a href="/shop/member/list">회원목록</a>
    </div>
  </div>
  <a href="/admin/notice/list">공지사항</a>
  
</div>