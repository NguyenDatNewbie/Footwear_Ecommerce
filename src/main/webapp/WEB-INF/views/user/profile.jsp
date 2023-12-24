<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Somore | Thông tin cá nhân</title>

    <link rel="shortcut icon" type="image/x-icon"
          href="assets/img/favicon.ico">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Plugins CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/plugins.css"/>">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/style.css"/>">

    <%--<link rel="stylesheet" href="/assets/css/bootstrap.min.css"--%>
    <%--	type="text/css">--%>


    <style>
        .user-profile h4 {
            font-size: 14px;
            line-height: 24px;
        }

        .btn-info {
            font-family: emoji;
            border: none;
        }
        .inputLabel {
            font-size: 14px;
            color: black;
            margin-bottom: 6px;
            margin-top: 24px;
            font-weight: 500;
        }

        .inputDiv {
            width: 70%;
            display: flex;
            flex-direction: column;
            margin: auto;
        }
        .modal-content button.close{
            left: 90%;
            /*top: 40px;*/
        }
        .modal-body{
            padding: 0 0 40px 0;
        }
        .button-center{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .error {
            font-weight: bold;
            height: 52px;
            font-size: 14px;
            background-color: #FED2D2;
            color: red;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            border: 3px solid red;
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            animation: slideIn 0.5s, slideOut 0.5s 1.5s forwards;
        }
        .success {
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            font-family: "Emoji";
            animation: slideIn 0.5s, slideOut 0.5s 2s forwards;
        }
        @keyframes slideIn {
            from {
                top: -50px;
                opacity: 0;
            }
            to {
                top: 10px;
                opacity: 1;
            }
        }

        @keyframes slideOut {
            from {
                top: 10px;
                opacity: 1;
            }
            to {
                top: -50px;
                opacity: 0;
            }
        }
    </style>

</head>

<body>

<!-- Header Section Begin-->
<jsp:include page="header.jsp"/>
<!-- Header Section End -->




<div id="messageBox" class="hidden ">
</div>



<!-- Contact Section Begin -->
<div class="container" style="padding: 50px 50px">
    <div class="spad">
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center"
                             id="profile-head">
                            <img src="https://cdn-icons-png.flaticon.com/512/3033/3033143.png" width="150">
                            <div class="mt-3">
                                <h4>${info.accountDetail.name}</h4>
                            </div>
                            <button class="btn btn-info" style="background-color: blue">Update Image</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card mb-3 user-profile">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h4 class="mb-0">Họ & tên</h4>
                            </div>
                            <div class="col-sm-9 text-secondary">${info.accountDetail.name}</div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h4 class="mb-0">Email</h4>
                            </div>
                            <div class="col-sm-9 text-secondary">${info.email}</div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h4 class="mb-0">Số điện thoại</h4>
                            </div>
                            <div class="col-sm-9 text-secondary">${info.accountDetail.phone}</div>
                        </div>

                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h4 class="mb-0">Địa chỉ</h4>
                            </div>
                            <div class="col-sm-9 text-secondary">${info.accountDetail.address}</div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-12">
                                <a class="btn btn-info" href="/profile/update/${info.id}">Sửa thông tin</a>
                                <a href="#"  class="btn btn-info" style="background-color: cadetblue; margin-left: 10px"
                                   data-toggle="modal" data-target="#modal_changePass">Thay đổi mật khẩu</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Footer Section Begin -->
<jsp:include page="footer.jsp"/>
<!-- Footer Section End -->
<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Modal Heading</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                Modal body..
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>



<div class="modal" id="modal_changePass">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal"
                    aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <div class="modal-body">
                <form action="/profile/change-pass-word" method="post">
                    <div class="button-center">
                    <img src="https://cdn-icons-png.flaticon.com/512/6195/6195700.png" style="width: 80px">
                    </div>
                    <div class="inputDiv">
                        <label class="inputLabel" for="password">Mật khẩu hiện tại</label>
                        <input type="password" id="currentPass" name="currentPassword" required>
                    </div>
                    <div class="inputDiv">
                        <label class="inputLabel" for="password">Mật khẩu mới</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="inputDiv">
                        <label class="inputLabel" for="password">Nhập lại mật khẩu</label>
                        <input type="password" name="rePassword" required>
                    </div>
                    <input value="${info.email}" style="display: none" name="email">
                    <div class="button-center">
                        <button class="btn btn-info" style="background-color: blue; margin-top: 40px" type="submit">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
<script>
    // Hàm để lấy giá trị của tham số từ URL
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
    function showMessage(){
        let messageBox = document.getElementById("messageBox");
        messageBox.classList.remove("hidden");
        setTimeout(function () {
            messageBox.classList.add("hidden");
        }, 2000);
    }
    window.addEventListener('load', function (){
        var status = getParameterByName('status');
        var messageFromURL = getParameterByName('message');
        let messageBox = document.getElementById("messageBox");

        if (status === "failed") {
            messageBox.classList.add('error');
            messageBox.innerHTML='<p ><i class="fa-solid fa-circle-xmark" style="margin-right: 3px"></i>'+messageFromURL+'</p>';
            messageBox.classList.remove("hidden");
            setTimeout(function () {
                messageBox.classList.add("hidden");
                messageBox.classList.remove('error')
            }, 2000);
        }
        else  if (status === "success"){
            messageBox.classList.add('success');
            messageBox.innerHTML='<p><i class="fas fa-check-circle" style="margin-right: 3px"></i>'+messageFromURL+'</p>';
            messageBox.classList.remove("hidden");
            setTimeout(function () {
                messageBox.classList.add("hidden");
                messageBox.classList.remove('success')
            }, 2000);
        }
    })

</script>
</body>

</html>