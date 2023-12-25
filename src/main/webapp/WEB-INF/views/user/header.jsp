<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>

<!-- Main Wrapper Start -->
<!--Offcanvas menu area start-->
<div class="off_canvars_overlay">

</div>
<div class="offcanvas_menu">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="canvas_open">
                    <a href="javascript:void(0)"><i class="ion-navicon"></i></a>
                </div>
                <div class="offcanvas_menu_wrapper">
                    <div class="canvas_close">
                        <a href="javascript:void(0)"><i class="ion-android-close"></i></a>
                    </div>
                    <div class="welcome_text">
                        <ul>
                            <li><span>Free Delivery:</span> Take advantage of our time to save event</li>
                            <li><span>Free Returns *</span> Satisfaction guaranteed</li>
                        </ul>
                    </div>

                    <div class="top_right">
                        <ul>
                            <li class="top_links"><a href="#">My Account <i class="ion-chevron-down"></i></a>
                                <ul class="dropdown_links">
                                    <li><a href="wishlist.html">My Wish List </a></li>
                                    <li><a href="my-account.html">My Account </a></li>
                                    <li><a href="#">Sign In</a></li>
                                    <li><a href="compare.html">Compare Products  </a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="search_bar">
                        <form action="javascript:search()">
                            <input placeholder="Search entire store here..." type="text" >
                            <button type="submit"><i class="ion-ios-search-strong"></i></button>
                        </form>
                    </div>
                    <div class="cart_area">
                        <div class="middel_links">
                            <ul>
                                <li><a href="login.html">Login</a></li>
                                <li>/</li>
                                <li><a href="login.html">Register</a></li>
                            </ul>

                        </div>
                        <div  class="cart_link">
                            <a href="/cart" style="display: flex"><i class="fa fa-shopping-basket"><span style="margin-left: 3px" id="cart_link"></span></i></a>
                        </div>
                    </div>
                    <div class="contact_phone">
                        <p>Call Free Support: <a href="tel:+(012)800456789">(+012) 800 456 789 </a></p>
                    </div>
                    <div id="menu" class="text-left ">
                        <ul class="offcanvas_main_menu">
                            <li class="menu-item-has-children active">
                                <a href="#">Home</a>
                                <ul class="sub-menu">
                                    <li><a href="index.html">Home 1</a></li>
                                    <li><a href="index-2.html">Home 2</a></li>
                                    <li><a href="index-3.html">Home 3</a></li>
                                    <li><a href="index-4.html">Home 4</a></li>
                                    <li><a href="index-5.html">Home 5</a></li>
                                    <li><a href="index-6.html">Home 6</a></li>
                                    <li><a href="index-7.html">Home 7</a></li>
                                    <li><a href="index-8.html">Home 8</a></li>
                                    <li><a href="index-9.html">Home 9</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Shop</a>
                                <ul class="sub-menu">
                                    <li class="menu-item-has-children">
                                        <a href="#">Shop Layouts</a>
                                        <ul class="sub-menu">
                                            <li><a href="shop.html">shop</a></li>
                                            <li><a href="shop-fullwidth.html">Full Width</a></li>
                                            <li><a href="shop-fullwidth-list.html">Full Width list</a></li>
                                            <li><a href="shop-right-sidebar.html">Right Sidebar </a></li>
                                            <li><a href="shop-right-sidebar-list.html"> Right Sidebar list</a></li>
                                            <li><a href="shop-list.html">List View</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children">
                                        <a href="#">other Pages</a>
                                        <ul class="sub-menu">
                                            <li><a href="portfolio.html">portfolio</a></li>
                                            <li><a href="portfolio-details.html">portfolio details</a></li>
                                            <li><a href="cart.html">cart</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="my-account.html">my account</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children">
                                        <a href="#">Product Types</a>
                                        <ul class="sub-menu">
                                            <li><a href="product-details.html">product details</a></li>
                                            <li><a href="product-sidebar.html">product sidebar</a></li>
                                            <li><a href="product-grouped.html">product grouped</a></li>
                                            <li><a href="variable-product.html">product variable</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">blog</a>
                                <ul class="sub-menu">
                                    <li><a href="blog.html">blog</a></li>
                                    <li><a href="blog-details.html">blog details</a></li>
                                    <li><a href="blog-sidebar.html">blog  Sidebar</a></li>
                                    <li><a href="blog-fullwidth.html">blog fullwidth</a></li>
                                </ul>

                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">pages </a>
                                <ul class="sub-menu">
                                    <li><a href="about.html">About Us</a></li>
                                    <li><a href="services.html">services</a></li>
                                    <li><a href="faq.html">Frequently Questions</a></li>
                                    <li><a href="contact.html">contact</a></li>
                                    <li><a href="login.html">login</a></li>
                                    <li><a href="wishlist.html">Wishlist</a></li>
                                    <li><a href="404.html">Error 404</a></li>
                                    <li><a href="compare.html">compare</a></li>
                                    <li><a href="privacy-policy.html">privacy policy</a></li>
                                    <li><a href="coming-soon.html">coming soon</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="my-account.html">my account</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="about.html">About Us</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="contact.html"> Contact Us</a>
                            </li>
                        </ul>
                    </div>
                    <div class="offcanvas_footer">
                        <span><a href="#"><i class="fa fa-envelope-o"></i> info@yourdomain.com</a></span>
                        <ul>
                            <li class="facebook"><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li class="twitter"><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li class="pinterest"><a href="#"><i class="fa fa-pinterest-p"></i></a></li>
                            <li class="google-plus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                            <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--Offcanvas menu area end-->

<!--header area start-->
<header class="header_area header_three">
    <!--header top start-->
    <div class="header_top">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-lg-7 col-md-12">
                </div>
                <div class="col-lg-5 col-md-12">
                    <div class="top_right text-right" id="account">

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--header top start-->

    <!--header middel start-->
    <div class="header_middel">
        <div class="container-fluid">
            <div class="middel_inner">
                <div class="row align-items-center">
                    <div class="col-lg-4">
                        <div class="search_bar">
                            <form action="javascript:search()">
                                <input placeholder="Search entire store here..." type="text" id="searchName">
                                <button type="submit"><i class="ion-ios-search-strong"></i></button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="logo">
                            <a href="index.jsp"><img src="<c:url value="/assets/img/logo/logo.png" />" ></a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="cart_area">
                            <div  class="cart_link">
                                <a href="/cart" ><i class="fa fa-shopping-basket"><span style="margin-left: 3px" id="cart_link2"></span></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!--header middel end-->

    <!--header bottom satrt-->
    <div class="header_bottom sticky-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="main_menu_inner">
                        <div class="main_menu">
                            <nav>
                                <ul>
                                    <li class="active"><a href="<c:url value="/"/>">Trang chủ </a></li>
                                    <li><a href="<c:url value="/shop"/>">Sản phẩm</a></li>
                                    <li><a href="#">Về chúng tôi<i class="fa fa-angle-down"></i></a>
                                        <ul class="sub_menu pages">
                                            <li><a href="about.html">About Us</a></li>
                                            <li><a href="services.html">services</a></li>
                                            <li><a href="faq.html">Frequently Questions</a></li>
                                            <li><a href="login.jsp">login</a></li>
                                            <li><a href="my-account.html">my account</a></li>
                                            <li><a href="wishlist.html">Wishlist</a></li>
                                            <li><a href="404.html">Error 404</a></li>
                                            <li><a href="compare.html">compare</a></li>
                                            <li><a href="privacy-policy.html">privacy policy</a></li>
                                            <li><a href="coming-soon.html">coming soon</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="blog.html">Sự kiện</a></li>

                                    <li><a href="contact.html">Liên hệ</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--header bottom end-->
</header>
<!--header area end-->
<script>
    function  reloadCartLength(){
        let cart = [];
        let storage = localStorage.getItem('cart');
        if (storage)
            cart = JSON.parse(storage);

        document.getElementById("cart_link").textContent = cart.length.toString();
        document.getElementById("cart_link2").textContent = cart.length.toString();
    }
    function search(){
        window.location.href = "/shop/search?query="+document.getElementById("searchName").value;
    }
    function resetActive(){
        var li  = document.querySelectorAll('.main_menu nav ul .active');
        li.forEach(function (box) {
            box.classList.remove("active");
        });
        console.log(li);
        li  = document.querySelectorAll('.main_menu nav ul li');
        console.log(li);
        if(window.location.href.includes("shop")){
            li[1].classList.add('active');
        }
        else li[0].classList.add('active');
    }

    // Hàm để lấy giá trị của một cookie
    function getCookie(name) {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.startsWith(name + '=')) {
                return cookie.substring(name.length + 1);
            }
        }
        return null;
    }
    function checkAccount(){
        var login = getCookie("isLogin");
        var showAccount = document.getElementById("account");
        if(login!=null)
        {
            var ul = document.createElement('ul');
            showAccount.append(ul);
            showAccount.querySelector('ul').innerHTML = '<li class="top_links"><a href="#">My Account <i class="ion-chevron-down"></i></a>\n' +
                '                        <ul class="dropdown_links">\n' +
                '                            <li><a id="logout" href="/logout?back=/">Đăng xuất</a></li>\n' +
                '                            <li><a href="my-account.html">My Account </a></li>\n' +
                '                            <li><a href="#">Sign In</a></li>\n' +
                '                            <li><a href="compare.html">Compare Products  </a></li>\n' +
                '                        </ul>\n' +
                '                    </li>';
            document.getElementById('logout').href = "/reset?back="+window.location.pathname;

        }
        else {
            var link = document.createElement('a')
            link.href = '/sign-in-up';
            link.textContent = 'Sign In';
            showAccount.append(link);
        }
    }

    reloadCartLength();
    resetActive();
    checkAccount();
</script>