<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/common/taglib.jsp" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Chi tiết sản phẩm</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/assets/img/favicon.ico"/>
">

    <!-- CSS 
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/plugins.css"/>">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/style.css"/>">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>


    <style>
        .box_size {
            width: 30px;
            height: 30px;
            margin: 3px;
            display: inline-block;
            text-align: center;
            line-height: 30px;
            font-size: 14px;
            font-weight: bold;
            border: 1px solid #e9ecef;
            background: #fff;
            transition: background-color 0.3s;
            cursor: pointer;
        }

        .size_product .active {
            background: #ff6a28;
            color: #ffffff;
            outline: none;
        }

        .box_size:focus {
            outline: none;
        }

        .number {
            display: flex;
        }

        span {
            cursor: pointer;
        }

        .number .minus, .number .plus {
            width: 35px;
            height: 35px;
            background: #f3f4f4;
            border-radius: 4px;
            border: solid 1px #f3f4f4;
            display: inline-block;
            vertical-align: middle;
            text-align: center;
            line-height: 35px;
            font-style: inherit;
            font-weight: bold;

        }

        .number #number_text, .number #number_text2 {
            margin: 0px;
            /*margin-right: 8px;*/
            /*margin-left: 8px;*/
            width: 35px;
            height: 35px;
            font-size: 18px;
            text-align: center;
            border: 1px solid #f3f4f40a;
            border-right: none;
            border-left: none;
            border-radius: 4px;
            display: inline-block;
            vertical-align: middle;
            font-style: inherit;
            font-weight: bold;
        }

        .product_price .old_price {
            text-decoration: line-through;
            color: #a4a4a4;
            margin-left: 5px;
        }

        #showOverlayLink {
            margin-right: 10px;
            line-height: 31px;
            font-size: 12px;
            font-style: initial;
            margin-left: 5px;
        }

        #showOverlayLink:hover {
            color: #ff6a28;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* Màu nền mờ */
            z-index: 999; /* Đảm bảo lớp đè hiển thị trên cùng */
            text-align: center;
        }

        .fa-star {
            color: #faca50;
        }

        i.fa.fa-star-half-alt {
            color: #faca50;
        }

        i.fa.fa-star-none {
            color: black;
        }
        i.fa.fa-star.o{
            color: black;
        }
        .listPage li:hover {
            background: #ff6a28;
            color: #ffffff;
        }

        .listPage .active {
            background: #ff6a28;
            color: #ffffff;
        }

        .rate_avg_star {
            display: flex;
        }

        .line_figure {
            text-align: center;
            font-size: 35px;
        }

        .rate_avg_star {
            justify-content: center;
            font-size: 18px;
        }

        .review_total {
            text-align: center;
            font-size: 16px;
        }

        .review {
            display: flex;
        }

        .review_content_item {
            width: 60%;
        }

        .review_summary {
            border: 1px solid #cccccc;
            border-radius: 8px;
            padding: 10px;
            justify-content: center;
            margin: 0 20px 20px 20px;
            height: fit-content;
        }

        .review_summary_figure {
            margin: 10px 0;
        }

        .rate_count progress {
            margin: 0 3px 0 20px;
            height: 12px;
            border-radius: 0.25rem;
        }

        .rate_count progress::-webkit-progress-bar {
            background-color: #e9ecef;

        }

        .rate_count progress::-webkit-progress-value {
            background-color: #faca50;
        }


        .hidden {
            display: none;
        }

        .success {
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            font-family: "Emoji";
            animation: slideIn 0.5s, slideOut 0.5s 1.5s forwards;
        }

        .warning {
            font-size: 16px;
            background-color: #FFD65F;
            color: white;
            border: 3px solid #FEC212;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            font-family: "Emoji";
            animation: slideIn 0.5s, slideOut 0.5s 1.5s forwards;
        }

        .success i {
            margin-right: 5px; /* Khoảng cách giữa biểu tượng và văn bản */
        }


        @keyframes slideIn {
            from {
                top: -50px;
                opacity: 0;
            }
            to {
                top: 10px;
                opacity: 1;
            }
        }

        @keyframes slideOut {
            from {
                top: 10px;
                opacity: 1;
            }
            to {
                top: -50px;
                opacity: 0;
            }
        }
    </style>

</head>

<body>

<!-- Lớp đè -->
<div class="overlay" id="overlay">
    <div class="overlay-content" style="margin-top: 20px; display: inline-block;">
        <h2 style="color: #fff">Bảng quy đổi size</h2>
        <img style="width: 700px; height: 600px;"
             src="https://www.gento.vn/wp-content/uploads/2022/05/bang-size-giay-nike-nam-e1654001239325.jpg"/>
    </div>
</div>

<jsp:include page="header.jsp"/>

<div id="messageBox" class="hidden success">

</div>

<!--product details start-->
<div class="product_details" style="margin-top: 20px">
    <div class="container">
        <div class="row">
            <div class="col-lg-5 col-md-5">
                <div class="product-details-tab">
                    <div id="img-1" class="zoomWrapper single-zoom">
                        <img id="zoom1" src="${productCurrent.images.get(0).img}"
                             data-zoom-image="${productCurrent.images.get(0).img}"
                             alt="big-1">
                    </div>

                    <div class="single-zoom-thumb">
                        <ul class="s-tab-zoom owl-carousel single-product-active"
                            id="gallery_01">
                            <c:forEach items="${productCurrent.images}"
                                       var="img">
                                <li><a href="#" class="elevatezoom-gallery active"
                                       data-update="" data-image="${img.img}"
                                       data-zoom-image="${img.img}"> <img src="${img.img}"
                                                                          alt="zo-th-1"/>
                                </a></li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 col-md-7">
                <div class="product_d_right">
                    <form action="javascript:addToCart(${productCurrent.id})">

                        <h1 style="margin-bottom: 0px">${productCurrent.name}</h1>
                        <c:if test="${evaluateList.size()>0}">
                            <div class=" product_ratting" style="margin-bottom: 0px">
                                <ul>
                                    <c:forEach items="${evaluateService.rateStar(evaluateService.avg(evaluateList))}" var="star">
                                        <c:choose>
                                            <c:when test="${star==1}">
                                                <li><i class="fa fa-star"></i></li>
                                            </c:when>
                                            <c:when test="${star==0}">
                                                <li><i class="far fa-star"></i></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><i class="fa fa-star-half-alt "></i></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="review">(${evaluateList.size()} đánh giá)</li>

                                </ul>
                            </div>
                        </c:if>

                        <div class="product_price">
                            <c:choose>
                                <c:when test="${productCurrent.promotion>0}">
                                    <span style="color:red;"
                                          class="current_price">${formatVND.format(productCurrent.price*(1-productCurrent.promotion/100))}</span>
                                    <span class="old_price">${formatVND.format(productCurrent.price)}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:red;"
                                          class="current_price">${formatVND.format(productCurrent.price)}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="product_desc">
                            <p>${productCurrent.description}</p>
                        </div>
                        <div class="product_variant size" style="display: block; margin-bottom: 10px">
                            <div style="display: flex">
                                <h3 style="margin-right: 0px;">Kích thước:</h3>
                                <a href="#" id="showOverlayLink">(Cách chọn size)</a>
                            </div>

                            <div class="size_product" style="width: 40%">
                                <c:forEach var="size" items="${sizeRepository.findAllByProductId(productCurrent.id)}">
                                    <div class="box_size" onclick="changeSize(this)">${size.size}</div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="product_variant quantity">
                            <div class="number">
                                <span class="minus">-</span>
                                <input id="number_text" type="text" value="1" readonly/>
                                <span class="plus">+</span>
                            </div>
                            <button class="button" type="submit">add to cart</button>
                        </div>
                    </form>
                    <div class="priduct_social">
                        <h3>Share on:</h3>
                        <ul>
                            <li><a href="#"><i class="fa fa-rss"></i></a></li>
                            <li><a href="#"><i class="fa fa-vimeo"></i></a></li>
                            <li><a href="#"><i class="fa fa-tumblr"></i></a></li>
                            <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<!--product details end-->

<!--product info start-->
<div class="product_d_info">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="product_d_inner">
                    <div class="product_info_button">
                        <ul class="nav" role="tablist">
                            <li>
                                <a class="active" data-toggle="tab" href="#info" role="tab" aria-controls="info"
                                   aria-selected="false">Thông tin thêm</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#reviews" role="tab" aria-controls="reviews"
                                   aria-selected="false">Reviews</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="info" role="tabpanel">
                            <div class="product_info_content">
                                <p>
                                    <i class="fa fa-check">&ensp;</i>Cam kết chính hảng<br>
                                    <i class="fa fa-check">&ensp;</i>Bảo hành 6 tháng<br>
                                    <i class="fa fa-check">&ensp;</i>Đổi size trong vòng 7 ngày<br>
                                    <i class="fa fa-check">&ensp;</i>Đổi trả trong vòng 3 ngày<br>
                                    <i class="fa fa-check">&ensp;</i>Free ship cho đơn hàng trên 1 triệu<br>
                                </p>
                            </div>
                        </div>

                        <div class="tab-pane fade list" id="reviews" role="tabpanel">
                            <div class="review">
                                <div class="review_content_item">
                                    <c:forEach items="${evaluateList}" var="evaluate">
                                        <div class="comment item" style="margin-bottom: 20px">
                                            <div class="comment-rate" style="display: flex;">
                                                <strong style="margin-right: 15px">${evaluate.account.accountDetail.name}</strong>
                                                <ul style="display: flex; margin-right: 15px">
                                                    <c:forEach items="${evaluateService.rateStar(evaluate.rate)}"
                                                               var="star">
                                                        <c:choose>
                                                            <c:when test="${star==1}">
                                                                <li><i class="fa fa-star"></i></li>
                                                            </c:when>
                                                            <c:when test="${star==0}">
                                                                <li><i class="far fa-star"></i>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li><i class="fa fa-star-half-alt "></i></li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </ul>
                                                <p>${evaluate.createdAt}</p>
                                            </div>
                                            <div class="comment_content">${evaluate.comment}</div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="review_summary">
                                    <div class="review_summary_figure">
                                        <div class="line_figure" style="margin-bottom: 3px"><strong
                                                style="color: #faca50">${Math.round(evaluateService.avg(evaluateList)*100.0)/100.0}</strong><strong>/5</strong>
                                        </div>
                                        <div class="rate_avg_star">
                                            <ul style="display: flex;">
                                                <c:forEach items="${evaluateService.rateStar(evaluateService.avg(evaluateList))}" var="star">
                                                    <c:choose>
                                                        <c:when test="${star==1}">
                                                            <li><i class="fa fa-star"></i></li>
                                                        </c:when>
                                                        <c:when test="${star==0}">
                                                            <li><i class="far fa-star"></i>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li><i class="fa fa-star-half-alt "></i></li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="review_total">
                                            <span style="font-size: 13px">${evaluateList.size()} lượt đánh giá</span>
                                        </div>
                                    </div>
                                    <div class="review_summary_detail" style="display: flex; justify-content: center">
                                        <div class="start_static">
                                            <c:forEach items="${evaluateService.createListInt(5)}" var="countStar">
                                                <div class="rate_avg_star">
                                                    <ul style="display: flex;">
                                                        <c:forEach items="${evaluateService.rateStar(countStar)}"
                                                                   var="star">
                                                            <c:choose>
                                                                <c:when test="${star==1}">
                                                                    <li><i class="fa fa-star"></i></li>
                                                                </c:when>
                                                                <c:when test="${star==0}">
                                                                    <li><i class="far fa-star"></i></li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li><i class="fa fa-star-half-alt"></i></li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="rate_count">
                                            <c:forEach items="${evaluateService.createListInt(5)}" var="rateValue">
                                                <div>
                                                    <c:set var="count"
                                                           value="${evaluateRepository.countRate(productCurrent.id,rateValue)}"/>
                                                    <progress max="${evaluateList.size()}" value="${count}"
                                                              aria-busy=""></progress>
                                                    <span>${count}</span>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="shop_toolbar t_bottom">
                                <div class="pagination">
                                    <ul class="listPage">
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
<!--product info end-->

<!--product section area start-->
<section class="product_section related_product">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section_title">
                    <h2>Sản phẩm liên quan</h2>
                    <p></p>
                </div>
            </div>
        </div>
        <div class="product_area">
            <div class="row">
                <div class="product_carousel product_three_column4 owl-carousel">

                    <c:forEach items="${productService.findAllByProductCategorySoldTop(productCurrent.category.id)}"
                               var="product">
                        <div class="col-lg-3">
                            <div class="single_product">
                                <div class="product_thumb">
                                    <c:if test="${product.images.size()>0}">
                                        <a class="primary_img" href="/product/${product.id}"><img
                                                src="${product.images.get(0).img}" alt=""></a>
                                    </c:if>
                                    <c:if test="${product.images.size()>1}">
                                        <a class="secondary_img" href="/product/${product.id}"><img
                                                src="${product.images.get(1).img}" alt=""></a>
                                    </c:if>

                                    <div class="quick_button">
                                        <a href="#" data-toggle="modal" data-target="#modal_box-${product.id}"
                                           >Xem nhanh</a>
                                    </div>

                                    <div class="product_sale">
                                        <c:if test="${product.promotion>0}"><span>-${product.promotion}%</span></c:if>
                                    </div>
                                </div>
                                <div class="product_content">
                                    <h3><a href="product-details.jsp">${product.name}</a></h3>
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
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>
</section>
<!--product section area end-->

<!--product section area start-->
<section class="product_section upsell_product">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section_title">
                    <h2>Sản phẩm mới ra mắt</h2>
                    <p>Mang xu hướng thời trang hiện đại, phù hợp với mọi giới tính</p>
                </div>
            </div>
        </div>
        <div class="product_area">
            <div class="row">
                <div class="product_carousel product_three_column4 owl-carousel">
                    <c:forEach items="${productService.findNewProduct(10)}" var="product">
                        <div class="col-lg-3">
                            <div class="single_product">
                                <div class="product_thumb">
                                    <c:if test="${product.images.size()>0}">
                                        <a class="primary_img" href="/product/${product.id}"><img
                                                src="${product.images.get(0).img}" alt=""></a>
                                    </c:if>
                                    <c:if test="${product.images.size()>1}">
                                        <a class="secondary_img" href="/product/${product.id}"><img
                                                src="${product.images.get(1).img}" alt=""></a>
                                    </c:if>

                                    <div class="quick_button">
                                        <a href="#" data-toggle="modal" data-target="#modal_box-${product.id}"
                                           title="quick_view">Xem nhanh</a>
                                    </div>

                                    <div class="product_sale">
                                        <c:if test="${product.promotion>0}"><span>-${product.promotion}%</span></c:if>
                                    </div>
                                </div>
                                <div class="product_content">
                                    <h3><a href="product-details.jsp">${product.name}</a></h3>
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
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>
</section>
<!--product section area end-->

<jsp:include page="footer.jsp"/>

<!-- modal area start-->
<c:forEach var="product"
           items="${productService.addAll(productService.findAllByProductCategorySoldTop(productCurrent.id),productService.findNewProduct(10)) }">
    <!-- modal area start-->
    <div class="modal fade" id="modal_box-${product.id}" tabindex="-1"
         role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <div class="modal_body">
                    <div class="product_details">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-5 col-md-5">
                                    <div class="product-details-tab">
                                        <div id="img-2" class="zoomWrapper single-zoom">
                                            <img id="zoom2"
                                                 src="${product.images.get(0).img}"
                                                 data-zoom-image="${product.images.get(0).img}"
                                                 alt="big-1">
                                        </div>

                                        <div class="single-zoom-thumb">
                                            <ul class="s-tab-zoom owl-carousel single-product-active"
                                                id="gallery_02">
                                                <c:forEach items="${product.images}"
                                                           var="img">
                                                    <li><p href="#" class="elevatezoom-gallery active"
                                                           data-update="" data-image="${img.img}"
                                                           data-zoom-image="${img.img}"> <img src="${img.img}"
                                                                                              alt="zo-th-1"/>
                                                    </p></li>
                                                </c:forEach>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7">
                                    <div class="product_d_right">
                                        <form action="javascript:addToCart(${productCurrent.id})">

                                            <h1 style="margin-bottom: 0px">${product.name}</h1>
                                            <c:set var="evaluates"
                                                   value="${evaluateRepository.findAllByProductId(product.id)}"/>
                                            <c:if test="${evaluates.size()>0}">
                                                <div class=" product_ratting" style="margin-bottom: 0px">
                                                    <ul>
                                                        <c:forEach
                                                                items="${evaluateService.rateStar(evaluateService.rateAvg(evaluates))}"
                                                                var="star">
                                                            <c:choose>
                                                                <c:when test="${star==1}">
                                                                    <li><i class="fa fa-star"></i></li>
                                                                </c:when>
                                                                <c:when test="${star==0}">
                                                                    <li><i class="far fa-star"></i></li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li><i class="fa fa-star-half-alt "></i></li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <li class="review">(${evaluates.size()} đánh giá)</li>

                                                    </ul>
                                                </div>
                                            </c:if>

                                            <div class="product_price">
                                                <c:choose>
                                                    <c:when test="${product.promotion>0}">
                                                        <span style="color:red;"
                                                              class="current_price">${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                        <span class="old_price">${formatVND.format(product.price)}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color:red;"
                                                              class="current_price">${formatVND.format(product.price)}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="product_desc">
                                                <p>${product.description}</p>
                                            </div>
                                            <div class="product_variant size"
                                                 style="display: block; margin-bottom: 10px">
                                                <div style="display: flex">
                                                    <h3 style="margin-right: 0px;">Kích thước:</h3>
                                                </div>

                                                <div class="size_product" style="width: 40%">
                                                    <c:forEach var="size"
                                                               items="${sizeRepository.findAllByProductId(product.id)}">
                                                        <div class="box_size"
                                                             onclick="changeSize(this)">${size.size}</div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="product_variant quantity">
                                                <div class="number">
                                                    <span class="minus">-</span>
                                                    <input id="number_text2" type="text" value="1"/>
                                                    <span class="plus">+</span>
                                                </div>
                                                <button class="button" type="submit" >add to cart</button>
                                            </div>
                                        </form>
                                        <div class="priduct_social">
                                            <h3>Share on:</h3>
                                            <ul>
                                                <li><a href="#"><i class="fa fa-rss"></i></a></li>
                                                <li><a href="#"><i class="fa fa-vimeo"></i></a></li>
                                                <li><a href="#"><i class="fa fa-tumblr"></i></a></li>
                                                <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
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
    </div>
</c:forEach>


<%--	<!-- modal area start-->--%>
<!-- JS============================================ -->

<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
<%--    Page--%>
<script>
    // Xử lý phân trang
    let thisPage = 1;
    let limit = 6;
    let list = document.querySelectorAll('.list .item');
    let listIndex = document.querySelectorAll('.list .item');

    function reLoadItem() {
        list = document.querySelectorAll('.list .item');
        loadItem();
    }

    function loadItem() {
        let beginGet = limit * (thisPage - 1);
        let endGet = limit * thisPage - 1;
        list.forEach((item, key) => {
            if (key >= beginGet && key <= endGet) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        })
        listPage();
    }

    loadItem();

    function listPage() {
        let count = Math.ceil(list.length / limit);
        document.querySelector('.listPage').innerHTML = '';

        if (thisPage != 1) {
            let prev = document.createElement('li');
            prev.innerText = '<<';
            prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
            document.querySelector('.listPage').appendChild(prev);
        }

        for (i = 1; i <= count; i++) {
            let newPage = document.createElement('li');
            newPage.innerText = i;
            if (i == thisPage) {
                newPage.classList.add('active');
            }
            newPage.setAttribute('onclick', "changePage(" + i + ")");
            document.querySelector('.listPage').appendChild(newPage);
        }

        if (thisPage != count) {
            let next = document.createElement('li');
            next.innerText = '>>';
            next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
            document.querySelector('.listPage').appendChild(next);
        }
    }

    function changePage(i) {
        thisPage = i;
        loadItem();
    }
</script>
<script>
    function addToCart(id) {
        let cart = [];
        let storage = localStorage.getItem('cart');
        if (storage)
            cart = JSON.parse(storage);
        let quantity = parseInt(document.getElementById("number_text").value);
        if(document.querySelector('.box_size.active')==null){
            showMessageBox(1);
        }
        else if(quantity > 0) {
            var size = document.querySelector('.box_size.active').textContent;
            let item = cart.find(c => c.id == id && c.size == size);
            if (item) {
                item.quantity += quantity;
            } else {
                cart.push({id: id, size: size, quantity: quantity});
            }
            localStorage.setItem('cart', JSON.stringify(cart));
            showMessageBox(0);
        }

        reloadCartLength();
    }
    function showMessageBox(type){
        let messageBox = document.getElementById("messageBox");
        if(messageBox.classList.contains("warning"))
            messageBox.classList.remove("warning")
        if(messageBox.classList.contains("success"))
            messageBox.classList.remove("success")
        if(type==0){
            messageBox.classList.add("success");
            messageBox.innerHTML = '<p><i class="fas fa-check-circle" style="margin-right: 3px"></i> Thêm sản phẩm thành công</p>';
        }
        else {
            messageBox.classList.add("warning");
            messageBox.innerHTML = '<p><i class="fas fa-exclamation" style="margin-right: 3px"></i> Vui lòng chọn kích thước</p>';
        }

        messageBox.classList.remove("hidden");
        setTimeout(function () {
            messageBox.classList.add("hidden");
        }, 2000);

    }
    function changeSize(element) {
        // Loại bỏ lớp "active" từ tất cả các hộp
        var boxes = document.querySelectorAll(".box_size");
        boxes.forEach(function (box) {
            box.classList.remove("active");
        });

        // Thêm lớp "active" cho hộp được click
        element.classList.add("active");
    }

    $(document).ready(function () {
        $('.minus').click(function () {
            var $input = $(this).parent().find('input');
            var count = parseInt($input.val()) - 1;
            count = count < 1 ? 1 : count;
            $input.val(count);
            $input.change();
            return false;
        });
        $('.plus').click(function () {
            var $input = $(this).parent().find('input');
            $input.val(parseInt($input.val()) + 1);
            $input.change();
            return false;
        });
    });

    // JavaScript để điều khiển hiển thị và ẩn lớp đè
    let showOverlayLink = document.getElementById("showOverlayLink");
    let overlay = document.getElementById("overlay");
    showOverlayLink.addEventListener("click", function (event) {
        event.preventDefault(); // Ngăn chặn điều hướng khi click vào đường link
        overlay.style.display = "block"; // Hiển thị lớp đè
    });
    // Sự kiện click bên ngoài lớp đè
    window.addEventListener("click", function (event) {
        if (event.target === overlay) {
            overlay.style.display = "none"; // Ẩn lớp đè nếu click bên ngoài
        }
    });

</script>


</body>

</html>
