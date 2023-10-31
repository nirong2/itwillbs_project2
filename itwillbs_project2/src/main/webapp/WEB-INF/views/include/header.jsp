<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>세모클레스</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
			<ul class="navbar-nav me-2 mb-2 mb-lg-0">
				<c:choose>
					<c:when test="${empty user_id }">
						<li class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
					</c:when>
					<c:when test="${user_type eq 0 }">
						<li class="nav-item"><a class="nav-link" >${user_id }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">로그아웃</a></li>
					</c:when>
					<c:when test="${user_type eq 1 }">
						<li class="nav-item"><a class="nav-link" >${user_id }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">로그아웃</a></li>
					</c:when>
					<c:when test="${user_type eq 2 }">
						<li class="nav-item"><a class="nav-link" >${user_id }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">관리자페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">로그아웃</a></li>
					</c:when>
				</c:choose>
			</ul>
		</div>
	</nav>
	<div class="navbar navbar-light bg-light">
		<a class="navbar-brand" href="#"> <img src="/docs/5.1/assets/brand/bootstrap-logo.svg" alt="" width="30" height="24" class="d-inline-block align-text-top"> 
		세모클래스
		</a>
		<form class="d-flex justify-content-center">
			<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
			<button class="btn btn-outline-success" type="submit">Search</button>
		</form>
		<div style="width: 9%">
		</div>
	</div>
	<div>
		<ul class="nav nav nav-tabs justify-content-center">
			<li class="nav-item"><a class="nav-link" href="#">체험</a></li>
			<li class="nav-item"><a class="nav-link" href="#">내주변 체험</a></li>
			<li class="nav-item"><a class="nav-link" href="#">이벤트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">고객지원</a></li>
		</ul>
	</div>