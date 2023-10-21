<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>



<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Reid Store</title>
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
</head>

<body>
    <%--Header    --%>
    <jsp:include page="header.jsp" />
 
    <!--breadcrumbs area start-->
    <div class="breadcrumbs_area other_bread">
        <div class="container">   
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb_content">
                        <ul>
                            <li><a href="index.jsp">home</a></li>
                            <li>/</li>
                            <li>about us</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>         
    </div>
    <!--breadcrumbs area end-->
    
        <!--about section area -->
    <div class="about_section">
        <div class="container">  
            <div class="row">
                <div class="col-lg-6 col-md-12">
                    <div class="about_content">
                        <h1>Welcome To Reid Store!</h1>
                        <p> Quibusdam perspiciatis pariatur magnam ducimus excepturi error libero provident animi laboriosam maiores ad explicabo ea laudantium nostrum dolor distinctio, quas fugiat doloribus, sit, possimus obcaecati ab quo vel commodi eum. Laudantium libero, voluptate rerum sunt hic,</p>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse numquam blanditiis quos, fuga, aspernatur doloribus expedita, soluta dolore cumque.</p>
                        <div class="view__work">
                            <a href="#">view work </a>
                        </div>  
                    </div>
                </div>
                <div class="col-lg-6 col-md-12">
                    <div class="about_thumb">
                        <img src="assets/img/about/about1.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>     
    </div>
    <!--about section end-->


    <!--counterup area -->
    <div class="counterup_section">
        <div class="container">   
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single_counterup">
                       <div class="counter_img">
                            <img src="assets/img/about/count.png" alt="">
                        </div>
                        <div class="counter_info">
                            <h2 class="counter_number">2170</h2>
                            <p>happy customers</p>
                        </div>
                    </div>
                </div>
                 <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single_counterup count-two">
                        <div class="counter_img">
                            <img src="assets/img/about/count2.png" alt="">
                        </div>
                        <div class="counter_info">
                            <h2 class="counter_number">8080</h2>
                            <p>AWARDS won</p>
                        </div>
                    </div>
                </div>
                 <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single_counterup">
                        <div class="counter_img">
                            <img src="assets/img/about/count3.png" alt="">
                        </div>
                        <div class="counter_info">
                            <h2 class="counter_number">2150</h2>
                            <p>HOURS WORKED</p>
                        </div>
                    </div>
                </div>
                 <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="single_counterup count-two">
                        <div class="counter_img">
                            <img src="assets/img/about/count4.png" alt="">
                        </div>
                        <div class="counter_info">
                            <h2 class="counter_number">2170</h2>
                            <p>COMPLETE PROJECTS</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
    </div>
    <!--counterup end-->

    <!--about progress bar -->
    <div class="about_progressbar">
        <div class="container">   
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6">
                    <div class="progressbar_inner">
                       <h2>We have Skills to show</h2>
                        <div class="progress_skill one">
                            <div class="progress">
                                <div class="progress-bar about_prog wow fadeInLeft" data-wow-duration="0.8s" data-wow-delay=".3s" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    <span class="progress_persent">html/css</span>    
                                </div>
                            </div>
                            <span class="progress_discount">60%</span>
                        </div>
                        <div class="progress_skill two">
                            <div class="progress">
                                <div class="progress-bar about_prog wow fadeInLeft" data-wow-duration="0.8s" data-wow-delay=".5s" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">

                                    <span class="progress_persent">ecommerce theme </span>
                                </div>

                            </div>
                             <span class="progress_discount">90%</span>
                        </div> 
                        <div class="progress_skill three">
                            <div class="progress">
                                <div class="progress-bar about_prog wow fadeInLeft" data-wow-duration="0.8s" data-wow-delay=".7s" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">

                                    <span class="progress_persent">Typhography </span>
                                </div>

                            </div>
                             <span class="progress_discount">70%</span>
                        </div> 
                         <div class="progress_skill four">
                            <div class="progress">
                                <div class="progress-bar about_prog wow fadeInLeft" data-wow-duration="0.8s" data-wow-delay=".7s" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">

                                    <span class="progress_persent">Branding  </span>
                                </div>

                            </div>
                             <span class="progress_discount">80%</span>
                        </div> 
                    </div>           
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="about__img">
                        <img src="assets/img/about/about2.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>    
    </div>
    <!--about progress bar end -->
    
    
       <!--footer area start-->
    <footer class="footer_widgets other_widgets">
        <div class="footer_top">
            <div class="container">
                <div class="footer_top_inner">  
                    <div class="row">
                        <div class="col-lg-2 col-md-6 col-sm-6 col-6">
                            <div class="widgets_container">
                                <h3>Information</h3>
                                <div class="footer_menu">
                                    <ul>
                                        <li><a href="about.html">About Us</a></li>
                                        <li><a href="#">Delivery Information</a></li>
                                        <li><a href="privacy-policy.html">Privacy Policy</a></li>
                                        <li><a href="#">Terms & Conditions</a></li>
                                        <li><a href="contact.jsp">Contact Us</a></li>
                                        <li><a href="#">Returns</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-6 col-sm-6 col-6">
                            <div class="widgets_container">
                                <h3>Extras</h3>
                                <div class="footer_menu">
                                    <ul>
                                        <li><a href="#">Brands</a></li>
                                        <li><a href="#">Gift Certificates</a></li>
                                        <li><a href="#">Affiliate</a></li>
                                        <li><a href="#">Specials</a></li>
                                        <li><a href="contact.jsp">Site Map</a></li>
                                        <li><a href="my-account.html">My Account</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="widgets_container contact_us">
                                <h3>Contact Us</h3>
                                <div class="footer_contact">
                                    <p>Address: 6688 Princess Road, London, Greater London BAS 23JK, UK</p>
                                    <p>Phone: <a href="tel:+(+012)800456789-987">(+012) 800 456 789 - 987</a> </p>
                                    <p>Email: demo@example.com</p>
                                    <ul>
                                        <li><a href="#" title="Twitter"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" title="google-plus"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="#" title="facebook"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" title="youtube"><i class="fa fa-youtube"></i></a></li>
                                    </ul>

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="widgets_container newsletter">
                                <h3>Join Our Newsletter Now</h3>
                                <div class="newleter-content">
                                    <p>Exceptional quality. Ethical factories. Sign up to enjoy free U.S. shipping and returns on your first order.</p>
                                    <div class="subscribe_form">
                                        <form id="mc-form" class="mc-form footer-newsletter" >
                                            <input id="mc-email" type="email" autocomplete="off" placeholder="Enter you email address here..." />
                                            <button id="mc-submit">Subscribe !</button>
                                        </form>
                                        <!-- mailchimp-alerts Start -->
                                        <div class="mailchimp-alerts text-centre">
                                            <div class="mailchimp-submitting"></div><!-- mailchimp-submitting end -->
                                            <div class="mailchimp-success"></div><!-- mailchimp-success end -->
                                            <div class="mailchimp-error"></div><!-- mailchimp-error end -->
                                        </div><!-- mailchimp-alerts end -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>     
            </div>
        </div>
        <div class="footer_bottom">
            <div class="container">
               <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="copyright_area">
                            <p> &copy; 2021 <strong> </strong> Mede with ❤️ by <a href="https://hasthemes.com/" target="_blank"><strong>HasThemes</strong></a></p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="footer_custom_links">
                            <ul>
                                <li><a href="#">Order History</a></li>
                                <li><a href="wishlist.html">Wish List</a></li>
                                <li><a href="#">Newsletter</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!--footer area end-->


<!-- JS
============================================ -->

<!-- Plugins JS -->
<script src="assets/js/plugins.js"></script>

<!-- Main JS -->
<script src="assets/js/main.js"></script>



</body>

</html>