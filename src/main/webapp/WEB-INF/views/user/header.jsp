<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>
<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>


<df-messenger
        intent="WELCOME"
        chat-title="ChatBot"
        agent-id="d3acc877-6758-47ca-bac6-10f42e0ebe5c"
        language-code="vi-vn"
></df-messenger>
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
    #mini_favorite{
        max-height: 400px; /* Giới hạn chiều cao của danh sách */
        overflow-y: auto; /* Tạo ra thanh cuộn khi nội dung vượt quá chiều cao */
    }
    #mini_favorite .cart_remove{
        margin-right: 15px;
    }
    #autocomplete-list li {
        padding: 8px;
        cursor: pointer;
        background-color: #f9f9f9;
    }

    #autocomplete-list li:hover {
        background-color: #ddd;
    }
    .mini_cart .cart_info a{
        color: black;
        font-weight: 500;
    }
    .mini_cart .cart_info a:hover{
        color: #ff6a28;
    }
    .mini_cart .cart_info span{
        color: red;
    }
    .listFavorite li:focus{
        outline: none!important;
    }
    .listFavorite li:hover{
        background: #ff6a28;
        color: #ffffff;
    }
    .listFavorite .active{
        background: #ff6a28;
        color: #ffffff;
    }
    .mini_cart .pagination{
        margin-top: 10px;
    }
    .mini_cart{
        padding: 25px 20px 10px;
    }
    .widget-visible iframe{
        right: 15px !important;
        bottom: 90px !important;
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
                            <a href="/"><img src="<c:url value="/assets/img/logo/logo.png" />" ></a>
                        </div>
                    </div>

                    <div class="col-lg-4" >
                        <div class="cart_area">
                            <div  class="cart_link">
                                <a href="" ><i class="far fa-heart"></i></a>
                                <div class="mini_cart">
                                    <div id="mini_favorite"></div>
                                    <div class="pagination" >
                                        <ul class="listFavorite">
                                        </ul>
                                    </div>
                                </div>
                            </div>
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
                                    <li><a href="#">Liên hệ<i class="fa fa-angle-down"></i></a>
                                        <ul class="sub_menu pages">
                                             <li><a href="/contact/address">Cửa hàng</a></li>
                                            <li><a href="/contact">Hỗ trợ</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Chia sẻ<i class="fa fa-angle-down"></i></a>
                                        <ul class="sub_menu pages">
                                            <li><a href="/blogs?type=SIZE">Tư vấn chọn size</a></li>
                                            <li><a href="/blogs?type=TREND">Xu hướng thời trang</a></li>
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
<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>
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
    function showFavorite(){
        let favorite = [];
        let storage = localStorage.getItem('favorite');
        if(storage!=null)
        {
            favorite= JSON.parse(storage);
            $.ajax({
                url: '/shop/favorite',
                type: "post",
                data: JSON.stringify(favorite),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    document.getElementById("mini_favorite").innerHTML=response;
                    listFavorite = document.querySelectorAll('.favorites-item');
                    loadFavorites();
                }
            });
        }
    }
    function deleteItemFavorites(id){
        let favorite = [];
        let storage = localStorage.getItem('favorite');
        if (storage!=null){
            favorite= JSON.parse(storage);
            var indexToRemove = favorite.indexOf(id);

            // Nếu phần tử có tồn tại trong mảng, thì loại bỏ nó
            if (indexToRemove !== -1) {
                favorite.splice(indexToRemove, 1);
            }
            localStorage.setItem('favorite', JSON.stringify(favorite));
        }
        showFavorite();

    }

    showFavorite();

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
            showAccount.querySelector('ul').innerHTML = '<li class="top_links"><a href="#">Tài khoản<i class="ion-chevron-down"></i></a>\n' +
                '                        <ul class="dropdown_links">\n' +
                '                            <li><a href="/profile">Thông tin cá nhân</a></li>\n' +
                '                            <li><a href="/orders">Đơn hàng</a></li>\n' +
                '                            <li><a id="logout" href="/logout?back=/">Đăng xuất</a></li>\n' +
                '                        </ul>\n' +
                '                    </li>';
            document.getElementById('logout').href = "/reset?back="+window.location.pathname;

        }
        else {
            var link = document.createElement('a')
            link.href = '/sign-in-up';
            link.textContent = 'Đăng nhập/Đăng ký';
            link.style.color = '#fff';
            showAccount.append(link);
        }
    }

    reloadCartLength();
    resetActive();
    checkAccount();
</script>

<script>

    // Xử lý phân trang
    let thisPageFavorite = 1;
    let limitFavorite = 5;
    let listFavorite = document.querySelectorAll('.favorites-item');

    function changeFavorites(i) {
        thisPageFavorite = i;
        loadFavorites();
    }

    function loadFavorites() {
        let beginGet = limitFavorite * (thisPageFavorite - 1);
        let endGet = limitFavorite * thisPageFavorite - 1;
        listFavorite.forEach((item, key) => {
            if (key >= beginGet && key <= endGet) {
                item.style.display = 'flex';
            } else {
                item.style.display = 'none';
            }
        })
        listPageFavorite();
    }


    function listPageFavorite() {
        let count = Math.ceil(listFavorite.length / limitFavorite);
        document.querySelector('.listFavorite').innerHTML = '';

        if (thisPageFavorite != 1) {
            let prev = document.createElement('li');
            let icon = document.createElement('i');
            icon.classList.add('fas', 'fa-angle-double-left');
            prev.appendChild(icon);
            prev.setAttribute('onclick', "changeFavorites(" + (thisPageFavorite - 1) + ")");
            document.querySelector('.listFavorite').appendChild(prev);
        }

        for (i = 1; i <= count; i++) {
            let newPage = document.createElement('li');
            newPage.innerText = i;
            if (i == thisPageFavorite) {
                newPage.classList.add('active');
            }
            newPage.setAttribute('onclick', "changeFavorites(" + i + ")");
            document.querySelector('.listFavorite').appendChild(newPage);
        }

        if (thisPageFavorite != count) {
            let next = document.createElement('li');
            let icon = document.createElement('i');
            icon.classList.add('fas', 'fa-angle-double-right');
            next.appendChild(icon);
            next.setAttribute('onclick', "changeFavorites(" + (thisPageFavorite + 1) + ")");
            document.querySelector('.listFavorite').appendChild(next);
        }
    }
    document.addEventListener("DOMContentLoaded", function () {
        listFavorite = document.querySelectorAll('.favorites-item');
        loadFavorites();

        const dfMessenger = document.querySelector( 'df-messenger' );
        if( dfMessenger )
        {
            dfMessenger.addEventListener( 'df-messenger-loaded', function( event )
            {
                var sheet = new CSSStyleSheet;
                // CUSTOMIZE THE DIALOGUE WINDOW
                $(this.shadowRoot.querySelector( '.df-messenger-wrapper' ).style.bottom = "80px");
                $r1 = document.querySelector("df-messenger");
                sheet.replaceSync( `button#widgetIcon { bottom: 15px; right: 5px; width:60px; height:60px;} button#widgetIcon .df-chat-icon{left: 12px;top: 12px;} button#widgetIcon div #closeSvg{left:18px; top:18px;}`);
                $r1.shadowRoot.adoptedStyleSheets = [ sheet ];
                $r2 = $r1.shadowRoot.querySelector("df-messenger-chat");
                sheet = new CSSStyleSheet;
                sheet.replaceSync( `div.chat-wrapper { bottom: 160px;} div.chat-min{bottom: 100px !important;} div.chat-wrapper[opened="true"]{height: 480px;}`);
                $r2.shadowRoot.adoptedStyleSheets = [ sheet ];

                // event.preventDefault();
            });



        }
    });


</script>
<!--Start of Tawk.to Script-->
<script type="text/javascript">
    var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
    (function(){
        var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
        s1.async=true;
        s1.src='https://embed.tawk.to/65fee6271ec1082f04da6dec/1hplr63l3';
        s1.charset='UTF-8';
        s1.setAttribute('crossorigin','*');
        s0.parentNode.insertBefore(s1,s0);

    })();
</script>
<!--End of Tawk.to Script-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>


</script>