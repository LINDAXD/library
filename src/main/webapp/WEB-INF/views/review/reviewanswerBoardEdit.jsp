<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>라온도서관 > 열린공간 > 묻고답하기</title>
	<link rel="stylesheet" href="/resources/css/board/sub3/answer_edit_page.css">
	<link rel="stylesheet" href="/resources/css/header.css">
	<link rel="stylesheet" href="/resources/css/footer.css">
</head>
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
  crossorigin="anonymous"></script>
<body>

	<div class="header">
    <jsp:include page="../header.jsp"></jsp:include>
    </div>
    
    	<div class="container">
		<div class="sub_title">
			<div class="doc-info">
				<!-- doc title -->
				<div class="doc-title">
					<h3>도서검색</h3>
					<ul>
						<!-- 홈 btn img -->
						<li class="first" style="background-image: none;"><a href="/">
								<img src="/resources/imges/common/navi_home_icon.gif">
						</a></li>
						<li><a href="/search/book">자료검색</a></li>
						<li><a href="/search/book">도서검색</a></li>
					</ul>

				</div>
			</div>
		</div>
		<div class="section">
			<div class="doc">

				<!-- 왼쪽 사이드바 -->
				<jsp:include page="lnb.jsp"></jsp:include>

				<!-- 본문 -->
				<div class="content">
					<div class="doc">
						<div class="wrapper-bbs" style="">

							<!-- 테이블 -->
							<div class="table-wrap">
								<h2>도서의 상세 내용을 확인하세요</h2>
								<table>
									<thead>
										<tr>
											<th style="width: 200px;">이미지</th>
											<th style="">도서 정보</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class=""><img src="${book.book_cover }"
												style="width: 200px;"></td>
											<td class="" style="text-align: left;">
												<h2>${book.book_title }</h2>
												<p>
													<b>저자명</b> : ${book.book_author }
												</p>
												<p>
													<b>출판사</b>: ${book.book_publisher }
												</p>
												<p>
													<b>출간일</b> : ${book.book_pubDate }
												</p>
												<p>
													<b>가격</b>:
													<fmt:formatNumber value="${book.priceStandard }"
														type="currency" />
												</p>
											</td>

										</tr>

									</tbody>

								</table>

							</div>

						</div>

					</div>
					<div
						style="display: flex; justify-content: center; align-items: center;">

						<form id="loan" onsubmit="return false;" method="post">
							<sec:authorize access="isAuthenticated()">
								<input type="hidden" class="user_email" name="user_email"
									value=<sec:authentication property="principal.dto.user_email"/>>
							</sec:authorize>

							<sec:authorize access="isAnonymous()">
								<input type="hidden" class="user_email" name="user_email">
							</sec:authorize>

							<input type="hidden" name="book_title"
								value="${book.book_title }"> <input type="hidden"
								name="book_author" value="${book.book_author }"> <input
								type="hidden" class="book_isbn" name="book_isbn"
								value="${book.book_isbn }"> <input type="hidden"
								name="book_cover" value="${book.book_cover }"> <input
								type="hidden" name="book_pubDate" value="${book.book_pubDate }">
							<input type="hidden" name="book_publisher"
								value="${book.book_publisher }"> <input type="hidden"
								name="amount" value="${cri.amount }"> <input
								type="hidden" name="page" value="${cri.page }"> <input
								type="hidden" name="type" value="${cri.type }"> <input
								type="hidden" name="keyword" value="${cri.keyword }">
							<button id="loan_btn" class=" btn2">대출 (${count } / 2)</button>
						</form>

						<span> </span>

						<form action="/search/book">
							<input type="hidden" name="amount" value="${cri.amount }">
							<input type="hidden" name="page" value="${cri.page }"> <input
								type="hidden" name="type" value="${cri.type }"> <input
								type="hidden" name="keyword" value="${cri.keyword }">
							<button class="btn3"
								style="display: flex; justify-content: center; align-items: center;">
								<img src="/resources/imges/search/book_icon.png"
									style="width: 30px;"> 목록
							</button>
						</form>

					</div>

					<h3>책 소개</h3>
					<div style="border: 1px solid #ccc; height: 500px;">상품 설명
						${book.description}</div>


					<!-- 테이블 -->
					<div class="table-wrap">
						<input type="hidden" value="${dto.reviewanswer_no}"
							name="${dto.reviewanswer_no}">
						<table class="bbs-edit">
							<tbody>
								<!-- 제목 -->
								<tr>
									<td class="bbs-title" colspan="6"><b>${dto.answer_title}</b>
									</td>
								</tr>

								<!-- 작성자 | 작성일 | 조회수 -->
								<tr>
									<th class="first">작성자</th>
									<td style="width: 15%;">관리자</td>
									<th class="first">작성일</th>
									<td>${fn:substring(dto.reviewanswer_reg_date, 0, 11)}</td>
									<th class="first">조회수</th>
									<td>${dto.reviewanswer_hits}</td>
								</tr>

								<!-- 본문 내용 -->
								<tr>
									<td colspan="6">
										<div class="bbs-content" style="width: 950px; overflow: auto;">
											<p>${dto.reviewanswer_content}</p>
										</div>
									</td>
								</tr>
							</tbody>

						</table>

						<!-- 글쓰기 btn -->
						<div class="review_title">
							<h3>REVIEW</h3>
							<button class="write_btn"
								onclick="location.href='/review/reviewBoardWrite'"
								style="cursor: pointer">리뷰작성하기</button>
							<form id="review_form" method="POST" onsubmit="return false;">
								<textarea type="text" class="review_input" name="review_input"
									placeholder="후기를 작성해주세요." cols="140" rows="10"></textarea>
							</form>
						</div>
						<div class="list_wrap">
							<form action="/review/reviewBoardList" method="get">
								<input type="hidden" name="amount" value="${cri.amount}">
								<input type="hidden" name="page" value="${cri.page}"> <input
									type="hidden" name="type" value="${cri.type}"> <input
									type="hidden" name="keyword" value="${cri.keyword}">
								<button class="list_btn">목록으로</button>
							</form>
						</div>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<div class="delete_wrap">
								<form action="/review/reviewanswerBoardDelete" method="get"
									onsubmit="return false" class="delete_form">
									<input type="hidden" name="reviewanswer_no" value="${dto.answer_no}">
									<input type="hidden" name="amount" value="${cri.amount}">
									<input type="hidden" name="page" value="${cri.page}"> <input
										type="hidden" name="type" value="${cri.type}"> <input
										type="hidden" name="keyword" value="${cri.keyword}">
									<button class="delete_btn">삭제하기</button>
								</form>
							</div>

							<div class="update_wrap">
								<form action="/review/reviewanswerBoardEdit" method="get">
									<input type="hidden" name="reviewanswer_no" value="${dto.answer_no}">
									<input type="hidden" name="amount" value="${cri.amount}">
									<input type="hidden" name="page" value="${cri.page}"> <input
										type="hidden" name="type" value="${cri.type}"> <input
										type="hidden" name="keyword" value="${cri.keyword}">
									<button class="update_btn" style="margin-right: 20px;">수정하기</button>
								</form>
							</div>
						</sec:authorize>

					</div>

				</div>

			</div>
		</div>
	</div>
	<div class="section">
		<div class="doc">

			<!-- 왼쪽 사이드바 -->
			<jsp:include page="lnb.jsp"></jsp:include>

			<!-- 본문 -->
			<div class="content">
				<div class="doc">
					<div class="wrapper-bbs">

						<!-- 테이블 -->
						<div class="table-wrap">
							<input type="hidden" value="${dto.reviewanswer_no}"
								name="${dto.reviewanswer_no}">
							<table class="bbs-edit">
								<tbody>
									<!-- 제목 -->
									<tr>
										<td class="bbs-title" colspan="6"><b>${dto.reviewanswer_title}</b>
										</td>
									</tr>

									<!-- 작성자 | 작성일 | 조회수 -->
									<tr>
										<th class="first">작성자</th>
										<td style="width: 15%;">관리자</td>
										<th class="first">작성일</th>
										<td>${fn:substring(dto.reviewanswer_reg_date, 0, 11)}</td>
										<th class="first">조회수</th>
										<td>${dto.reviewanswer_hits}</td>
									</tr>

									<!-- 본문 내용 -->
									<tr>
										<td colspan="6">
											<div class="bbs-content"
												style="width: 950px; overflow: auto;">
												<p>${dto.reviewanswer_content}</p>
											</div>
										</td>
									</tr>
								</tbody>

							</table>

							<!-- 글쓰기 btn -->
							<div class="list_wrap">
								<form action="/review/reviewBoardList" method="get">
									<input type="hidden" name="amount" value="${cri.amount}">
									<input type="hidden" name="page" value="${cri.page}"> <input
										type="hidden" name="type" value="${cri.type}"> <input
										type="hidden" name="keyword" value="${cri.keyword}">
									<button class="list_btn">목록으로</button>
								</form>
							</div>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<div class="delete_wrap">
									<form action="/review/reviewanswerBoardDelete" method="get"
										onsubmit="return false" class="delete_form">
										<input type="hidden" name="reviewanswer_no"
											value="${dto.reviewanswer_no}"> <input type="hidden"
											name="amount" value="${cri.amount}"> <input
											type="hidden" name="page" value="${cri.page}"> <input
											type="hidden" name="type" value="${cri.type}"> <input
											type="hidden" name="keyword" value="${cri.keyword}">
										<button class="delete_btn">삭제하기</button>
									</form>
								</div>

								<div class="update_wrap">
									<form action="/review/reviewanswerBoardEdit" method="get">
										<input type="hidden" name="reviewanswer_no"
											value="${dto.reviewanswer_no}"> <input type="hidden"
											name="amount" value="${cri.amount}"> <input
											type="hidden" name="page" value="${cri.page}"> <input
											type="hidden" name="type" value="${cri.type}"> <input
											type="hidden" name="keyword" value="${cri.keyword}">
										<button class="update_btn" style="margin-right: 20px;">수정하기</button>
									</form>
								</div>
							</sec:authorize>

						</div>

					</div>

				</div>

			</div>

		</div>
	</div>
    
    <!-- footer -->
    <jsp:include page="../footer.jsp"></jsp:include>

<script type="text/javascript" src="/resources/js/ckeditor/ckeditor.js"></script>
<script>
	$(function() {

		CKEDITOR.replace('popContent' , {
			 filebrowserImageUploadUrl: "/upload?boardName=review",
			 height: 500                                                  
	     });
		
		$(".sub3").addClass("active");
		
		$(".write_btn").on("click", function() {
			
			var title = $("#title").val();

	         if (title == "") {

	             $("#title").focus();
	             
	             return false;
	         }
			if(confirm('수정하시겠습니까?')) {
				$("form").attr("onsubmit", "result true");
				$("form").submit();
			} else {
				return false;
			}
		});
		
		
	});

</script>

</body>
</html>