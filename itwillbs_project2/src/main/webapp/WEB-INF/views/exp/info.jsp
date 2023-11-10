<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="../include/header.jsp"%>
<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Vue.js 스크립트 불러오기 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.min.js"></script>

<!-- 로그인 테스트 -->
<%
// 	session.setAttribute("user_num", "1");
// 	session.setAttribute("user_id", "test1");
// 	session.setAttribute("user_name", "김소예");
// 	session.setAttribute("user_type", "1");
	// 		session.invalidate();
%>
<!-- Section-->
<section class="py-5">
	<!-- 상단 전체 박스 -->
	<div class="border-top p-5 col-md-8 mx-auto">
		<!-- 요약정보 및 결제 -->
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-6">
					<!-- 왼쪽 ------------------------>
					<div class="container border" style="min-width: 300px">
						<div class="col-md-6 m-3">
							<img class="img-fluid" src="https://dummyimage.com/400x500/dee2e6/6c757d.jpg" class="card-img-left" alt="...">
						</div>
						<div class="col-md-6 m-3">
							<div class="row p-3">
								<span class="bg-secondary text-dark d-inline mx-1 my-1" style="width: 65px;">${expVO.exp_region.substring(0,2) }</span> <span class="bg-secondary text-dark d-inline mx-1 my-1" style="width: 65px;">${expVO.exp_category }</span>
								<h4 class="mx-1 my-1">${expVO.exp_name }</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-6">
					<!-- 오른쪽 ------------->
					<div class="container border" style="min-width: 300px">
						<!-- 달력 -->
						<div class="m-3" id="calendar" style="position: relative;"></div>
						<!-- <div id="selectedDateResult"></div> -->
						<input type="hidden" value="null" id="selectedDateResult"> <input type="hidden" value="null" id="totalQuantityValue">
						<div id="totalQuantityResult"></div>
						<div id="totalPriceResult"></div>
						<div class="p-2">
							<h5 class="">수량 선택</h5>
							<p>
								가격:
								<fmt:formatNumber>${expVO.exp_price}</fmt:formatNumber>
								원
							</p>
							<div class="quantity">
								<button class="btn btn-secondary" id="decrease">-</button>
								<span id="quantity">1</span>
								<button class="btn btn-secondary" id="increase">+</button>
							</div>
							<input type="hidden" id="totalPriceValue" value="${expVO.exp_price}">
							<p class="border-bottom p-2 fw-bolder fs-3">
								총 결제금액 <span id="totalPrice"><fmt:formatNumber>${expVO.exp_price}</fmt:formatNumber>원</span>
							</p>
						</div>
						<div class="p-2 d-grid gap-2 col-6 mx-auto">
							<a class="btn btn-danger btn-lg" onclick="requestPay()">결제하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 하단메뉴 전체 섹션 -->
<section class="">
	<div class="col-md-8 mx-auto p-5 border ">
		<!-- 하단메뉴(네비게이션) -->
		<div>
			<ul class="nav nav-underline justify-content-center" id="botNavBar">
				<li class="nav-item mx-4"><h4>
						<a class="nav-link active" style="cursor: pointer;">안내</a>
					</h4></li>
				<li class="nav-item mx-4"><h4>
						<a class="nav-link" id="botNavRev" style="cursor: pointer;">후기(${rList.size() < 0 && empty rList ? 0 : rList.size() })</a>
					</h4></li>
				<li class="nav-item mx-4"><h4>
						<a class="nav-link " style="cursor: pointer;">장소</a>
					</h4></li>
				<li class="nav-item mx-4"><h4>
						<a class="nav-link " style="cursor: pointer;">환불규정</a>
					</h4></li>
			</ul>
		</div>
		<!-- 하단메뉴 내용 -->
		<div class="tab-content justify-content-center" id="botNavMenu">
			<div class="tab-pane active" id="bnm1">
				<div class="container">
					<div class="text-center" id="image-container" style="overflow: hidden; max-height: 1000px; margin: 0 auto">
						<img class="img-fluid " src="https://dummyimage.com/800x5000/dee2e6/6c757d.jpg" class="card-img-left" alt="...">
					</div>
					<div class="d-flex justify-content-center">
						<button id="show-more-button" class="btn btn-light">더 보기</button>
					</div>
				</div>
			</div>
			<div class="tab-pane active" id="bnm2">
				<div class="container">
					<div class="row p-3">
						<div class="col-md-6 text-center">
							<h4>평균 별점</h4>
							<p class="display-4" id="avgStar">
								<fmt:formatNumber type="number" maxFractionDigits="2">${avgStar}</fmt:formatNumber>
							</p>
							<div class="justify-content-center">
								<div class="star-ratings " id="app">
									<div class="star-ratings-fill" :style="{ width: ratingToPercent + '%' }">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
									<div class="star-ratings-base">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
								</div>
							</div>
							<h5>${rList.size() < 0 && empty rList ? 0 : rList.size() }명</h5>
						</div>
						<div class="col-md-6">
							<table class="table table-borderless">
								<tbody>
									<tr>
										<td class="align-middle col-2"><span>5점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="5point" style="width:" aria-valuenow="5" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>4점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="4point" style="width:" aria-valuenow="4" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>3점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="3point" style="width:" aria-valuenow="3" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>2점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="2point" style="width:" aria-valuenow="2" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>1점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="1point" style="width:" aria-valuenow="1" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- 후기 작성 버튼  -->
				<div class="text-end m-2">
					<a class="btn btn-primary" id="reviewForm">후기 작성</a>
				</div>
				<!-- review 하나 -->
				<c:set var="revNum" value="0" />
				<c:forEach var="review" items="${rList }">
					<div class="border-top p-1">
						<div class="row">
							<div class="col-md-3">
								<!-- 별점 -->
								<div class="star-rating">${review.rev_star }</div>
							</div>
							<div class="col-md-3">${review.user_name }</div>
							<div class="col-md-6 justify-content-end d-flex">
								<!-- 날짜 -->
								<p>
									날짜:
									<fmt:formatDate value="${review.rev_regdate }" />
								</p>
							</div>
						</div>
						<div class="row">
							<div class="container1">
								<span class="d-inline-block text-truncate" style="max-width: 90%;"> ${review.rev_content } </span> <span class="text-info toggle-button" style="cursor: pointer;"> 더보기 </span>
							</div>
							<div class="text-end m-2">
								<c:if test="${sessionScope.user_num eq review.user_num }">
									<a class="btn btn-light" id="reviewUpdate${review.rev_num }" title="${review.rev_num }">수정</a>
									<a class="btn btn-secondary" href="/exp/revDel?rev_num=${review.rev_num }&exp_num=${param.exp_num}">삭제</a>
								</c:if>
								<c:if test="${sessionScope.user_num ne review.user_num }">
									<a class="btn btn-danger" id="reviewReport${review.rev_num }" title="${review.rev_num }">신고</a>
								</c:if>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<!-- 이미지 -->
								<c:if test="${review.rev_img ne null }">
									<%-- <img src="${review.rev_img }" alt="이미지 설명"> --%>
									<img src="https://dummyimage.com/100x100/dee2e6/6c757d.jpg" alt="이미지 설명">
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="tab-pane text-center" id="bnm3">
			<!-- 장소 -->
				<div id="map" style="width:100%;height:400px;"></div>
			</div>
			<!-- 환불 방법 -->
			<div class="tab-pane" id="bnm4">
				<div class="container">
					<br>
					<h2>안내사항(수정필요)</h2>
					<br>

					<h3>환불방법</h3>
					<div class="alert alert-secondary">
						<ul>
							<li>마이티켓 > 예매내역 > 환불신청 버튼 클릭</li>
							<li>결제수단에 따라 환불/입금까지 최대 5영업일 소요</li>
						</ul>
					</div>

					<h3>환불규정</h3>
					<div class="alert alert-secondary">
						<p>티켓 예매 후 4주 이내 : 전액 환불</p>
						<p>티켓 예매 후 4주 이후 : 환불 불가</p>
						<p>티켓 유효기간 만료 후 : 환불 불가</p>
						<p>유효기간은 예매시 선택 옵션에서 확인 가능합니다.</p>
					</div>

					<h3>주의사항</h3>
					<div class="alert alert-secondary">
						<ul>
							<li>유효기간이 만료되거나 사용한 티켓 환불 불가 (동일 상품이라도 옵션마다 유효기간이 다를 수 있음)</li>
							<li>일부 수량 환불 및 날짜/시간 변경 불가 (전체 환불 후 재예매)</li>
							<li>일정 예약 후 방문하지 않은 경우(No Show) 환불 불가</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- 리뷰 작성 수정 삭제 신고 ------------------------------------>
			<!-- 리뷰 작성 -------------------------------------------------->
			<div class="tab-pane" id="bnm5">
				<div class="border-top">
					<form action="/exp/reviewInsert?exp_num=${param.exp_num }" method="post">
						<div class="card-header">
							<h3 class="card-title">후기를 작성해주세요</h3>
							<div class="rating">
								<span class="star-1" data-rating="1">★</span> <span class="star-2" data-rating="2">★</span> <span class="star-3" data-rating="3">★</span> <span class="star-4" data-rating="4">★</span> <span class="star-5" data-rating="5">★</span>
							</div>
							<input type="hidden" name="rev_star" value="" class="selected-rating" />
						</div>
						<div class="card-body">
							<textarea class="form-control mb-2" name="rev_content" rows="10" placeholder="후기를 작성해주세요 ..."></textarea>
							<div class="form-group">
								<div class="input-group">
									<div class="custom-file">
										<input type="file" name="rev_img" class="custom-file-input" id="exampleInputFile">
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer text-end">
							<button type="submit" class="btn btn-primary ">후기작성</button>
						</div>
					</form>
				</div>
			</div>
			<!-- 리뷰 수정 -------------------------------------------------->
			<div class="tab-pane" id="bnm6">
				<div class="border-top">
					<form action="" method="post" id="frUpdate">
						<div class="card-header">
							<h3 class="card-title">후기를 수정해주세요</h3>
							<div class="rating">
								<span class="star-1" data-rating="1">★</span> <span class="star-2" data-rating="2">★</span> <span class="star-3" data-rating="3">★</span> <span class="star-4" data-rating="4">★</span> <span class="star-5" data-rating="5">★</span>
							</div>
							<input type="hidden" name="rev_star" value="" class="selected-rating" />
						</div>
						<div class="card-body">
							<textarea class="form-control mb-2" name="rev_content" rows="10" placeholder="후기를 작성해주세요 ..."></textarea>
							<div class="form-group">
								<div class="input-group">
									<div class="custom-file">
										<input type="file" name="rev_img" class="custom-file-input" id="exampleInputFile">
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer text-end">
							<button type="submit" class="btn btn-primary ">후기수정</button>
						</div>
					</form>
				</div>
			</div>
			<!-- 리뷰 신고 -------------------------------------------------->
			<div class="tab-pane" id="bnm7">
				<div class="border-top">
					<form action="" method="post" id="frReport">
						<div class="card-header">
							<h3 class="card-title">후기를 신고해주세요</h3>
						</div>
						<div class="card-body">
							<textarea class="form-control mb-2" name="report_content" rows="10" placeholder="신고내용을 작성해주세요 ..."></textarea>
						</div>
						<div class="card-footer text-end">
							<button type="submit" class="btn btn-primary ">후기신고</button>
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>


</section>
<button onclick="cancelPay('4')">환불하기</button>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script>

function cancelPay(order_num) {
 	  jQuery.ajax({
       url: "/payrest/cancelPay", 
       type: "POST",
       contentType: "application/json",
       data: order_num,
       success: function(refundResponse) {
         // refund ajax 실행 후 작업 수행
         
       	  if(refundResponse === "ok"){	
                 alert('환불 요청이 완료되었습니다.');
                 location.reload();
              // 예약취소 버튼 수정하기
             }else if(refundResponse === "already refund"){ 
          	  alert('이미 환불 처리된 주문 건입니다.');
            	  
	      }else{
                 alert('실패: 관리자에게 문의해주세요');
             }	
         
       },
       error: function(error) {
         // refund ajax 실행 중 에러 발생 시 처리
       }
     }); // refund ajax
}
  
// function cancelPay() {
// 	  jQuery.ajax({
// 	    url: "/exp/cancel", // 환불정보를 수신할 가맹점 서비스 URL
// 	    type: "POST",
// 	    contentType: "application/json",
// 	    data: JSON.stringify({
// 	      merchant_uid: "IMP470", // 결제건의 주문번호
// 	      cancel_request_amount: 2000, // 환불금액
// 	      reason: "테스트 결제 환불", // 환불사유
// 	      refund_holder: "홍길동", // 가상계좌 환불 시 필수입력: 환불 수령계좌 예금주
// 	      refund_bank: "88", // 가상계좌 환불 시 필수입력: 환불 수령계좌 은행코드
// 	      refund_account: "56211105948400" // 가상계좌 환불 시 필수입력: 환불 수령계좌 번호
// 	    }),
// 	    dataType: "json"
// 	  }).done(function(result) { // 환불 성공시 로직 
// 	    console.log("환불 성공", result);
// 	    // 환불에 성공한 경우에 실행할 추가 로직
// 	  }).fail(function(error) { // 환불 실패시 로직
// 	    console.error("환불 실패", error);
// 	    console.log("에러 응답 메시지:", error);
// 	  });
// 	}

</script>



<!-- footer -->
<%@include file="../include/footer.jsp"%>

<style>
<!--
.star-ratings {
	color: #aaa9a9;
	position: relative;
	unicode-bidi: bidi-override;
	width: max-content;
	-webkit-text-fill-color: transparent;
	/* Will override color (regardless of order) */
	-webkit-text-stroke-width: 1.3px;
	-webkit-text-stroke-color: #2b2a29;
	margin: 0 auto;
}

.star-ratings-fill {
	color: #fff58c;
	padding: 0;
	position: absolute;
	z-index: 1;
	display: flex;
	top: 0;
	left: 0;
	overflow: hidden;
	-webkit-text-fill-color: gold;
}

.star-ratings-base {
	z-index: 0;
	padding: 0;
}

.star-rating {
	font-size: 24px;
}

.star {
	color: gold; /* 별 색상 */
}

.rating {
	font-size: 24px;
	cursor: pointer;
}

[class^="star-"] {
	color: #ccc;
	transition: color 0.2s;
	cursor: pointer;
}

[class^="star-"].selected {
	color: #f5a623;
}
-->
</style>
<!-- script  -->
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=efx8eq0ugv"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
	//네이버 지도 api ---------------------------------------------------------
	var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
	};

	var map = new naver.maps.Map('map', mapOptions);
	
	
	//리뷰쓰기 수정 신고 성공 실패 알림 ------------------------------------------------
	$(document).ready(function() {
	    if (${not empty isRogin}) {
	        var isRogin = "${isRogin}"; // 문자열에서 불리언으로 변환
	        if (isRogin === "false") {
	            alert('로그인 해주세요');
	        }
	    }
	
	    if (${not empty isWork}) {
	        var isWork = "${isWork}"; // 문자열에서 불리언으로 변환
	        if (isWork === "false") {
	            alert('작업쓰기 실패');
	        } else if (isWork === "true") {
	            alert('작업 성공');
	        }
	    }
	});
	
	//결제 ------------------------------------------------------------------------
	
	var IMP = window.IMP; 
	IMP.init('imp66880805');
	
	var today = new Date();   
    var hours = today.getHours(); 
    var minutes = today.getMinutes();  
    var seconds = today.getSeconds();  
    var milliseconds = today.getMilliseconds();
    var makeMerchantUid = hours +  minutes + seconds + milliseconds;
	
	function requestPay() {
		if($('#selectedDateResult').val() === "null"){
			alert('날짜를 선택해 주세요');
		}else if(${userVO.user_id == null}){
			alert('로그인을 해주세요');
		}else{
	        IMP.request_pay({
	            pg : 'html5_inicis',
	            pay_method : 'card',
	            merchant_uid: "IMP"+makeMerchantUid, 
	            name : '${expVO.exp_name}',
	            custom_data : $('#selectedDateResult').val(),
	            amount : $('#totalPriceValue').val(),
// 	            amount : 100,
				code : "${param.exp_num}",
				unitPrice : ${expVO.exp_price} ,
				quantity : $('totalQuantityValue').val(),
	            buyer_email : '${userVO.user_id}',
	            buyer_name : '${userVO.user_name}',
	            buyer_tel : '${userVO.user_phone}'
	            //buyer_addr : '서울특별시 강남구 삼성동',
	            //buyer_postcode : '123-456'
	        }, function (rsp) { // callback
	            if (rsp.success) {
	                console.log(rsp);
	                $.ajax({
	                    type: 'POST',
	                    url: '/exp/payment',
	                    data: rsp,
	                    success: function (response) {
	                        console.log(response);
	                    },
	                    error: function (error) {
	                        console.error(error);
	                    }
	                });
	            } else {
	                console.log(rsp);
	                alert(rsp.error_msg);
	            }
	        });
		}
    }

	//달력 -------------------------------------------------------------------
	document.addEventListener("DOMContentLoaded", function() {
		flatpickr("#calendar", {
		    enable: [{
		        from: "${expVO.exp_start_date}",
		        to: "${expVO.exp_end_date}"
		    }],
		    //defaultDate: "today",
		    altFormat: "Y-m-d",
		    dateFormat: "Y-m-d",
		    inline: true,
		    minDate: "${expVO.exp_start_date}",
		    maxDate: "${expVO.exp_end_date}",
		    onChange: function(selectedDates, dateStr, instance) {
		    	let formattedDate = instance.formatDate(selectedDates[0], "Y-m-d");
		    	$('#selectedDateResult').val(formattedDate);
		    }
		});
	});
	
	//평균 별점 구하기 --------------------------------------------------
	const ratingValue =$('#avgStar').text();

	new Vue({
	    el: '#app',
	    data: {
	        ratingValue: ratingValue, // 별점 값을 입력하세요
	    },
	    computed: {
	        ratingToPercent() {
	            return (this.ratingValue / 5) * 100;
	        },
	    },
	});
	
	//별점 각각 갯수
	const appleCounts = [${ratings[0]}, ${ratings[1]}, ${ratings[2]}, ${ratings[3]}, ${ratings[4]}]; // 각 방에 있는 사과 갯수
	const totalApples = appleCounts.reduce((acc, count) => acc + count, 0); // 전체 사과 수 계산

	// 각 방의 백분율 계산
	const percentages = appleCounts.map(count => (count / totalApples) * 100);

	//console.log(percentages);
	
	$('#1point').css('width',percentages[0] +"%");
	$('#2point').css('width',percentages[1] +"%");
	$('#3point').css('width',percentages[2] +"%");
	$('#4point').css('width',percentages[3] +"%");
	$('#5point').css('width',percentages[4] +"%");
	
	//리뷰마다 별점 표시해주기
	// 별점을 표시할 요소들에 접근합니다.
    $('[class="star-rating"]').each(function() {
        const $starRating = $(this);
        const ratingValue = parseInt($starRating.text()); // div 내부의 숫자 값 가져옴

        // 숫자 뒤에 별점을 추가하여 설정합니다.
        $starRating.text("");
        $starRating.append(' ' + generateStars(ratingValue));
    });

    // 별점을 생성하는 함수
    function generateStars(ratingValue) {
        let stars = '';
        for (let i = 0; i < ratingValue; i++) {
            stars += '<span class="star">&#9733;</span>';
        }
        return stars;
    }

    $(document).ready(function() {
    	  let selectedRating = 0;

    	  // 별점에 마우스를 올리면 해당 별점까지 하이라이트
    	  $('[class^="star-"]').on('mouseenter', function() {
    	    const rating = $(this).data('rating');
    	    highlightStars(rating);
    	  });

    	  // 별점에서 마우스가 나가면 선택된 별점까지 하이라이트
    	  $('[class^="star-"]').on('mouseleave', function() {
    	    highlightStars(selectedRating);
    	  });

    	  // 별점을 클릭하면 선택한 별점을 저장
    	  $('[class^="star-"]').on('click', function() {
    	    selectedRating = $(this).data('rating');
    	    $('.selected-rating').val(selectedRating);
    	  });

    	  function highlightStars(rating) {
    	    $('[class^="star-"]').removeClass('selected');
    	    $('[class^="star-"]').each(function() {
    	      if ($(this).data('rating') <= rating) {
    	        $(this).addClass('selected');
    	      }
    	    });
    	  }
    	});

	
	//리뷰 긴글 접기 펴기 -----------------------------------------------------------------
		$(document).ready(function() {
		    $('.container1').each(function() {
		        const container = $(this);
		        const text = container.find('.text-truncate');
		        const toggleButton = container.find('.toggle-button');
		       
		        toggleButton.hide(); // 초기에는 숨김
		        if (text.length > 0) { // 요소가 존재하는지 확인
		            // 텍스트가 max-width를 초과하는지 확인
		            if (text[0].scrollWidth > text.innerWidth()) {
		                toggleButton.show(); // 초과하면 "더보기" 버튼 보이기
		            }
		            // "더보기" 버튼 클릭 시
		            toggleButton.click(function() {
		                text.toggleClass('text-truncate'); // text-truncate 클래스를 토글
		                if (text.hasClass('text-truncate')) {
		                    toggleButton.text('더보기');
		                } else {
		                    toggleButton.text('간략히');
		                }
		            });
		        }
		    });
		    //긴글 처리후 숨기기
		    $('#bnm2').removeClass('active');
		});
    
	//상품 개수 및 가격 ---------------------------------------------------------------------
    // 초기 상품 정보 설정
    let price = ${expVO.exp_price}; // 상품 가격
    let quantity = 1; // 상품 수량

    // HTML 요소 가져오기
    const decreaseButton = $("#decrease");
    const increaseButton = $("#increase");
    const quantityDisplay = $("#quantity");
    const totalPriceDisplay = $("#totalPrice");

    // 수량 감소 버튼 클릭 이벤트 처리
    decreaseButton.click(function () {
        if (quantity > 1) {
            quantity--;
            updateTotalPrice();
        }
    });

    // 수량 증가 버튼 클릭 이벤트 처리
    increaseButton.click(function () {
        quantity++;
        updateTotalPrice();
    });

    // 총 가격 업데이트 함수
    function updateTotalPrice() {
        totalPrice = price * quantity;
        quantityDisplay.text(quantity);
        $('#totalPriceValue').val(totalPrice);
        $('#totalQuantityValue').val(quantity);
        var formattedPrice = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(totalPrice);
        totalPriceDisplay.text(formattedPrice.replace('₩', '')+"원");
    }
  
    //하단 네비게이션 바 제어 -------------------------------------------------------------
    $('#botNavBar li h4 a').click(function(){
    	$('#botNavBar li h4 a').removeClass('active');
    	$('#botNavMenu div[class^=tab-pane]').removeClass('active');
    	$(this).addClass('active');
    	
    	if($(this).text().startsWith('안내')) $('#bnm1').addClass('active');
    	if($(this).text().startsWith('후기')) $('#bnm2').addClass('active');
    	if($(this).text().startsWith('장소')) $('#bnm3').addClass('active');
    	if($(this).text().startsWith('환불규정')) $('#bnm4').addClass('active');
    });
	//리뷰 작성칸 제어    
    $('#reviewForm').click(function(){
    	$('#botNavMenu div[class^=tab-pane]').removeClass('active');
    	$('#bnm5').addClass('active');
    });
	//리뷰 수정칸 제어    
    $('[id^=reviewUpdate]').click(function(){
    	var rev_num= $(this).attr('title');
    	$('#botNavMenu div[class^=tab-pane]').removeClass('active');
    	$('#bnm6').addClass('active');
    	$('#frUpdate').attr('action','/exp/revUpdate?exp_num=${param.exp_num}&rev_num='+rev_num);
    });
	//리뷰 신고칸 제어    
    $('[id^=reviewReport]').click(function(){
    	var rev_num= $(this).attr('title');
    	$('#botNavMenu div[class^=tab-pane]').removeClass('active');
    	$('#bnm7').addClass('active');
    	$('#frReport').attr('action','/exp/revReport?exp_num=${param.exp_num}&rev_num='+rev_num);
    });
    
    //안내 컨텐츠 사이즈 조절 -------------------------------------------------------------
    $("#show-more-button").click(function () {
        var imageContainer = $("#image-container");
        imageContainer.css("max-height", "none");
        $("#show-more-button").hide();
    });


</script>