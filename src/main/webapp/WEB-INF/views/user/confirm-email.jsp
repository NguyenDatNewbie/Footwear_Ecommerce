<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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

    </style>
</head>

<body>
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
</body>

</html>
