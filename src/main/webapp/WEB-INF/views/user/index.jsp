<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>

<!doctype html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Reid Store</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>


    <!-- CSS
    ========================= -->



    <!-- Plugins CSS -->
    <link rel="stylesheet" href="../assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="../assets/css/style.css">

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
        .banner_thumb{
            padding: 9px;
        }
    </style>

</head>

<body>

<jsp:include page="header.jsp" />


<!--slider area start-->
<div class="slider_area slider_style home_three_slider owl-carousel">
    <div class="single_slider" data-bgimg="/assets/img/slider/1248.jpg">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                </div>
            </div>
        </div>
    </div>
    <div class="single_slider" data-bgimg="/assets/img/slider/1246.jpg">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                </div>
            </div>
        </div>
    </div>
    <div class="single_slider" data-bgimg="/assets/img/slider/1333.jpg">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                </div>
            </div>
        </div>
    </div>
</div>
<!--slider area end-->

<!--product section area start-->
<section class="product_section womens_product">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section_title" style="margin-bottom: 0px">
                    <h2>Sản phẩm bán chạy</h2>
                </div>
            </div>
        </div>
        <div class="product_area">
            <div class="row">
                <div class="col-12">
                    <div class="product_tab_button">
                        <ul class="nav" role="tablist">
                            <li>
                                <a class="active" data-toggle="tab" href="#byAll" role="tab"  aria-selected="true">Tất cả</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#byYear" role="tab"  aria-selected="true">Năm</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#byMonth" role="tab"  aria-selected="true">Tháng</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#byWeek" role="tab"  aria-selected="true">Tuần</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="byAll" role="tabpanel">
                    <div class="product_container">
                        <div class="row product_column4">
                            <c:forEach items="${productSoldAll}" var="product">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <c:if test="${product.images.size()>0}">
                                                <a class="primary_img" href="/product?id=${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                            </c:if>
                                            <c:if test="${product.images.size()>1}">
                                                <a class="secondary_img" href="/product?id=${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                            </c:if>

                                            <div class="quick_button">
                                                <a href="/product?id=${product.id}" title="quick_view">Xem sản phẩm</a>
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
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="byYear" role="tabpanel">
                    <div class="product_container">
                        <div class="row product_column4">
                            <c:forEach items="${productSoldOfYear}" var="product">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <c:if test="${product.images.size()>0}">
                                                <a class="primary_img" href="/product?id=${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                            </c:if>
                                            <c:if test="${product.images.size()>1}">
                                                <a class="secondary_img" href="/product?id=${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                            </c:if>

                                            <div class="quick_button">
                                                <a href="/product?id=${product.id}" title="quick_view">Xem sản phẩm</a>
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
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="byMonth" role="tabpanel">
                    <div class="product_container">
                        <div class="row product_column4">
                            <c:forEach items="${productSoldOfMonth}" var="product">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <c:if test="${product.images.size()>0}">
                                                <a class="primary_img" href="/product?id=${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                            </c:if>
                                            <c:if test="${product.images.size()>1}">
                                                <a class="secondary_img" href="/product?id=${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                            </c:if>

                                            <div class="quick_button">
                                                <a href="/product?id=${product.id}" title="quick_view">Xem sản phẩm</a>
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
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="byWeek" role="tabpanel">
                    <div class="product_container">
                        <div class="row product_column4">
                            <c:forEach items="${productSoldOfWeek}" var="product">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <c:if test="${product.images.size()>0}">
                                                <a class="primary_img" href="/product?id=${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                            </c:if>
                                            <c:if test="${product.images.size()>1}">
                                                <a class="secondary_img" href="/product?id=${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                            </c:if>

                                            <div class="quick_button">
                                                <a href="/product?id=${product.id}" title="quick_view">Xem sản phẩm</a>
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
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>
<!--product section area end-->

<!--product section area start-->
<section class="product_section womens_product bottom" id="recommend" style="display: none">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section_title">
                    <h2>Sản phẩm đề xuất</h2>
                    <p>Dựa theo sở thích của bạn</p>
                </div>
            </div>
        </div>
        <div class="product_area">
            <div class="row">
                <div class="product_carousel product_three_column4 owl-carousel">
                    <c:forEach items="${productRecommend}" var="product">
                        <div class="col-lg-3">
                            <div class="single_product">
                                <div class="product_thumb">
                                    <c:if test="${product.images.size()>0}">
                                        <a class="primary_img" href="/product?id=${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                    </c:if>
                                    <c:if test="${product.images.size()>1}">
                                        <a class="secondary_img" href="/product?id=${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                    </c:if>

                                    <div class="quick_button">
                                        <a href="/product?id=${product.id}" title="quick_view">Xem sản phẩm</a>
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
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>
</section>
<!--product section area end-->

<!--banner area start-->
<section class="banner_section banner_section_three">
    <div class="container-fluid">
        <div class="row ">
            <div class="col-lg-6 col-md-6">
                <div class="banner_area" style="height: 100%">
                    <div class="banner_thumb" style="height: 100%">
                        <a><img src="../assets/img/bg/shoes-banner.jpg" alt="#" style="width: 100%; height: 100%"></a>
                        <div class="banner_content">
                            <h1>Adidas <br> Men’s Collection</h1>
                            <a href="/blogs/size/detail/2">Discover Now</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="banner_area">
                    <div class="banner_thumb">
                        <a><img src="../assets/img/bg/banner12.jpg" alt="#"></a>
                        <div class="banner_content">
                            <h1>Balenciaga <br> Men’s Collection</h1>
                            <a href="/blogs/size/detail/2">Discover Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--banner area end-->

<jsp:include page="footer.jsp"/>
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
                                            <a href="#"><img src="../assets/img/product/product4.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab2" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../assets/img/product/product6.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab3" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../assets/img/product/product8.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab4" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../assets/img/product/product2.jpg" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="tab5" role="tabpanel">
                                        <div class="modal_tab_img">
                                            <a href="#"><img src="../assets/img/product/product12.jpg" alt=""></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal_tab_button">
                                    <ul class="nav product_navactive owl-carousel" role="tablist">
                                        <li >
                                            <a class="nav-link active" data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="false"><img src="../assets/img/s-product/product3.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab2" role="tab" aria-controls="tab2" aria-selected="false"><img src="../assets/img/s-product/product.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link button_three" data-toggle="tab" href="#tab3" role="tab" aria-controls="tab3" aria-selected="false"><img src="../assets/img/s-product/product2.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab4" role="tab" aria-controls="tab4" aria-selected="false"><img src="../assets/img/s-product/product4.jpg" alt=""></a>
                                        </li>
                                        <li>
                                            <a class="nav-link" data-toggle="tab" href="#tab5" role="tab" aria-controls="tab5" aria-selected="false"><img src="../assets/img/s-product/product5.jpg" alt=""></a>
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
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>

<script>
    window.addEventListener('load',function (){
        var recommend = document.getElementById("recommend");
        if(recommend.querySelectorAll('.single_product').length>0)
            recommend.style.display = 'block';
    });
</script>


</body>

</html>