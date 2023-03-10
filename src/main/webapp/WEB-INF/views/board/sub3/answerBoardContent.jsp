<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<title>이젠북컴퍼니 > 열린공간 > 묻고답하기</title>
	<link rel="stylesheet" href="/resources/css/board/sub3/answer_content_page.css">
	<link rel="stylesheet" href="/resources/css/header.css">
	<link rel="stylesheet" href="/resources/css/footer.css">
</head>
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
  crossorigin="anonymous"></script>
<body>

	<div class="header">
    <jsp:include page="../../header.jsp"></jsp:include>
    </div>

    <div class="container">
        <div class="sub_title">
            <div class="doc-info">
                <!-- doc title -->
                <div class="doc-title">
                    <h3>묻고답하기</h3>
                    <ul>
                        <!-- 홈 btn img -->
                        <li style="background-image: none;">
                            <a href="/">
                                <img src="/resources/imges/common/navi_home_icon.gif">
                            </a>
                        </li>
                        <li>
                            <a href="/board/noticeList">열린공간</a>
                        </li>
                        <li>
                            <a href="/board/qnaBoardList">묻고답하기</a>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
        <div class="section">
            <div class="doc">

                <!-- 왼쪽 사이드바 -->
                <jsp:include page="../lnb.jsp"></jsp:include>

                <!-- 본문 -->
                <div class="content">
                    <div class="doc">
                        <div class="wrapper-bbs">

                            <!-- 테이블 -->
                            <div class="table-wrap">
                            <input type="hidden" value="${dto.answer_no}" name="${dto.answer_no}">
                                <table class="bbs-edit">
                                    <tbody>
                                        <!-- 제목 -->
                                        <tr>
                                            <td class="bbs-title" colspan="6">
                                                <b>${dto.answer_title}</b>
                                            </td>
                                        </tr>

                                        <!-- 작성자 | 작성일 | 조회수 -->
                                         <tr>
                                            <th class="first">작성자</th>
                                            <td style="width: 15%;">관리자</td>
                                            <th class="first">작성일</th>
                                            <td>${fn:substring(dto.answer_reg_date, 0, 11)}</td>
                                            <th class="first">조회수</th>
                                            <td>${dto.answer_hits}</td>
                                        </tr> 

                                        <!-- 본문 내용 -->
                                        <tr>
                                            <td colspan="6">
                                                <div class="bbs-content" style="width:950px; overflow: auto;">
                                                    <p>${dto.answer_content}</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>

                                </table>

                                <!-- 글쓰기 btn -->
                                <div class="list_wrap">
                                	<form action="/board/qnaBoardList" method="get">
                                		<input type="hidden" name="amount" value="${cri.amount}">
                                		<input type="hidden" name="page" value="${cri.page}">
                                		<input type="hidden" name="type" value="${cri.type}">
                                		<input type="hidden" name="keyword" value="${cri.keyword}">
                                		<button class="list_btn">목록으로</button>
                                	</form>
                                </div>
                               <sec:authorize access="hasRole('ROLE_ADMIN')">
                               <div class="delete_wrap">
	                               <form action="/board/answerBoardDelete" method="get" onsubmit="return false" class="delete_form">
	                               		<input type="hidden" name="answer_no" value="${dto.answer_no}">
	                               		<input type="hidden" name="amount" value="${cri.amount}">
	                               		<input type="hidden" name="page" value="${cri.page}">
                                		<input type="hidden" name="type" value="${cri.type}">
                                		<input type="hidden" name="keyword" value="${cri.keyword}">
	                               		<button class="delete_btn">삭제하기</button>
	                               	</form>
	                            </div>
                                
								<div class="update_wrap">
									<form action="/board/answerBoardEdit" method="get">
	                               		<input type="hidden" name="answer_no" value="${dto.answer_no}">
	                               		<input type="hidden" name="amount" value="${cri.amount}">
	                               		<input type="hidden" name="page" value="${cri.page}">
	                               		<input type="hidden" name="type" value="${cri.type}">
	                               		<input type="hidden" name="keyword" value="${cri.keyword}">
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
    </div>

    <!-- footer -->
    <jsp:include page="../../footer.jsp"></jsp:include>
    
    
<script>
	$(function() {
		
		$(".sub3").addClass("active");
				
		
		var moveForm = $(".moveForm");
		
		$(".delete_btn").on("click", function(e) {
			e.preventDefault();
			if(confirm("삭제하시겠습니까?")){
				alert("게시물이 삭제되었습니다.");
				$(".delete_form").attr("onsubmit", "result true");
				$(".delete_form").submit();
			}else{
			}
		})
				
	})
	
</script>  
    
<script>
	function noEvent() {
		if (event.keyCode == 116) {
			event.keyCode= 2;
			return false;
		}else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82)){
			return false;
		}
	}
	
	document.onkeydown = noEvent;
</script>

</body>
</html>