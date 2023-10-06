<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Shop</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="../../assets/img/favicon.ico">

    <!-- CSS
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="../../assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="../../assets/css/style.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

    <script type="text/javascript">
        function Sort(type){
            var option = type.value;
            $.ajax({
                url: location.href+"/sort/"+option,
                type: "get",
                success: function (data){
                    displayProduct(data);
                }

            });
        }



        function displayProduct(products){
            let result = '';
            for(let i =0;i<products.length;i++){
                result += '<div class="col-lg-4 col-md-4 col-12 item">'
                    + ' <div class="single_product">'
                    + '<div class="product_thumb">';
                if(products[i].images.length>0)
                    result += '<a class="primary_img" href="product-details.html"><img src=' +
                        products[i].images[0].img +
                        ' alt=""></a>';
                if(products[i].images.length>1)
                    result += '<a class="secondary_img" href="product-details.html"><img src='
                        + products[i].images[1].img
                        + ' alt=""></a>';
                result+=' <div class="quick_button">'
                    +'<a href="product-details.html"title="quick_view">Xem sản phẩm</a>'
                    +'</div>'
                    +'   <div class="product_sale">'
                    +'       <span>';
                if(products[i].promotion>0)
                    result+='-'+products[i].promotion +'%';
                result+= '</span></div>'
                    +'</div>'
                    +'<div class="product_content grid_content">'
                    +'<h3><a href="product-details.html">'
                    + products[i].name +'</a></h3>';
                + '<span class="current_price">'
                var old_price = products[i].price;
                old_price = old_price.toLocaleString('vi-VN', {style : 'currency', currency : 'VND'});
                if(products[i].promotion>0)
                {
                    var price = products[i].price*(1-products[i].promotion/100);
                    price = price.toLocaleString('vi-VN', {style : 'currency', currency : 'VND'});
                    result+=price+'</span>'
                        +'<span class="old_price">'
                        +old_price
                        +'</span>' +' </div>';

                }
                else {
                    result+=old_price+'</span>' +' </div>';
                }


                result+='   <div class="product_content list_content">'
                    +'<h3><a href="product-details.html">'
                    +products[i].name+'</a></h3>'
                    +'   <div class="product_ratting">'
                    +'       <ul>'
                    +'           <li><a href="#"><i class="fa fa-star"></i></a></li>'
                    +'           <li><a href="#"><i class="fa fa-star"></i></a></li>'
                    +'          <li><a href="#"><i class="fa fa-star"></i></a></li>'
                    +'        <li><a href="#"><i class="fa fa-star"></i></a></li>'
                    +'        <li><a href="#"><i class="fa fa-star"></i></a></li>'
                    +'   </ul>'
                    +'</div>'
                    +'<div class="product_price">'
                    +'<span class="current_price">';
                if(products[i].promotion>0)
                {
                    var price = products[i].price*(1-products[i].promotion/100);
                    price = price.toLocaleString('en-US', {style : 'currency', currency : 'VND'});
                    result+=price+'</span>'
                        +'<span class="old_price">'
                        +old_price
                        +'</span>' +' </div>';

                }
                else {
                    result+=old_price+'</span>' +' </div>';
                }
                result+=' <div class="product_desc">' +'<p>'
                    +products[i].description+'</p>'
                    +'</div>'
                    +'</div>'
                    +'</div>'
                    +'</div>';
            }
            document.getElementById("product_content").innerHTML = result;

            reLoadItem();
        }


    </script>

    <style>
        .grid_list .product_thumb {
            margin-bottom: 0;
            min-width: 33.333333%;
            margin-right: 15px;
            width: 200px;
        }
        @media only screen and (min-width: 768px) and (max-width: 991px) {
            .grid_list .product_thumb {
                flex: 0 0 40.667%;
                min-width: 40.667%;
            }
        }
        @media only screen and (max-width: 767px) {
            .grid_list .product_thumb {
                flex: 0 0 100%;
                min-width: 100%;
                margin-right: 0;
                margin-bottom: 25px;
            }
        }
        .sidebar_widget.widget_categories ul li:focus {
            color: #ff6a28;
            font-style: oblique;
            font-size: 16px;
        }
        .ul_menu_children li{
            margin-left: 20px;

        }

        .ul_menu_children li a:hover span{
            color: #ff6a28;
        }


        .listPage li:hover{
            background: #ff6a28;
            color: #ffffff;
        }
        .listPage .active{
            background: #ff6a28;
            color: #ffffff;
        }

    </style>
</head>

<body>


<jsp:include page="header.jsp"/>

<!--breadcrumbs area start-->
<div class="breadcrumbs_area">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb_content">
                    <ul>
                        <li><a href="./index">home</a></li>
                        <c:forEach items="${categories}" var="category">
                         <li>  <a href="./${category.id}">- ${category.name}</a></li>
                        </c:forEach>
                        <li>- ${currentCategory.name}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!--breadcrumbs area end-->

<!--shop  area start-->
<div class="shop_area shop_reverse">
    <div class="container">
        <div class="shop_inner_area">
            <div class="row">
                <div class="col-lg-3 col-md-12">
                    <!--sidebar widget start-->
                    <div class="sidebar_widget">
                        <div class="widget_list widget_filter">
                            <h2>Lọc theo giá</h2>
                            <form action="javascript:Filter()">
                                <div id="slider-range"></div>
                                <button type="submit">Lọc</button>
                                <input type="text" name="productValue" id="amount" />

                            </form>
                        </div>
                        <div class="widget_list widget_categories">
                            <h2>Brand</h2>
                            <ul style="font-size: 14px" class="ul_menu">
                                <c:forEach var="category" items="${categoryRepository.findAll()}">
                                    <li><a href="./${category.id}">${category.name}<span>${productRepository.findAllByCategory(category.id).size()}</span></a>
                                        <c:if test="${categoryRepository.familyByParent(category.id).size()>0}">
                                            <ul  class="ul_menu_children">
                                                <c:forEach var="categoryChildren" items="${categoryRepository.familyByParent(category.id)}">
                                                <li><a href="./${categoryChildren.id}"><span>${categoryChildren.name}</span></a>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                    </div>
                    <!--sidebar widget end-->
                </div>
                <div class="col-lg-9 col-md-12">
                    <!--shop wrapper start-->
                    <!--shop toolbar start-->
                    <div class="shop_title">
                        <h1>${currentCategory.name}</h1>
                    </div>
                    <div class="shop_toolbar_wrapper">
                        <div class="shop_toolbar_btn">

                            <button data-role="grid_3" type="button" class="active btn-grid-3" data-toggle="tooltip" title="3"></button>

                            <button data-role="grid_list" type="button"  class="btn-list" data-toggle="tooltip" title="List"></button>

                        </div>

                        <select  class="select_option" id="select_id" onchange="Sort(this)">
                            <option value="0" selected>Sắp xếp</option>
                            <option value="1">Sản phẩm bán chạy</option>
                            <option value="2">Giá từ cao đến thấp</option>
                            <option value="3">Giá từ thấp đến cao</option>
                            <option value="4">A->Z</option>
                            <option value="5">Z->A</option>
                        </select>

                    </div>
                    <!--shop toolbar end-->

                    <div class="row shop_wrapper list" id="product_content" >
                        <c:forEach var="product" items="${products}">
                            <div class="col-lg-4 col-md-4 col-12 item" >
                                <div class="single_product">
                                    <div class="product_thumb">
                                        <c:if test="${product.images.size()>0}">
                                            <a class="primary_img" href="product-details.jsp"><img src="${product.images.get(0).img}" alt=""></a>
                                        </c:if>
                                        <c:if test="${product.images.size()>1}">
                                            <a class="secondary_img" href="product-details.jsp"><img src="${product.images.get(1).img}" alt=""></a>
                                        </c:if>

                                        <div class="quick_button">
                                            <a href="product-details.jsp" title="quick_view">Xem sản phẩm</a>
                                        </div>


                                        <div class="product_sale">
                                            <c:if test="${product.promotion>0}"><span>-${product.promotion}%</span></c:if>
                                        </div>

                                    </div>

                                    <div class="product_content grid_content" >
                                        <h3><a href="product-details.jsp">${product.name}</a></h3>
                                        <c:choose>
                                            <c:when test="${product.promotion>0}">
                                                <span class="current_price" >${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                <span class="old_price">${formatVND.format(product.price)}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="current_price">${formatVND.format(product.price)}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="product_content list_content">
                                        <h3><a href="product-details.html">${product.name}</a></h3>
                                        <div class="product_ratting">
                                            <ul>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="product_price">
                                            <c:choose>
                                                <c:when test="${product.promotion>0}">
                                                    <span class="current_price">${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                    <span class="old_price">${formatVND.format(product.price)}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="current_price">${formatVND.format(product.price)}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product_desc">
                                            <p>${product.description}</p>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <div class="shop_toolbar t_bottom">
                        <div class="pagination" >
                            <ul class="listPage">
                            </ul>
                        </div>
                    </div>
                    <!--shop toolbar end-->
                    <!--shop wrapper end-->
                </div>
            </div>
        </div>

    </div>
</div>
<!--shop  area end-->

<!--footer area start-->
<footer class="footer_widgets">
    <div class="footer_top">
        <div class="container">
            <div class="row">
                <div class="col-lg-2 col-md-6 col-sm-6 col-6">
                    <div class="widgets_container">
                        <h3>Information</h3>
                        <div class="footer_menu">
                            <ul>
                                <li><a href="about.jsp">About Us</a></li>
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

<!-- modal area start-->
<div class="modal fade" id="modal_box" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <div class="modal_body">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5 col-md-5 col-sm-12">
                            <div class="modal_tab">
                                <div class="tab-content product-details-large">
                                    <div class="tab-pane fade show active" id="tab1" role="tabpanel" >
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../../../assets/img/product/product4.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab2" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../../../assets/img/product/product6.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab3" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../../../assets/img/product/product8.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab4" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../../../assets/img/product/product2.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab5" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../../../assets/img/product/product12.jpg" alt=""></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal_tab_button">
                                    <ul class="nav product_navactive owl-carousel" role="tablist">
                                        <li >
                                            <a class="nav-link active" data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="false"><img src="../../../assets/img/s-product/product3.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab2" role="tab" aria-controls="tab2" aria-selected="false"><img src="../../../assets/img/s-product/product.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link button_three" data-toggle="tab" href="#tab3" role="tab" aria-controls="tab3" aria-selected="false"><img src="../../../assets/img/s-product/product2.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab4" role="tab" aria-controls="tab4" aria-selected="false"><img src="../../../assets/img/s-product/product4.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab5" role="tab" aria-controls="tab5" aria-selected="false"><img src="../../../assets/img/s-product/product5.jpg" alt=""></a>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-7 col-md-7 col-sm-12">
                            <div class="modal_right">
                                <div class="modal_title mb-10">
                                    <h2>Handbag feugiat</h2>
                                </div>
                                <div class="modal_price mb-10">
                                    <span class="new_price">$64.99</span>
                                    <span class="old_price" >$78.99</span>
                                </div>
                                <div class="modal_description mb-15">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia iste laborum ad impedit pariatur esse optio tempora sint ullam autem deleniti nam in quos qui nemo ipsum numquam, reiciendis maiores quidem aperiam, rerum vel recusandae </p>
                                </div>
                                <div class="variants_selects">
                                    <div class="variants_size">
                                        <h2>size</h2>
                                        <select class="select_option">
                                            <option selected value="1">s</option>
                                            <option value="1">m</option>
                                            <option value="1">l</option>
                                            <option value="1">xl</option>
                                            <option value="1">xxl</option>
                                        </select>
                                    </div>
                                    <div class="variants_color">
                                        <h2>color</h2>
                                        <select class="select_option">
                                            <option selected value="1">purple</option>
                                            <option value="1">violet</option>
                                            <option value="1">black</option>
                                            <option value="1">pink</option>
                                            <option value="1">orange</option>
                                        </select>
                                    </div>
                                    <div class="modal_add_to_cart">
                                        <form action="#">
                                            <input min="0" max="100" step="2" value="1" type="number">
                                            <button type="submit">add to cart</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="modal_social">
                                    <h2>Share this product</h2>
                                    <ul>
                                        <li class="facebook"><a href="#"><i class="fa fa-facebook"></i></a></li>
                                        <li class="twitter"><a href="#"><i class="fa fa-twitter"></i></a></li>
                                        <li class="pinterest"><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                        <li class="google-plus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                        <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- modal area start-->


<!-- JS
============================================ -->

<!-- Plugins JS -->
<script src="../../../../assets/js/plugins.js"></script>

<!-- Main JS -->
<script src="../../../../assets/js/main.js"></script>

<script>

    // Xử lý phân trang
    let thisPage = 1;
    let limit = 6;
    let list = document.querySelectorAll('.list .item');
    let listIndex = document.querySelectorAll('.list .item');
    function reLoadItem(){
        list = document.querySelectorAll('.list .item');
        loadItem();
    }
    function loadItem(){
        let beginGet = limit * (thisPage - 1);
        let endGet = limit * thisPage - 1;
        list.forEach((item, key)=>{
            if(key >= beginGet && key <= endGet){
                item.style.display = 'block';
            }else{
                item.style.display = 'none';
            }
        })
        listPage();
    }
    loadItem();
    function listPage(){
        let count = Math.ceil(list.length / limit);
        document.querySelector('.listPage').innerHTML = '';

        if(thisPage != 1){
            let prev = document.createElement('li');
            prev.innerText = '<<';
            prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
            document.querySelector('.listPage').appendChild(prev);
        }

        for(i = 1; i <= count; i++){
            let newPage = document.createElement('li');
            newPage.innerText = i;
            if(i == thisPage){
                newPage.classList.add('active');
            }
            newPage.setAttribute('onclick', "changePage(" + i + ")");
            document.querySelector('.listPage').appendChild(newPage);
        }

        if(thisPage != count){
            let next = document.createElement('li');
            next.innerText = '>>';
            next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
            document.querySelector('.listPage').appendChild(next);
        }
    }
    function changePage(i){
        thisPage = i;
        loadItem();
    }

    function resetProduct(){
        let content = document.getElementById("product_content");
        content.innerHTML='';
        listIndex.forEach((item)=>{
            content.appendChild(item);
        })
    }

    function Filter(){
        let min = $( "#slider-range" ).slider("values", 0);
        let max = $( "#slider-range" ).slider("values", 1 );

        $.ajax({
            url: location.href+"/filterPrice/"+min+"/"+max,
            type: "get",
            success: function (data){
                displayProduct(data);
            }
        });
    }


</script>

</body>

</html>