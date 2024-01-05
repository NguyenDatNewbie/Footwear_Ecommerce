<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Liên hệ</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
    
    <!-- CSS 
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="assets/css/plugins.css">
    
    <!-- Main Style CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .content{
            margin: 50px 20px;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />
    <div class="content">
    <!--contact area start-->
    <div class="contact_area">
        <div class="container">   
            <div class="row">
                <div class="col-lg-6 col-md-12">
                   <div class="contact_message">
                        <h4 style="font-size: 20px">Liên hệ với chúng tôi</h4>
                        <p>Cảm ơn bạn đã quan tâm đến cửa hàng. Nếu bạn cần giúp đỡ hay góp ý thì đừng ngại gửi đến chúng tôi, chúng tôi sẽ xử lý sớm nhất có thể!</p>
                        <ul>
                            <li><i class="fa fa-phone"></i> <a href="#">nguyenhuudat2710@gmail.com</a></li>
                            <li><i class="fa fa-envelope-o"></i>0397399210</li>
                        </ul>             
                    </div> 
                </div>
                <div class="col-lg-6 col-md-12">
                   <div class="contact_message form">
                        <form id="contact-form" method="POST" action="/contact/support">
                            <p>  
                               <label>Họ và tên</label>
                                <input name="name" placeholder="Họ và tên..." required type="text">
                            </p>
                            <p>       
                               <label>Email liên hệ</label>
                                <input name="email" placeholder="Email..." required type="email">
                            </p>
                            <p>          
                               <label>Tiêu đề</label>
                                <input name="subject" placeholder="Tiêu đề..." required type="text">
                            </p>    
                            <div class="contact_textarea">
                                <label>Nội dung</label>
                                <textarea placeholder="Nội dung..." name="message" required  class="form-control2" ></textarea>
                            </div>   
                            <button type="submit">Gửi</button>
                        </form>

                    </div> 
                </div>
            </div>
        </div>    
    </div>
    </div>
    <!--contact area end-->

        <jsp:include page="footer.jsp" />
    <!-- JS
    ============================================ -->




<!-- Plugins JS -->
<script src="assets/js/plugins.js"></script>

<!-- Main JS -->
<script src="assets/js/main.js"></script>



</body>

</html>