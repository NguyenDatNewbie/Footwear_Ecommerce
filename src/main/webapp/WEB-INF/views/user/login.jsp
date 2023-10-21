<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign In/Sign Up</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="user/login/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="user/login/css/style.css">

    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">

    <!-- CSS
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="../assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="user/assets/css/style.css">
    <style>
        .main{
            height: 700px;
            background: #f8f8f8;
            padding: 50px 0px 1px 0;
        }
        .hidden {
            opacity: 0;
            transform: translateX(100%); /* Di chuyển sang phải 100% */
            transition: opacity 0.5s, transform 0.5s;
        }

        .visible {
            opacity: 1;
            transform: translateX(0); /* Di chuyển về vị trí ban đầu */
            transition: opacity 0.5s, transform 0.5s;
        }

    </style>
</head>
<body>
<div>
    <jsp:include page="header.jsp"/>

    <div class="main">

        <!-- Sign up form -->
        <div class="signup" id="sign_up">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>
                        <form:form  action="/sign-in-up/save" method="POST" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name"/>
                                <form:errors path="name" cssClass="error" />
x                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email"/>
                                <form:errors path="email" cssClass="error" />
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="password" id="pass" placeholder="Password"/>
                                <form:errors path="password" cssClass="error" />
                            </div>
                            <div class="form-group">
                                <label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password"/>
                            </div>
                            <div class="form-group">
                                <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                                <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Register"/>
                            </div>
                        </form:form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="user/login/images/signup-image.jpg" alt="sing up image"></figure>
                        <a class="signup-image-link" id="onSignIn">I am already member</a>
                    </div>
                </div>
            </div>
        </div>

<%--        <!-- Sing in  Form -->--%>
<%--        <section class="sign-in visible" id="sign_in">--%>
<%--            <div class="container">--%>
<%--                <div class="signin-content">--%>
<%--                    <div class="signin-image">--%>
<%--                        <figure><img src="user/login/images/signin-image.jpg" alt="sing up image"></figure>--%>
<%--                        <a class="signup-image-link" id="onSignUp">Create an account</a>--%>
<%--                    </div>--%>

<%--                    <div class="signin-form">--%>
<%--                        <h2 class="form-title">Sign up</h2>--%>
<%--                        <form method="POST" class="register-form" id="login-form">--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="your_name"><i class="zmdi zmdi-account material-icons-name"></i></label>--%>
<%--                                <input type="text" name="your_name" id="your_name" placeholder="Your Name"/>--%>
<%--                            </div>--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>--%>
<%--                                <input type="password" name="your_pass" id="your_pass" placeholder="Password"/>--%>
<%--                            </div>--%>
<%--                            <div class="form-group">--%>
<%--                                <input type="checkbox" name="remember-me" id="remember-me" class="agree-term" />--%>
<%--                                <label for="remember-me" class="label-agree-term"><span><span></span></span>Remember me</label>--%>
<%--                            </div>--%>
<%--                            <div class="form-group form-button">--%>
<%--                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in"/>--%>
<%--                            </div>--%>
<%--                        </form>--%>
<%--                        <div class="social-login">--%>
<%--                            <span class="social-label">Or login with</span>--%>
<%--                            <ul class="socials">--%>
<%--                                <li><a href="#"><i class="display-flex-center zmdi zmdi-facebook"></i></a></li>--%>
<%--                                <li><a href="#"><i class="display-flex-center zmdi zmdi-twitter"></i></a></li>--%>
<%--                                <li><a href="#"><i class="display-flex-center zmdi zmdi-google"></i></a></li>--%>
<%--                            </ul>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </section>--%>


    </div>
</div>
<!-- JS -->
<!-- Plugins JS -->
<!-- Plugins JS -->
<script src="<c:url value="user/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="user/assets/js/main.js"/>"></script>
<script>
    const signIn = document.getElementById('onSignIn');
    const signUp = document.getElementById('onSignUp');
    const elementA = document.getElementById('sign_in');
    const elementB = document.getElementById('sign_up');

    signUp.addEventListener('click', function () {
        elementA.classList.remove('visible');
        elementA.classList.add('hidden');
        elementB.classList.remove('hidden');
        elementB.classList.add('visible');
    });

    signIn.addEventListener('click', function () {
        elementA.classList.remove('hidden');
        elementA.classList.add('visible');
        elementB.classList.remove('visible');
        elementB.classList.add('hidden');
    });



</script>
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
