<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign In/Sign Up</title>

    <!-- Font Icon -->
    <link rel="stylesheet"
          href="<c:url value="/user/login/fonts/material-icon/css/material-design-iconic-font.min.css"/>">

    <!-- Main css -->
    <link rel="stylesheet" href="<c:url value="/user/login/css/style.css"/>">

    <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/assets/img/favicon.ico"/>">


    <!-- CSS
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/plugins.css"/>">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/style.css"/>">
    <style>
        label {
            top: 30%;
        }

        h2 {
            line-height: 1.66;
            margin: 0;
            padding: 0;
            font-weight: bold;
            color: #222;
            font-family: Poppins;
            font-size: 36px;
        }

        .main {
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

        .form-group span {

        }

    </style>
</head>
<body>
<div>
    <jsp:include page="header.jsp"/>

    <div class="main">

        <!-- Sign up form -->
        <section class="signup hidden" id="sign_up">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Welcome To<br> Reid Store</h2>
                        <form action="/sign-in-up/register" method="POST" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name"
                                       <c:if test="${not empty request.name}">value="${request.name}"</c:if>/>
                                <c:if test="${not empty errors.name}">
                                    <span style="color: red;"><c:out value="${errors.name}"/></span>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email"
                                       <c:if test="${not empty request.email}">value="${request.email}"</c:if>/>
                                <c:if test="${not empty errors.email}">
                                    <span style="color: red;"><c:out value="${errors.email}"/></span>
                                </c:if>
                                <c:if test="${not empty exitsEmail}">
                                    <span style="color: red;"><c:out value="${exitsEmail}"/></span>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label for="password"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="password" id="password" placeholder="Password"
                                       <c:if test="${not empty request.password}">value="${request.password}"</c:if> />
                                <c:if test="${not empty errors.password}">
                                    <span style="color: red;"><c:out value="${errors.password}"/></span>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label for="rePassword"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="rePassword" id="rePassword"
                                       placeholder="Repeat your password"
                                       <c:if test="${not empty request.rePassword}">value="${request.rePassword}"</c:if>/>
                                <c:if test="${not empty errors.rePassword}">
                                    <span style="color: red;"><c:out value="${errors.rePassword}"/></span>
                                </c:if>
                                <c:if test="${not empty rePasswordEqual}">
                                    <span style="color: red;"><c:out value="${rePasswordEqual}"/></span>
                                </c:if>
                            </div>

                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Đăng ký"/>
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="<c:url value="/user/login/images/signup-image.jpg"/>" alt="sing up image">
                        </figure>
                        <a class="signup-image-link" id="onSignIn">Tôi đã có tài khoản</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Sing in  Form -->
        <section class="sign-in visible" id="sign_in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img src="<c:url value="/user/login/images/signin-image.jpg"/>" alt="sing up image">
                        </figure>
                        <div style="display:flex; justify-content: center"><a class="signup-image-link" id="onSignUp">Đăng ký tài khoản</a>
                            <strong style="margin: 0px 5px">/</strong>
                            <a class="signup-image-link" href="/password/forgot" >Quên mật khẩu</a>
                        </div>

                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Welcome To<br> Reid Store</h2>
                        <form action="/sign-in-up/login" method="POST" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="email" name="email" id="your_email" placeholder="Your email"
                                       <c:if test="${not empty requestLogin.email}">value="${requestLogin.email}"</c:if>/>
                            </div>
                            <div class="form-group">
                                <label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="password" id="your_pass" placeholder="Password"
                                       <c:if test="${not empty requestLogin.password}">value="${requestLogin.password}"</c:if>/>
                            </div>
                            <c:if test="${not empty loginError}">
                                <span style="color: red;"><c:out value="${loginError}"/></span>
                            </c:if>

                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Đăng nhập"/>
                            </div>
                        </form>

                        <div class="social-login">
                            <span class="social-label">Hoặc đăng nhập với</span>
                            <ul class="socials">
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-facebook"></i></a></li>
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-twitter"></i></a></li>
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-google"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>


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

    <c:if test="${!isLogin}">signUp.click();</c:if>
    <c:if test="${isLogin || empty isLogin}">
        signIn.click();
    </c:if>


</script>
</body>
</html>
