<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<html>
<head>
   <title>이젠북컴퍼니 > 열린공간 > 분실물찾기</title>
</head>
<link rel="stylesheet" href="/resources/css/board/sub4/write_page.css">
<link rel="stylesheet" href="/resources/css/header.css">
<link rel="stylesheet" href="/resources/css/footer.css">
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
                    <h3>분실물찾기</h3>
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
                            <a href="/board/articleList">분실물찾기</a>
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
                                <form action="/board/articleModify" method="post" role="form" onsubmit="return false;">
                                    <input id="article_no" type="hidden" name="article_no" value="${dto.article_no}">
                                    <input type="hidden" name="amount" value="${cri.amount}">
                                    <input type="hidden" name="page" value="${cri.page}">
                                    <input type="hidden" name="type" value="${cri.type}">
                                    <input type="hidden" name="keyword" value="${cri.keyword}">

                                    <table class="bbs-edit">
                                        <tbody>
                                            <tr>
                                                <th class="first">제목</th>
                                                <td colspan="3">
                                                    <input type="text" style="width: 80%; height: 27px;" id="article_title"
                                                        name="article_title" value="${dto.article_title}" autocomplete="off"
                                                         maxlength="50">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="first">작성자</th>
                                                <td>
                                                    <input type="hidden" name="writer_name" value="${dto.writer_name}"
                                                        readonly="readonly">
                                                    <span>관리자</span>
                                                </td>
                                                <th class="first">작성일</th>
                                                <td>
                                                    <fmt:formatDate var="article_reg_date"
                                                        value="${dto.article_reg_date}" pattern="yyyy-MM-dd" />
                                                    ${article_reg_date}
                                            </tr>

                                            <tr>
                                                <td colspan="4" style="padding: 8px 0px;">
                                                    <textarea id="popContent" name="article_content">
                                                    ${dto.article_content}</textarea>
                                                </td>
                                            </tr>

                                            <!-- 파일 업로드 -->
                                            <tr>
                                                <td colspan="4">
                                                    <div class="uploadDiv">
                                                        <input type="file" name="uploadFile" id="uploadFile" multiple>
                                                        <input type="hidden" name="uuid" id="uuid">
                                                    </div>

                                                    <div class="uploadResult">
                                                        <ul>

                                                        </ul>
                                                    </div>

                                                </td>

                                            </tr>
                                        </tbody>

                                    </table>

                                    <!-- 글쓰기 btn -->
                                    <div class="write">
                                        <button class="write_btn" type="submit">수정하기</button>
                                    </div>

                                </form>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
    
    <!-- footer -->
    <jsp:include page="../../footer.jsp"></jsp:include>

<script type="text/javascript" src="/resources/js/ckeditor/ckeditor.js"></script>
<script>
    $(document).ready(function () {

        CKEDITOR.replace('popContent', {
            filebrowserImageUploadUrl: "/upload?boardName=article",
            height: 500
        });
        $(".sub4").addClass("active");

        /* 게시물 조회화면에서 수정화면으로 이동시 보여지는 첨부파일 화면 */
        $(function () {
			
        	$(".write_btn").on("click", function () {

                var article_title = $("#article_title").val();

                if (article_title == "") {

                    $("#article_title").focus();

                    return false;
                }

                if (confirm('수정하시겠습니까?')) {
                    $("form").attr("onsubmit", "return true;");
                    $("form").submit();
                }
            });
        	
            var article_no = '<c:out value="${dto.article_no}"/>';

            $.getJSON("/board/getAttachList", { article_no: article_no }, function (arr) {

                var str = "";

                $(arr).each(function (i, attach) {

                    //image type /* 기존에 첨부된 파일 썸네일 */
                    if (attach.file_type) {
                        var fileCallPath = encodeURIComponent(attach.upload_path + "/s_" + attach.uuid + "_" + attach.file_name);

                        str += "<li data-path='" + attach.upload_path + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.file_name + "' data-type='" + attach.file_type + "' >";
                        str += "<div style='margin-top: 5px;'>";
                        str += "<img src='/displayFiles?file_name=" + fileCallPath + "' width='20px' height='20px' style='vertical-align: middle;'>";
                        str += "<span> " + attach.file_name + " </span>";
                        str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class=" + attach.uuid + "_" + attach.file_name + ">x</button><br>";
                        str += "</div>";
                        str += "</li>";

                    } else {

                        str += "<li data-path='" + attach.upload_path + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.file_name + "' data-type='" + attach.file_type + "' >";
                        str += "<div style='margin-top: 5px;'>";
                        str += "<img src='/resources/imges/board/sub1/file_icon.png' width='20px' height='20px' style='vertical-align: middle;'></a>";
                        str += "<span> " + attach.file_name + " </span>";
                        str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class=" + attach.uuid + "_" + attach.file_name + ">x</button><br>";
                        str += "</div>";
                        str += "</li>";
                    }
                });

                $(".uploadResult ul").html(str);

            });//end getjson

        })();

        var formObj = $("form[role='form']");

        $("button[type='submit']").on("click", function (e) {

            e.preventDefault();

            var str = "";

            $(".uploadResult ul li").each(function (i, obj) {

                var jobj = $(obj);

                str += "<input type='hidden' name='attachList[" + i + "].file_name' value='" + jobj.data("filename") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].upload_path' value='" + jobj.data("path") + "'>";
                str += "<input type='hidden' name='attachList[" + i + "].file_type' value='" + jobj.data("type") + "'>";

            });

            formObj.append(str).submit();

        });

        /* 용량,파일형식 지정 */
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 5242880; //5MB

        function checkExtension(fileName, fileSize) {

            if (fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }

            if (regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }
            return true;
        }

        $("input[type='file']").change(function (e) {

            var formData = new FormData();

            var inputFile = $("input[name='uploadFile']");

            var files = inputFile[0].files;

            for (var i = 0; i < files.length; i++) {

                if (!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);

            }

            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false, data:
                    formData, type: 'POST',
                dataType: 'json',
                success: function (result) {
                    showUploadResult(result); //업로드 결과 처리 함수 

                }
            }); //$.ajax

        });

        /* 새로운 첨부파일 선택했을 때 */
        function showUploadResult(uploadResultArr) {

            if (!uploadResultArr || uploadResultArr.length == 0) {
                return;
            }

            var uploadUL = $(".uploadResult ul");

            var str = "";
            $(uploadResultArr).each(function (i, obj) {

                if (obj.image) {
                    var fileCallPath = encodeURIComponent(obj.upload_path + "/s_" + obj.uuid + "_" + obj.file_name);
                    var uuidName = obj.uuid + "_" + obj.file_name;

                    $("input[name='uuid']").attr('value', uuidName);

                    str += "<li data-path='" + obj.upload_path + "'";
                    str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.file_name + "' data-type='" + obj.image + "'";
                    str += " ><div style='margin-top: 5px;'>";
                    str += "<img src='/displayFiles?file_name=" + fileCallPath + "' width='20px' height='20px' style='vertical-align: middle;'>";
                    str += "<span> " + obj.file_name + " </span>";
                    str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'  class=" + obj.uuid + "_" + obj.file_name + ">x</button><br>";

                    str += "</div>";
                    str += "</li>";

                } else {
                    var fileCallPath = encodeURIComponent(obj.upload_path + "/" + obj.uuid + "_" + obj.file_name);
                    var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                    var uuidName = obj.uuid + "_" + obj.file_name;

                    $("input[name='uuid']").attr('value', uuidName);

                    str += "<li "
                    str += "data-path='" + obj.upload_path + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.file_name + "' data-type='" + obj.image + "' >";
                    str += "<div style='margin-top: 5px;'>";
                    str += "<img src='/resources/imges/board/sub1/file_icon.png' width='20px' height='20px' style='vertical-align: middle;'></a>";
                    str += "<span> " + obj.file_name + " </span>";
                    str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file'  class=" + obj.uuid + "_" + obj.file_name + ">x</button><br>";
                    str += "</div>";
                    str += "</li>";
                }

            });

            uploadUL.append(str);
        }

        /* x버튼 눌렀을 때 첨부파일 화면에서 사라짐 */
        $(".uploadResult").on("click", "button", function (e) {

            var uuid = $(this).attr("class");
            var targetFile = $(this).data("file");
            var type = $(this).data("type");

            var targetLi = $(this).closest("li");
            targetLi.remove();

            $.ajax({
                url: '/deleteFile',
                data: { file_name: targetFile, type: type, uuid: uuid },
                dataType: 'text',
                type: 'POST',
                success: function (result) {

                    targetLi.remove();
                    $("#uploadFile").val("");
                }
            }); //$.ajax */
        });

    });

</script>
</body>
</html>