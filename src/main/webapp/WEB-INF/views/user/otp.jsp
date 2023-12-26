<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập otp</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        .bgWhite {
            background: white;
            box-shadow: 0px 3px 6px 0px #cacaca;
        }

        .title {
            font-weight: 600;
            margin-top: 20px;
            font-size: 24px
        }

        .customBtn {
            border-radius: 0px;
            padding: 10px;
            width: fit-content;
            text-transform: uppercase;
            letter-spacing: 5px;
        }

        form input {
            display: inline-block;
            width: 50px;
            height: 50px;
            text-align: center;
        }

        .backgroundGradient {
            height: 100%;
            background-color: #FBDA61;
            background-image: linear-gradient(45deg, #FBDA61 0%, #FF5ACD 100%);
        }

        .hidden {
            display: none;
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


        .error i {
            margin-right: 12px; /* Khoảng cách giữa biểu tượng và văn bản */
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
<div class="backgroundGradient">
    <div id="messageBox" class="hidden error">
        <p id="messageContent"><i class="fa-sharp fa-solid fa-circle-xmark"></i>${message}</p>
    </div>
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-4 text-center">
                <div class="row">
                    <div class="col-sm-12 mt-5 bgWhite" style="margin-top: 6rem!important;">
                        <div class="title">
                            Xác thực mã OTP
                        </div>
                        <p>Mã xác thực đã được gửi đến email của bạn</p>
                        <form action="/otp/confirm/${type}" onsubmit="return confirm()" method="post" class="mt-5"
                              style="margin-top:20px!important;">
                            <input type="hidden" id="otpValue" name="otpValue" value="">
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(1)'
                                   maxlength=1>
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(2)'
                                   maxlength=1>
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(3)'
                                   maxlength=1>
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(4)'
                                   maxlength=1>
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(5)'
                                   maxlength=1>
                            <input class="otp" type="text" oninput='digitValidate(this)' onkeyup='tabChange(5)'
                                   maxlength=1>

                            <div style="text-align: left!important; margin-top: 15px"><a href="/otp/${type}"
                                                                                         class="link-underline-primary">Gửi
                                lại mã</a>
                            </div>
                            <hr class="mt-4" style="margin-top: 3px!important">
                            <button type="submit" class='btn btn-primary btn-block customBtn'
                                    style="margin-top: 0.5rem!important;">Verify
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    let digitValidate = function (ele) {
        ele.value = ele.value.replace(/[^0-9]/g, '');
    }
    let tabChange = function (val) {
        let ele = document.querySelectorAll('.otp');
        if (ele[val - 1].value != '') {
            ele[val].focus()
        } else if (ele[val - 1].value == '') {
            ele[val - 2].focus()
        }
    }

    function confirm() {
        // Lấy tất cả các phần tử input có class "otp"
        var otpInputs = document.querySelectorAll('.otp');

        // Tạo một biến để chứa giá trị OTP
        var otpValue = '';
        // Duyệt qua mảng các input và thêm giá trị vào biến otpValue
        otpInputs.forEach(function (input) {
            otpValue += input.value;
        });
        document.getElementById("otpValue").value = otpValue;

        console.log(document.getElementById("otpValue").value);
    }

    window.addEventListener('load', function () {
        console.log(document.getElementById("messageContent").textContent);
        if (document.getElementById("messageContent").textContent != "") {
            let messageBox = document.getElementById("messageBox");
            messageBox.classList.remove("hidden");
            setTimeout(function () {
                messageBox.classList.add("hidden");
            }, 2000);
        }
    });

</script>
</body>

</html>
