<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận email</title>
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

        .error i {
            margin-right: 12px; /* Khoảng cách giữa biểu tượng và văn bản */
        }
        .customBtn {
            border-radius: 0px;
            padding: 10px;
            width: fit-content;
            text-transform: uppercase;
            letter-spacing: 5px;
        }

        .input-group-addon {
            padding: 12px;
            font-size: 14px;
            font-weight: 400;
            line-height: 1;
            color: #555;
            text-align: center;
            background-color: #eee;
            border: 1px solid #ccc;
            border-radius: 4px;
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
        .warning {
            font-size: 16px;
            background-color: #FEF6DF;
            color: #F4D110;
            border: 3px solid #FED253;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            font-family: "Emoji";
            animation: slideIn 0.5s, slideOut 0.5s 1.5s forwards;
        }
        .hidden {
            display: none;
        }
        #messageBox p{
            margin: 0;
        }
    </style>
</head>

<body>
<div id="messageBox" class="hidden warning">
    <p><i class="fas fa-exclamation" style="margin-right: 3px"></i>Email chưa được đăng ký</p>
</div>


<div class="backgroundGradient">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-4 text-center">
                <div class="row">
                    <div class="col-sm-12 mt-5 bgWhite" style="margin-top: 6rem!important;">
                        <div style="padding: 20px 20px 0 20px;">
                            <h3><i class="fa-solid fa-lock" style="font-size:52px;"></i></h3>
                            <h2 class="text-center">Forgot Password?</h2>
                            <p>You can reset your password here.</p>
                            <div class="panel-body">

                                <form action="/password/forgot" class="form" method="post">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa-regular fa-envelope" style="font-size: 18px; text-align: center;line-height: 24px;"></i></span>
                                            <input id="email" name="email"  placeholder="Email address" class="form-control" type="email">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input class="btn btn-primary btn-block mt-4 mb-4 customBtn"
                                               value="Reset Password" type="submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
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
        var messageFromURL = getParameterByName('message');
        if (messageFromURL === "failed") {
            showMessage();
        }
    })
</script>
</body>

</html>
