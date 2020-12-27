<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"></jsp:include>
<div id="login">
<form action="/member/login" method="post">
  <div class="form-group">
    <label for="id">ID: </label>
    <input type="text" class="form-control" placeholder="Enter id" id="id" name="member_id">
  </div>
  <div class="form-group">
    <label for="pwd">Password:</label>
    <input type="password" class="form-control" placeholder="Enter password" id="pwd" name="member_pwd">
  </div>
  <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
  <a class="btn btn-warning" href="/member/join">회원가입</a>
</form>
</div>
<script>
$("#loginBtn").on("click", function() {
	//로그인버튼 누르면 일단 빈칸 확인 후 전달
	  if ($("#id").val().trim() == ""){
		  alert("아이디를 입력하세요.");
	  }
	  else{
		  $.ajax({
			   url: "/member/login",
			   type: "post",
			   data: {
				   member_id : $("#id").val(),
				   member_pwd : $("#pwd").val()
				   }			  
		    }).done(function(result) {
		    	console.log("확인"+result);
		    	result=="fail"? alert("아이디와 비밀번호를 다시 확인하세요"): location.href=result;
		    }).fail(function(result) {
		    	console.log("에러발생"+result);
			});
	  }
});
</script>