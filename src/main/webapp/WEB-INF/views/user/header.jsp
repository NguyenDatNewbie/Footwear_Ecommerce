<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>

<!-- Main Wrapper Start -->
<style>
    #autocomplete-container {
        position: relative;
        width: 100%;
        color: black;
    }
    #autocomplete-list {
        position: absolute;
        z-index: 999;
        list-style: none;
        margin-left: 16px;
        padding: 0;
        width: 335px;
        max-height: 200px; /* Giới hạn chiều cao của danh sách */
        overflow-y: auto; /* Tạo ra thanh cuộn khi nội dung vượt quá chiều cao */
        border: 1px solid #ccc;
        border-top: none;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        display: none;
    }

    #autocomplete-list li {
        padding: 8px;
        cursor: pointer;
        background-color: #f9f9f9;
    }

    #autocomplete-list li:hover {
        background-color: #ddd;
    }
</style>
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
                                <div id="autocomplete-container">
                                    <input placeholder="Tìm kiếm sản phẩm..." style="color: black;font-weight: 500;" type="text" id="searchName" autocomplete="off" oninput="getData()">
                                    <ul id="autocomplete-list"></ul>

                                </div>

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

                                    <li><a href="#">Liên hệ<i class="fa fa-angle-down"></i></a>
                                        <ul class="sub_menu pages">
                                             <li><a href="/contact/address">Cửa hàng</a></li>
                                            <li><a href="/contact">Hỗ trợ</a></li>
                                        </ul>
                                    </li>
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
<%--Get data--%>
<script>
    let arraysData = [];
    var inputElement = document.getElementById("searchName");
    var listElement = document.getElementById("autocomplete-list");
    inputElement.addEventListener("input", function () {
        getData();
        var inputValue = inputElement.value.toLowerCase();
        var matches = arraysData.filter(function (arr) {
            return arr.name.toLowerCase().includes(inputValue);
        });
        displayMatches(matches);
    });

    function displayMatches(matches) {
        const formatVND = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });
        if (matches.length === 0) {
            listElement.style.display = "none";
            return;
        }
        listElement.innerHTML = "";
        matches.forEach(function (match) {
            var listItem = document.createElement("li");
            listItem.style.cursor = "pointer"; // Add cursor style for better UX
            var a = document.createElement("a");
            a.href = match.link;
            var div = document.createElement("div");
            div.style.display = "flex";
            div.style.alignItems = "center"; // Align items vertically

            var img = document.createElement("img");
            img.src = match.img; // Set the image source
            img.style.width = "50px";

            var infoDiv = document.createElement("div");
            infoDiv.style.marginLeft = "10px"; // Add some margin between image and text

            var nameDiv = document.createElement("div");
            var spanName = document.createElement("span");
            spanName.textContent = match.name;
            nameDiv.appendChild(spanName);

            var priceDiv = document.createElement("div");
            var spanPrice = document.createElement("span");
            spanPrice.textContent = formatVND.format(parseFloat(match.price)); // Assuming match.price holds the product price
            spanPrice.style.color = "red";
            priceDiv.appendChild(spanPrice);

            if(match.price !== match.priceOrigin) {
                spanPrice.style.marginRight = "5px"
                var spanOriginalPrice = document.createElement("span");
                spanOriginalPrice.style.textDecoration ="line-through";
                spanOriginalPrice.textContent = formatVND.format(parseFloat(match.priceOrigin));; // Assuming match.originalPrice holds the original product price
                priceDiv.appendChild(spanOriginalPrice);
            }

            infoDiv.appendChild(nameDiv);
            infoDiv.appendChild(priceDiv);

            div.appendChild(img);
            div.appendChild(infoDiv);
            a.appendChild(div);
            listItem.appendChild(a);

            listElement.appendChild(listItem);
        });

        listElement.style.display = "block";
    }

    // Hide autocomplete list when clicking outside the container
    document.addEventListener("click", function (event) {
        if (!event.target.closest("#autocomplete-container")) {
            listElement.style.display = "none";
        }
    });

    function getData() {
        $.ajax({
            url: '/shop/searchList?query='+document.getElementById("searchName").value,
            type: "get",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                arraysData = response;
            }
        });
    }


</script>
<script>
    function  reloadCartLength(){
        let cart = [];
        let storage = localStorage.getItem('cart');
        if (storage)
            cart = JSON.parse(storage);

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
        li  = document.querySelectorAll('.main_menu nav ul li');
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
                '                            <li><a href="/profile">Tài khoản của tôi</a></li>\n' +
                '                            <li><a href="/orders">Đơn hàng</a></li>\n' +
                '                            <li><a id="logout" href="/logout?back=/">Đăng xuất</a></li>\n' +
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