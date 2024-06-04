<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Giỏ hàng</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/admin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="assets/img/favicon.ico">

    <!-- CSS
        ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .cart_link a i span {
            font-size: 12px;
        }

        .error-message {
            color: red;
            font-size: 13px;
            /*font-family: "Times New Roman";*/
        }

        .flex-2 {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        .form-select {
            flex-grow: 1; /* Chia đều khoảng trống trên dòng */
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
            color: #242424;
            font-weight: 500;
            border-radius: 0px;
        }

        .flex-2 input {
            width: 100%;
        }

        .flex-2 select input {
            width: 100%;
        }

        .coupon_inner input {
            width: 100%;
            height: 31px;
            margin: 0;
            color: #242424;
            font-weight: 500;
        }

        .coupon_inner .radio input {
            width: fit-content;
            height: fit-content;
        }

        .coupon_inner .radio label {
            line-height: 13px;
            margin-right: 30px;
            margin-left: 5px;
        }

        .tab-content {
            display: none;
            background: #f6f6f6;
            border: 1px solid #e1e1e1;
            padding: 20px 10px;
        }

        .active {
            display: block;
        }

        .tab-label {
            cursor: pointer;
            margin-right: 10px;
            padding: 5px;
        }

        .tab-label:hover {
            background-color: #f0f0f0;
        }

        .tab-label.active {
            background-color: #e0e0e0;
        }

        .tab-content .store input {
            width: fit-content;
            height: fit-content;
        }

        .store ul li div {
            color: #242424;
        }

        .store #ul-address li div label {
            margin-left: 7px;
            margin-right: 4px;
        }

        .store ul li div span {
            color: #10a702;
            font-size: 12px;
            margin-left: 5px;
        }

        .scroll-container {
            max-height: 200px; /* Chiều cao của phần tử chứa danh sách */
            overflow: auto; /* Tạo thanh trượt khi nội dung vượt quá kích thước của phần tử */
        }

        .hidden {
            display: none;
        }

        .coupon-area {
            margin: 5px 0;
            display: flex;
            align-items: baseline;
            position: relative;
            justify-content: space-between;
        }

        .coupon-area p {
            /*margin-right: 10px;*/
        }

        #modal-voucher .modal-lg {
            max-height: 38.75rem;
            max-width: 38.75rem;
        }

        .coupon-area .voucher-button {
            appearance: none;
            background: transparent;
            float: right;
            border: 0;
            width: auto;
            height: auto;
            box-shadow: 0 0 0 0;
            color: #05a !important;
            font-size: 14px;
            font-weight: 500;
            line-height: 21px;
            padding: 0;
            text-transform: capitalize;
        }

        .coupon-area .voucher-button:hover {
            background: #FFFFFF;
            color: #05a !important;
        }

        .section-coupon {
            max-height: 250px; /* Đặt chiều cao tối đa cho phần tử */
            overflow-y: auto; /* Hiển thị thanh cuộn dọc khi nội dung vượt quá chiều cao */
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            width: 100%;
            margin-top: 5px;
        }

        .coupon_inner .coupon-item {
            width: 100%;
        }

        .section-coupon .coupon-item {
            width: 100%;
            margin-bottom: 15px;
            padding: 5px 10px;
            background: #f5f5f5;
            display: flex;
            border-radius: 15px;
            margin-right: 10px;
        }

        .section-coupon .coupon-item-left {
            width: auto;
            padding-right: 10px;
            position: relative;
            display: flex;
            align-items: center;
            border-right: 1px dashed #ccc;
        }

        .dt-width-auto {
            width: auto;
            height: auto;
        }

        .modal-search-voucher {
            display: flex;
            background-color: #f8f8f8;
            align-items: center;
            padding: .9375rem;
            margin-bottom: 10px;
            width: 95%;
        }

        .modal-search-voucher .search-area {
            flex: 1;
        }

        .input-with-validator-wrapper {
            position: relative;
        }

        .input-with-validator {
            align-items: center;
            background-color: #fff;
            border: 1px solid rgba(0, 0, 0, .14);
            border-radius: 2px;
            box-shadow: inset 0 2px 0 0 rgba(0, 0, 0, .02);
            box-sizing: border-box;
            color: #222;
            display: flex;
            height: 40px;
            padding: 10px;
            position: relative;
            transition: border-color .1s ease;
        }

        /*.YcRvku .LxsvzT.qFr_OU {*/
        /*    color: #ccc;*/
        /*}*/

        .input-with-validator input {
            background: transparent;
            border: 0;
            box-shadow: none;
            flex: 1;
            font-size: 14px;
            outline: none;
        }

        .modal-search-voucher .input-with-validator > input {
            flex: none;
            width: 100%;
        }

        .stardust-button {
            font-size: 14px;
            font-weight: 400;
            margin-left: 10px;
            border: 0.5px solid black;
            background-color: #FFFFFF;
        }

        .search-title {
            flex-shrink: 0;
            margin-right: .6875rem;
            text-transform: capitalize;
        }

        .section-coupon .coupon-item-right {
            padding-left: 10px;
            position: relative;
            width: 70%;
        }

        .section-coupon .coupon-item-right h4 {
            font-size: 14px;
            font-weight: 700;
            margin: 0;
        }

        .section-coupon .coupon-item-right > p {
            line-height: normal;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .section-coupon .coupon-item-right .coupon-item-des {
            display: flex;
            justify-content: space-between;
            align-items: self-end;
            font-size: 10px;
        }

        .section-coupon .coupon-button {
            width: 10%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .section-coupon .coupon-item-right .coupon-item-des p {
            line-height: normal;
            margin: 0;
            white-space: nowrap;
            font-size: 12px;
        }

        .section-coupon .coupon-item-right .coupon-item-des .right {
            font-weight: 700;
            padding: 5px 7px;
            background: #f1c14f;
            color: #fff;
            border-radius: 15px;
            cursor: pointer;
        }

        .cart_subtotal p.cart_amount_deli {
            color: red;
            font-size: 16px;
            font-weight: 600;
        }

        .cart_subtotal p.cart_amount_store {
            color: #10a702;
            font-size: 14px;
            font-weight: 600;
        }

        .promotion_ship {
            margin-bottom: 0px !important;
        }

        .vourcher p {
            color: #242424;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .input-voucher-group {
            display: flex;
            align-items: center; /* Để căn giữa theo chiều dọc */
            margin-bottom: 10px;
        }

        .input-voucher-group input {
            margin-right: 5px;
            width: 70%;
        }

        .promotion p {
            color: #242424;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .input-vourcher-btn button {
            /*flex: 4; !* Để chia đều không gian *!*/
        }

        .ri-secure-payment-line ul li {
            display: flex;
        }

        .ri-secure-payment-line input {
            height: fit-content;
            width: fit-content;
            margin: 6px 10px 3px 0px;
        }

        .ri-secure-payment-line {
            padding-top: 10px;
            border-top: 2px solid black;
        }

        .align-center {
            margin: auto;
            max-width: 450px;
        }

        .button_back {
            width: 450px;
            background: #fff;
            border-radius: 3px;
            border: 1px solid #ff6a28;
            color: #ff6a28;
            display: inline-block;
            height: 45px;
            line-height: 45px;
            padding: 0 16px;
            text-transform: uppercase;
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 3px;
            margin-top: 10px;
        }

        .button_back:hover {
            cursor: pointer;
            color: #ffffff;
            background: #ff6a28;
        }

        .cart_empty {
            margin-top: 75px;
            margin-bottom: 300px;
            width: fit-content;
        }

        .cart_empty span {
            font-size: 16px;
            font-family: auto;
            color: black;
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

        #cart-sub h3 {
            letter-spacing: 2px;
        }

        .success i {
            margin-right: 5px; /* Khoảng cách giữa biểu tượng và văn bản */
        }

        .infoDeli {
            color: #ffffff;
            background: #242424;
            text-transform: uppercase;
            font-size: 16px;
            font-weight: 600;
        }

        .infoDeli i {
            color: red;
            width: 8%;
            font-size: 24px;
            justify-content: center;
            text-align: right;
            line-height: 37px;
            float: right;
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

        .popup-buttons {
            gap: 5.5rem;
            justify-content: center;
        }

        .list-address {
            display: grid;
            grid-template-columns: repeat(5, 1fr); /* Three columns */
            grid-gap: 10px; /* Gap between grid items */
            padding: 10px; /* Padding around grid container */
        }

        .area-address {
            border: 1px solid #ddd;
            margin: 15px 10px;
        }

        .info-item {
            border: 1px solid;
            border-radius: 10px;
            font-size: 12px;
            padding: 7px 5px;
        }

        .info-item p {
            font-size: 10px;
            margin: 0;
            line-height: 15px;
        }

        .area-add-address {
            margin: 20px 10px;
        }

        .area-add-address input {
            border: 1px solid #ced4da;
            padding: 4px 8px;
            color: #242424;
            font-weight: 500;
        }

        .modal_body h3 {
            color: #242424;
            line-height: 37px;
            padding: 5px 15px;
            text-transform: uppercase;
            font-size: 24px;
            font-weight: 600;
            text-align: center;
        }

        .coupon_code h3 {
            margin: 0;
        }

        .modal-content button.close:hover {
            background: red;
            color: #ffffff;
        }

        .button-handle {
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            width: 90px;
            margin: 0 5px;
            color: #fff;
        }

        .area-address .coupon_inner {
            padding-bottom: 15px;
        }

        .area-address .coupon_inner button {
            height: 32px;
            line-height: 16px;
        }

        .area-address .info-item h4 {
            margin-bottom: 3px;
        }

        .area-address .info-item:hover {
            cursor: pointer;
        }

        .area-address .active {
            color: #ff6a28;
            boder: 1px solid #ff6a28;
        }

        .coordinate-container {
            margin-right: 15px;
            display: flex;
            overflow: hidden; /* Ẩn văn bản vượt ra khỏi phần tử cha */
        }

        #animated-text {
            animation: slideLeft 2s linear; /* Áp dụng animation với thời gian 2 giây và hiệu ứng linear */
            text-transform: none;
            font-size: 16px;
            line-height: 43px;
            margin-right: 10px;
        }

        @keyframes slideLeft {
            0% {
                transform: translateX(100%); /* Bắt đầu di chuyển từ phải sang trái */
            }
            100% {
                transform: translateX(0); /* Dừng lại ở vị trí ban đầu */
            }
        }

        .info-item p {
            user-select: none;
        }

        label, p, i, span {
            user-select: none;

        }

        .tab-label input {
            user-select: none;
        }

        .ship-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border: 1px solid #ced4da;
            margin-bottom: 10px;
        }

        .ship-item input {
            display: none;
        }

        /*.ship-item {*/
        /*    background-color: rgba(0, 255, 255, 0.2);*/
        /*    flex-direction: row;*/
        /*    display: flex;*/
        /*    margin-bottom: 5px;*/
        /*    border-radius: 20px;*/
        /*    font-size: 10px;*/
        /*}*/

        /*.ship-button {*/
        /*    align-content: center;*/
        /*    padding: 10px;*/
        /*    margin-left: 20px;*/
        /*}*/

        /*.ship-detail {*/
        /*    margin-left: 20px;*/
        /*    margin-top: 5px;*/
        /*    margin-bottom: 5px;*/
        /*}*/

        /*.shipping-content {*/
        /*    margin-top: 10px;*/
        /*}*/

        /*.p-shipping {*/
        /*    margin-bottom: 0px !important;*/
        /*    font-size: 15px !important;*/
        /*}*/

        .toggle {
            display: flex;
        }

        .toggle span {
            margin-left: 5px;
            font-size: 16px;
        }

        .arrow {
            margin-right: 10px;
            transition: transform 0.3s;
        }

        #delivery_type {
            display: none;
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
            color: #242424;
            font-weight: 500;
            overflow: hidden;
            transition: display 0.3s ease;
        }

        #delivery_type span strong {
            font-weight: 600;
        }

        .ship-item:hover {
            color: #ff6a28;
            border: 1px solid #ff6a28;
        }

        .ship-item.active {
            color: #ff6a28;
            border: 1px solid #ff6a28;
        }

        .show .arrow {
            transform: rotate(180deg);
        }

        .show #delivery_type {
            height: auto; /* Use JavaScript to dynamically set height */
        }

        #ul-address div {
            display: flex;
            align-items: baseline;
        }
    </style>


</head>

<body>
<script>
    // Hàm để lấy giá trị của tham số từ URL
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    document.addEventListener('DOMContentLoaded', function () {
        var payment = getParameterByName('payment');
        if (payment === "success") {
            localStorage.removeItem('cart');

            localStorage.removeItem('storeValid');
            window.location.href = "/cart?message=success";
        }
    });
</script>

<!-- Header Section Begin-->
<jsp:include page="header.jsp"/>
<!-- Header Section End -->

<div id="messageBox" class="hidden success">
    <p id="messageContent"><i class="fas fa-check-circle"></i>Đặt hàng thành công</p>
</div>

<div id="content">
    <!--breadcrumbs area start-->
    <div class="breadcrumbs_area other_bread">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb_content">
                        <ul>
                            <li><a href="index.jsp">home</a></li>
                            <li>/</li>
                            <li>cart</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--breadcrumbs area end-->

    <!-- shopping cart area start -->
    <div class="shopping_cart_area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="table_desc">
                        <div class="cart_page table-responsive">
                            <table>
                                <thead>
                                <tr>
                                    <th class="product_remove">Xóa</th>
                                    <th class="product_thumb">Hình ảnh</th>
                                    <th class="product_name">Sản phẩm</th>
                                    <th class="product-price">Giá</th>
                                    <th class="product_quantity">Số lượng</th>
                                    <th class="product_total">Tổng tiền(VNĐ)</th>
                                </tr>
                                </thead>
                                <tbody id="t-body">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <form action="javascript:pay()" method="post" id="form-cart">
                <!--coupon code area start-->
                <div class="coupon_area">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="coupon_code left">
                                <div style="display: flex;    justify-content: space-between;" class="infoDeli">
                                    <h3>Thông tin giao hàng</h3>
                                    <div class="coordinate-container" data-toggle="modal" data-target="#modal_address">
                                        <span id="animated-text">Lưu vị trí</span>
                                        <i class="fas fa-map-marker-alt" style="color: red; line-height: 43px"></i>
                                    </div>
                                </div>
                                <div class="coupon_inner">
                                    <div class="coupon-area">
                                        <h4>MÃ KHUYẾN MÃI</h4>
                                        <button type="button" class="voucher-button" data-bs-toggle="modal"
                                                data-bs-target="#modal-voucher">Chọn voucher
                                        </button>
                                    </div>
                                    <div class="flex-2" style="margin-bottom: 15px">
                                        <input
                                                placeholder="Họ và tên" name="name" type="text" id="name"
                                                required style="margin-right: 10px">
                                        <input
                                                placeholder="Số điện thoại nhận hàng" name="phone" type="text"
                                                id="phone"
                                                required>
                                    </div>

                                    <div id="error-message" class="error-message"></div>
                                    <h4>CHỌN CÁCH THỨC NHẬN HÀNG</h4>

                                    <div class="flex-2 radio">
                                        <div class="tab-label" onclick="openTab('tab1')">
                                            <input type="radio" id="tab1-radio" name="tab-radio" class="radio-input">
                                            <label>Giao tận nơi</label>
                                            </input>
                                        </div>

                                        <div class="tab-label" onclick="openTab('tab2')">
                                            <input type="radio" id="tab2-radio" name="tab-radio" class="radio-input">
                                            <label for="tab2-radio">Nhận tại cửa hàng</label>
                                        </div>
                                    </div>

                                    <div class="tab-content" id="tab1">
                                        <div class="flex-2">
                                            <select class="form-select form-select-sm mb-3" id="city"
                                                    aria-label=".form-select-sm" style="margin-right: 10px">
                                                <option value="" selected>Chọn tỉnh thành</option>
                                            </select>
                                            <select class="form-select form-select-sm mb-3" id="district"
                                                    aria-label=".form-select-sm">
                                                <option value="" selected>Chọn quận huyện</option>
                                            </select>
                                        </div>

                                        <div class="flex-2">
                                            <select class="form-select form-select-sm" id="ward"
                                                    aria-label=".form-select-sm" style="margin-right: 10px;">
                                                <option value="" selected>Chọn phường xã</option>
                                            </select>

                                            <input placeholder="Địa chỉ giao hàng" name="addressDetail"
                                                   id="addressDetail"
                                                   type="text" required>
                                        </div>
                                    </div>

                                    <div id="radio-error-message" class="error-message"></div>
                                    <div class="tab-content" id="tab2">
                                        <div class="flex-2">
                                            <select class="form-select form-select-sm mb-3" id="city1"
                                                    aria-label=".form-select-sm" style="margin-right: 10px">
                                                <option value="" selected>Chọn tỉnh thành</option>
                                            </select>

                                            <select class="form-select form-select-sm mb-3" id="district1"
                                                    aria-label=".form-select-sm">
                                                <option value="" selected>Chọn quận huyện</option>
                                            </select>

                                        </div>
                                        <div class="store scroll-container">
                                            <ul id="ul-address">
                                                <li>
                                                    <div style="display: flex"><input type="radio" name="option"
                                                                                      value="1"><label
                                                            style="margin-left: 7px; margin-right: 4px;">Số 1 Võ Văn
                                                        Ngân, Phường Linh Chiểu, Quận Thủ Đức, Thành phố Hồ Chí
                                                        Minh<span>Còn hàng</span></label></div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="shipping-content">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="modal-voucher" tabindex="-1">
                            <div class="modal-dialog modal-dialog-centered modal-lg"
                                 style="min-width: auto !important;">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"
                                            style="font-size: 1.25rem !important; font-weight: 600; color: #242424">Chọn
                                            mã khuyến mãi</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>

                                    <div class="modal-body">
                                        <div class="modal-search-voucher">
                                            <span class="search-title" aria-label="Mã Voucher"
                                                  tabindex="0">Mã Voucher</span>
                                            <div class="search-area">
                                                <div class="input-with-validator-wrapper">
                                                    <div class="input-with-validator">
                                                        <input type="text" value="" placeholder="Mã Reid Voucher"
                                                               maxlength="255">
                                                    </div>
                                                </div>
                                            </div>
                                            <button class="stardust-button" role="button" tabindex="0"
                                                    aria-label="Tìm kiếm" aria-disabled="false">
                                                <span>Tìm kiếm</span>
                                            </button>
                                        </div>
                                        <div class="section section-coupon">
                                            <c:forEach items="${vourcher_sv.findAllVourcherNotExpired()}"
                                                       var="vourcher">
                                                <div class="coupon-item">
                                                    <div class="coupon-item-left">
                                                        <img class="dt-width-auto" width="50" height="50"
                                                             src="https://file.hstatic.net/1000230642/file/icon-coupon-3_c002643e1e1f4f4197daf580deed043a.png"
                                                             alt="Giảm 120.000đ">
                                                    </div>
                                                    <div class="coupon-item-right">
                                                        <h4 class="discountValue"> Giảm
                                                            <c:choose>
                                                                <c:when test="${vourcher.voucherType == 'DISCOUNT_PERCENT'}">
                                                                    ${formatterDecimal.format(vourcher.discountValue)} %
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${formatVND.format(vourcher.discountValue)}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </h4>
                                                        <p class="minimumValue">
                                                            Đơn hàng tối
                                                            thiểu ${formatVND.format(vourcher.minimumValue)}
                                                        </p>
                                                        <p style="font-size: 12px;">
                                                                ${vourcher.description}
                                                        </p>
                                                        <div class="coupon-item-des">
                                                            <div class="left">
                                                                <p>
                                                                    Mã: <b class="code">${vourcher.voucherCode}</b>
                                                                </p>
                                                                <p class="expirationDate">
                                                                    HSD: ${dateFormat.format(vourcher.expirationDate)}
                                                                </p>
                                                                <p>
                                                                    SL: ${vourcher.quantity}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="coupon-button">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio"
                                                                   name="voucherRadio" id="radioVoucherSelect"
                                                                   value="${vourcher.voucherCode}"
                                                                   data-discount="${vourcher.discountValue}"
                                                                   data-type="${vourcher.voucherType}"
                                                                   data-minimum="${vourcher.minimumValue}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <p class="alert alert-warning mb-2">Coupon không dùng chung với chương trình
                                                khuyến mãi, quà tặng</p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                                id="btn-dimiss-voucher-modal">Trở lại
                                        </button>
                                        <button type="button" class="btn btn-danger"
                                                style="background-color: #ff6a28; border: none"
                                                onclick="applyButtonClicked(this)">Áp dụng
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div><!-- End Large Modal-->
                        <div class="col-lg-6 col-md-6">
                            <div class="coupon_code right" id="cart-sub">
                                <h3>Hóa đơn</h3>
                                <div class="coupon_inner">
                                    <div class="cart_subtotal" id="total_cart">
                                        <p>Tổng tiền</p>
                                    </div>
                                    <div class="cart_subtotal" id="price_deli">
                                        <div class="toggle">
                                            <p>Phí giao hàng</p>
                                            <span id="toggle" class="arrow" onclick="toggleContent()"><i
                                                    class="fas fa-sort-down"></i> </span>
                                        </div>
                                        <div>
                                            <p class="cart_amount_deli hidden" id="receive_deli"
                                               style="margin-bottom: 0px!important;"></p>
                                            <p class="cart_amount_store hidden" id="free_ship_promotion"
                                               style="margin-bottom: 0px!important;">Miễn phí</p>
                                            <p class="promotion_ship hidden" id="promotion_ship"
                                               style="color: #a7bcb9;
                                               font-weight: 300;
                                               text-decoration: line-through;
                                               font-style: italic;
                                               font-size: 14px"></p>
                                        </div>
                                        <p class="cart_amount_store active" id="receive_store">Miễn phí</p>
                                    </div>
                                    <div id="delivery_type">
                                    </div>
                                    <div class="cart_subtotal" id="promotion">
                                        <p>Giảm giá</p>
                                        <p class="cart_amount_deli hidden" id="promotion_value"></p>
                                    </div>
                                    <div class="cart_subtotal" id="subtotal">
                                        <p>Thành tiền</p>
                                    </div>
                                    <div class="cart_subtotal" id="subtotal_pro">
                                        <p></p>
                                        <p class="subtotal_first active" id="subtotal_first"
                                           style="color: #a7bcb9;
                                               font-weight: 300;
                                               margin-bottom: 0px;
                                               text-decoration: line-through;
                                               font-style: italic;
                                               margin-top: -20px;
                                               font-size: 14px"></p>
                                    </div>
                                    <div id="time-expect"></div>
                                    <div class="ri-secure-payment-line">
                                        <h4 style="font-size: 14px">Chọn phương thức thanh toán:</h4>
                                        <ul id="ul-payment">
                                            <li>
                                                <input type="radio" name="payment" value="RECEIVE" checked>
                                                <div>
                                                    <i class="fas fa-hand-holding-usd"
                                                       style="width: 20px;font-size: 15px"></i>
                                                    <span>Thanh toán khi nhận hàng</span>
                                                </div>
                                            </li>
                                            <li>
                                                <input type="radio" name="payment" value="VNPAY">
                                                <div>
                                                    <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png"
                                                         width="20px" height="20px">
                                                    <span>Thanh toán bằng Vnpay</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="checkout_btn">
                                        <button type="submit" id="btn-pay">Thanh toán</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--coupon code area end-->

                <input name="address" id="address"
                       type="text" style="display: none">
            </form>
        </div>
    </div>
    <!-- shopping cart area end -->
</div>

<!--footer area start-->
<jsp:include page="footer.jsp"/>
<!--footer area start-->
<!-- JS
============================================ -->
<div class="modal fade" id="modal_address" tabindex="-1"
     role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <button type="button" id="btn-close-modal" class="close" data-dismiss="modal"
                    aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <div class="modal_body">
                <h3>Vị trí giao hàng</h3>
                <div>
                    <div class="area-address">
                        <div class="list-address" id="content-address">
                        </div>
                        <div class="coupon_inner" style="text-align: end">
                            <button class="button-handle" onclick="usePlaceAddress()">Sử dụng</button>
                            <button class="button-handle" onclick="btnAddNew()">Thêm</button>
                            <button class="button-handle" onclick="replacePlaceAddress()">Sửa</button>
                            <button class="button-handle" onclick="deleteItemPlaceAddress()">Xóa</button>
                        </div>
                    </div>
                    <div class="area-add-address">
                        <div>
                            <div class="flex-2" style="margin-bottom: 15px">
                                <input
                                        placeholder="Họ và tên" name="name" type="text" id="modal-name"
                                        required style="margin-right: 10px">
                                <input
                                        placeholder="Số điện thoại nhận hàng" name="phone" type="text"
                                        id="modal-phone"
                                        required>
                            </div>
                            <div class="flex-2">
                                <select class="form-select form-select-sm mb-3" id="modal-city"
                                        aria-label=".form-select-sm" style="margin-right: 10px">
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                                <select class="form-select form-select-sm mb-3" id="modal-district"
                                        aria-label=".form-select-sm">
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>

                            <div class="flex-2">
                                <select class="form-select form-select-sm" id="modal-ward"
                                        aria-label=".form-select-sm" style="margin-right: 10px; width: 50%">
                                    <option value="" selected>Chọn phường xã</option>
                                </select>

                                <input placeholder="Địa chỉ giao hàng" name="addressDetail" style="width: 50%;"
                                       id="modal-addressDetail"
                                       type="text" required>
                            </div>

                            <div class="flex-2" style="margin-top: 10px">
                                <input placeholder="Tên gợi nhớ của địa chỉ" name="nameAddress"
                                       style="width: 50%; margin-right: 10px"
                                       id="modal-nameAddress"
                                       type="text" required>
                                <div class="coupon_inner" style="padding: 0; width: 50%;">
                                    <button style="height: 33px;line-height: 16px;" onclick="addPlaceAddress()">Lưu
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    function validateSelect() {
        var selectCity = document.getElementById('city');
        var selectDistrict = document.getElementById('district');
        var selectWard = document.getElementById('ward');
        let message = "";
        let result = "";
        if (selectCity.value === "")
            message += "thành phố ";
        if (selectDistrict.value === "")
            message += "huyện ";
        if (selectWard.value === "")
            message += "xã ";
        if (message !== "")
            result = "Vui lòng chọn " + message;

        return result;
    }

    function validateRadio() {
        var radioButtons = document.getElementsByName("option");
        var isChecked = false;

        for (var i = 0; i < radioButtons.length; i++) {
            if (radioButtons[i].checked) {
                isChecked = true;
                break;
            }
        }

        var errorMessageElement = document.getElementById("radio-error-message");

        if (!isChecked) {
            errorMessageElement.textContent = "Vui lòng chọn cửa hàng muốn đến nhận";
            return false;
        }
        return true;
    }

</script>
<script type="module" defer>
    import PopupManager from 'https://cdn.jsdelivr.net/gh/jorgeabrahan/popup_library@67068b1/popup/Popup.js'

    const btnClose = '<i style="font-size: 22px;color: red;" class="fa-regular fa-circle-xmark"></i>';
    const ConfirmationPopup = new PopupManager({btnClose});
    var form = document.getElementById('form-cart');

    if (localStorage.getItem('cart') !== null) {
        document.getElementById("form-cart").addEventListener("submit", function (event) {

            // Ngăn chặn hành động mặc định của sự kiện gửi
            event.preventDefault();

            const type = document.querySelector('.tab-content.active').id;
            let validate = validateSelect();
            if (type === "tab1") {
                if (validate !== "")
                    document.getElementById('error-message').textContent = validate;
                else {
                    if (localStorage.getItem('closestStore')!==null) {
                        const store = JSON.parse(localStorage.getItem('closestStore'));
                        console.log(store);
                        if (store.status == 0)
                            ConfirmationPopup.display({
                                title: '<h4 style="color: blue;font-weight: 500; font-size: 1.4rem">Thông báo</h4>',
                                content: '<span style="color: black;">Sản phẩm của cửa hàng chưa thể đáp ứng đủ số lượng yêu cầu.<br>Nếu quý khách đồng ý đợi chúng tôi một thời gian chúng tôi sẽ nhập đủ số lượng sản phẩm quý khách yêu cầu.<br> Nhân viên chúng tôi sẽ gọi điện tư vấn với quý khách.</span>',
                                buttons: {
                                    elements: [
                                        {
                                            text: 'Đồng ý',
                                            type: 'confirm',
                                            handler: function () {
                                                handleConfirmClick();
                                            }
                                        },
                                        {
                                            text: 'Hủy',
                                            type: 'error',
                                            handler: () => ConfirmationPopup.close()
                                        }
                                    ]
                                }
                            });
                        else {
                            form.submit();
                        }
                    }

                }
            } else {
                if (validateRadio())
                    form.submit();
            }

        });

        function handleConfirmClick() {
            ConfirmationPopup.close();
            form.submit();
        }
    }
</script>
<script>
    function loadEmpty() {
        document.getElementById('content').innerHTML = '<div class="shopping_cart_area" >' +
            '<div class="container">\n' +
            '            <div class="align-center">\n' +
            '                <div class="cart_empty">\n' +
            '                    <img src="https://codescandy.com/coach/rtl/assets/images/bag.svg" style="width: 400px; height: auto">\n' +
            '                        <div style="text-align: center; margin-top: 4px;">\n' +
            '                            <span>Không có sản phẩm trong giỏ hàng</span><br>\n' +
            '                            <a href="/" class="button_back">Về trang chủ</a>\n' +
            '                        </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </div>' +
            '        </div>';
    }

    function showCart() {
        return new Promise((resolve) => {
            let cart = localStorage.getItem('cart');
            if (cart !== null) {
                $.ajax({
                    url: '/cart/getItem',
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: cart,
                    success: function (response) {
                        document.getElementById("t-body").innerHTML = response;
                        showStore();
                        resolve();
                    }
                });
                reloadCartLength();
            } else {
                loadEmpty();
            }
        })

    }

    // function getExpectDeliveryTime() {
    //     var city = document.getElementById('city');
    //     var district = document.getElementById('district');
    //     var ward = document.getElementById('ward');
    //     const token = "31d3a81c-d94f-11ee-8026-f29d8335aebb";
    //     const shop_id = 4932018;
    //     const service_id = 53320;
    //
    //
    //     var valueCity = city.options[city.selectedIndex].value;
    //     var valueDistrict = district.options[district.selectedIndex].value;
    //     var valueWard = ward.options[ward.selectedIndex].value;
    //
    //     console.log(valueCity, valueDistrict, valueWard);
    //     if (city.value == "")
    //         valueCity = "";
    //     if (district.value == "")
    //         valueDistrict = "";
    //     if (ward.value == "")
    //         valueWard = "";
    //
    //     var getDeliveryTime = {
    //         url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/leadtime",
    //         method: "GET",
    //         responseType: "application/json",
    //         headers: {
    //             "token": token
    //         },
    //         params: {
    //             "shop_id": shop_id,
    //             "service_id": service_id,
    //             "from_district_id": 1451,
    //             "from_ward_code": 20912,
    //             "to_ward_code": valueWard,
    //             "to_district_id": valueDistrict
    //         }
    //     };
    //
    //     return new Promise((resolve, reject) => {
    //         var store = localStorage.getItem('storeValid');
    //
    //         if (ward.value === "" || ward.value === null) {
    //             return resolve(0);
    //         } else {
    //             const time = axios(getDeliveryTime);
    //             time.then(function (result) {
    //                 var leadtime = result.data.data.leadtime;
    //                 return resolve(leadtime);
    //             })
    //                 .catch(error => {
    //                     console.error('Error retrieving total:', error);
    //                 });
    //         }
    //     });
    // }

    function getExpectDeliveryTime(expectTime) {
        // Lấy thời gian hiện tại
        const currentTime = new Date();

        // Thêm số giờ vào thời gian hiện tại
        currentTime.setHours(currentTime.getHours() + expectTime);

        const day = currentTime.getDate().toString().padStart(2, '0');
        const month = (currentTime.getMonth() + 1).toString().padStart(2, '0');
        const year = currentTime.getFullYear();
        const hours = currentTime.getHours().toString().padStart(2, '0');
        const minutes = "00";
        return "Thời gian nhận hàng dự kiến: " + hours + ":" + minutes + " giờ," + " ngày " + day + "/" + month + "/" + year;
    }

    function getClosestStore() {
        return new Promise((resolve, reject) => {
            // Gọi hàm để lấy các store còn hàng
            var minShipFee = 0;
            findStore().then((result) => {
                let stores = JSON.parse(localStorage.getItem("storeValid"));
                if (stores !== null) {
                    calCostShipByTextAddress(stores[0].store.department).then((minShip) => {
                        minShipFee = minShip;
                        let promises = stores.map(item => {
                            return calCostShipByTextAddress(item.store.department).then((fee) => {
                                // Lấy giá trị nhỏ nhất
                                if (fee <= minShipFee) {
                                    minShipFee = fee;
                                    localStorage.setItem("closestStore", JSON.stringify(item));
                                }
                            });
                        });

                        // Đợi tất cả các Promise hoàn thành
                        Promise.all(promises).then(() => {
                            resolve();
                        }).catch(error => {
                            reject(error);
                        });
                    }).catch(error => {
                        reject(error);
                    });
                } else {
                    resolve();
                }
            }).catch(error => {
                reject(error);
            });
        });
    }


    function calCostShipByTextAddress(send_add) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        var city = document.getElementById('city');
        var district = document.getElementById('district');

        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;

        var recv_add = valueDistrict + ", " + valueCity;

        var total_pro = 0;
        cart.forEach(item => {
            total_pro += item.quantity;
        });

        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";

        const priceData = {
            PRODUCT_WEIGHT: total_pro * 500,
            ORDER_SERVICE: "VCN",
            SENDER_ADDRESS: send_add,
            RECEIVER_ADDRESS: recv_add,
            PRODUCT_TYPE: "HH",
            NATIONAL_TYPE: 1
        };

        var getFeeAPI = {
            url: "http://localhost:8083/api/getPriceNlp",
            method: "POST",
            responseType: "application/json",
            data: priceData
        };

        return new Promise((resolve, reject) => {
            var store = localStorage.getItem('storeValid');

            if (district.value === "" || district.value === null) {
                return resolve(0);
            } else {
                const calFeeWithText = axios(getFeeAPI);
                calFeeWithText.then(function (result) {
                    return resolve(result.data.data.MONEY_TOTAL);
                })
                    .catch(error => {
                        console.error('Error retrieving total:', error);
                    });
            }
        });
    }

    function calAllCostShipByTextAddress(send_add) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        var city = document.getElementById('city');
        var district = document.getElementById('district');

        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;

        var recv_add = valueDistrict + ", " + valueCity;

        var total_pro_weight = 0;
        cart.forEach(item => {
            total_pro_weight += item.quantity;
        });

        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";

        const priceData = {
            SENDER_ADDRESS: send_add,
            RECEIVER_ADDRESS: recv_add,
            PRODUCT_TYPE: "HH",
            PRODUCT_WEIGHT: total_pro_weight,
            TYPE: 1
        };

        var getFeeAPI = {
            url: "http://localhost:8083/api/getPriceAllNlp",
            method: "POST",
            responseType: "application/json",
            data: priceData
        };

        return new Promise((resolve, reject) => {
            var store = localStorage.getItem('storeValid');

            if (district.value === "" || district.value === null) {
                return resolve(0);
            } else {
                const calAllFeeWithText = axios(getFeeAPI);
                calAllFeeWithText.then(function (result) {
                    return resolve(result.data.RESULT);
                })
                    .catch(error => {
                        console.error('Error retrieving total:', error);
                    });
            }
        });
    }

    function toggleContent() {
        const content = document.getElementById('delivery_type');

        if (content.style.display === "none" || !content.style.display) {
            content.style.display = "block";
        } else {
            content.style.display = "none";
        }
    }

    function displayAllService(data) {
        console.log(data);
        const contentDiv = document.querySelector('#delivery_type');
        let html = '';

        data.forEach(item => {
            html += '<div class="ship-item">' +
                '<span>' + '<strong>' + item.TEN_DICHVU + '</strong>' + ' - ' + item.THOI_GIAN + '</span> <span>' + item.GIA_CUOC + '</span>' +
                '<input value="' + item.GIA_CUOC + '">' +
                '<input value="' + item.THOI_GIAN + '">' +
                '<input style="display:none;"  value="' + item.MA_DV_CHINH + '">' +
                '</div>';
        });

        contentDiv.innerHTML = html;
        handleRadioChange();
        document.getElementById('delivery_type').style.display = "block";
        addEventClickForDeliveryOption();
    }

    function handleRadioChange() {
        const radioButtons = document.querySelectorAll('.ship-item');
        radioButtons.forEach(button => {
            button.addEventListener('click', function () {
                const inputValue = this.querySelectorAll('input');
                let selectedPrice = inputValue[0].value;
                let selectedTime = inputValue[1].value; // Lấy giá trị THOI_GIAN từ thuộc tính data-time
                // Hiển thị giá cước và thời gian được chọn
                console.log(selectedTime);
                document.getElementById('receive_deli').textContent = formatter.format(selectedPrice);

                showOrder(parseFloat(selectedPrice));

                var timeExpect = document.getElementById('time-expect');
                timeExpect.innerHTML = '';
                const hours = parseInt(selectedTime, 10);
                time = getExpectDeliveryTime(hours);
                const newParagraph = document.createElement("p");

                const paragraphText = document.createTextNode(time);

                newParagraph.appendChild(paragraphText);

                timeExpect.appendChild(newParagraph);
            });
        });
    }

    function calCostShip() {
        let cart = JSON.parse(localStorage.getItem('cart'));
        var city = document.getElementById('city');
        var district = document.getElementById('district');
        var ward = document.getElementById('ward');

        var total_pro = 0;
        cart.forEach(item => {
            total_pro += item.quantity;
        });

        var valueCity = city.options[city.selectedIndex].value;
        var valueDistrict = district.options[district.selectedIndex].value;
        var valueWard = ward.options[ward.selectedIndex].value;

        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";
        if (ward.value == "")
            valueWard = "";

        const priceData = {
            PRODUCT_WEIGHT: total_pro * 1000,
            ORDER_SERVICE: "VTK",
            SENDER_PROVINCE: "2",
            SENDER_DISTRICT: "1231",
            RECEIVER_PROVINCE: valueCity,
            RECEIVER_DISTRICT: valueDistrict,
            PRODUCT_TYPE: "HH",
            NATIONAL_TYPE: 1
        };

        var getFeeAPI = {
            url: "http://localhost:8083/api/getPrice",
            method: "POST",
            responseType: "application/json",
            data: priceData
        };

        return new Promise((resolve, reject) => {
            var store = localStorage.getItem('storeValid');

            if (ward.value === "" || ward.value === null) {
                return resolve(0);
            } else {
                const calFee = axios(getFeeAPI);
                calFee.then(function (result) {
                    // document.getElementById('receive_deli').textContent = formatter.format(result.data.data.MONEY_TOTAL);
                    // console.log(getExpectDeliveryTime(result.data.data.KPI_HT))
                    // var timeExpect = document.getElementById('time-expect');
                    // timeExpect.innerHTML = '';

                    // const newParagraph = document.createElement("p");

                    // const paragraphText = document.createTextNode(getExpectDeliveryTime(result.data.data.KPI_HT));

                    // newParagraph.appendChild(paragraphText);

                    // timeExpect.appendChild(newParagraph);
                    return resolve(result.data.data.MONEY_TOTAL);
                })
                    .catch(error => {
                        console.error('Error retrieving total:', error);
                    });
            }
        });
    }
</script>
<script>
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");
    var citis1 = document.getElementById("city1");
    var districts1 = document.getElementById("district1");
    var modal_citis = document.getElementById("modal-city");
    var modal_districts = document.getElementById("modal-district");
    var modal_wards = document.getElementById("modal-ward");

    var GetCity = {
        url: "http://localhost:8083/api/listProvinceById",
        method: "GET",
        responseType: "application/json",
    };
    // var promise = axios(Parameter);
    var promise1 = axios(GetCity);
    var data;


    function renderAddress(city, districtValue, wardValue) {
        return new Promise((resolve, reject) => {
            for (var i = 0; i < citis.options.length; i++) {
                if (citis.options[i].value == city) {
                    citis.selectedIndex = i;
                    break;
                }
            }
            districts.length = 1;
            wards.length = 1;
            var GetDistrict = {
                url: "http://localhost:8083/api/listDistrictById?provinceId=" + city,
                method: "GET",
                responseType: "application/json",
            };
            var promiseDistrict = axios(GetDistrict);
            promiseDistrict.then(function (dataDistricts) {
                dataDistricts.data.data.forEach(function (district) {
                    districts.options[districts.options.length] = new Option(capitalizeWords(district.DISTRICT_NAME), district.DISTRICT_ID);

                    if (district.DISTRICT_ID == parseInt(districtValue)) {
                        districts.selectedIndex = districts.options.length - 1;
                    }
                });
            });
            var GetWards = {
                url: "http://localhost:8083/api/listWardsById?districtId=" + districtValue,
                method: "GET",
                responseType: "application/json",
            };
            var promiseWard = axios(GetWards);
            promiseWard.then(function (dataWard) {
                dataWard.data.data.forEach(function (ward) {
                    wards.options[wards.options.length] = new Option(capitalizeWords(ward.WARDS_NAME), ward.WARDS_ID);
                    if (ward.WARDS_ID == parseInt(wardValue)) {
                        wards.selectedIndex = wards.options.length - 1;
                    }
                });
            });
            resolve();
        });
    }

    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Id);
            citis1.options[citis1.options.length] = new Option(x.Name, x.Id);
            modal_citis.options[modal_citis.options.length] = new Option(x.Name, x.Id);
        }

        citis1.onchange = function () {
            districts1.length = 1;
            var GetDistrict = {
                url: "http://localhost:8083/api/listDistrictById?provinceId=" + this.value,
                method: "GET",
                responseType: "application/json",
            };
            var promiseDistrict = axios(GetDistrict);
            promiseDistrict.then(function (dataDistricts) {
                dataDistricts.data.data.forEach(function (district) {
                    districts1.options[districts1.options.length] = new Option(capitalizeWords(district.DISTRICT_NAME), district.DISTRICT_ID);
                });
            });
            showStore();
        }

        districts1.onchange = function () {
            showStore();
        };

        citis.onchange = function () {
            districts.length = 1;
            wards.length = 1;

            if (this.value != "") {
                var GetDistrict = {
                    url: "http://localhost:8083/api/listDistrictById?provinceId=" + this.value,
                    method: "GET",
                    responseType: "application/json",
                };
                var promiseDistrict = axios(GetDistrict);
                promiseDistrict.then(function (dataDistricts) {
                    console.log(dataDistricts.data.data);

                    dataDistricts.data.data.forEach(function (district) {
                        districts.options[districts.options.length] = new Option(capitalizeWords(district.DISTRICT_NAME), district.DISTRICT_ID);
                    });
                });
            }
        };
        districts.onchange = function () {
            wards.length = 1;
            if (this.value != "") {
                var GetWards = {
                    url: "http://localhost:8083/api/listWardsById?districtId=" + this.value,
                    method: "GET",
                    responseType: "application/json",
                };
                var promiseWard = axios(GetWards);

                promiseWard.then(function (dataWard) {
                    dataWard.data.data.forEach(function (ward) {
                        wards.options[wards.options.length] = new Option(capitalizeWords(ward.WARDS_NAME), ward.WARDS_ID);
                    });
                });
            }
            // document.getElementById('receive_deli').textContent = "";
            // localStorage.removeItem("storeValid");
        };
        wards.onchange = async function () {
            document.getElementById('error-message').textContent = "";

            try {
                await getClosestStore();
                const closestStore = JSON.parse(localStorage.getItem("closestStore"));

                calAllCostShipByTextAddress(closestStore.store.department)
                    .then(result => {
                        console.log(result);
                        displayAllService(result);
                        // showOrder(cost);
                    })
                    .catch(error => console.log(error));
            } catch (error) {
                console.error('Error retrieving closest store:', error);
            }
        }

        modal_citis.onchange = function () {
            modal_districts.length = 1;
            modal_wards.length = 1;

            if (this.value != "") {
                var GetDistrict = {
                    url: "http://localhost:8083/api/listDistrictById?provinceId=" + this.value,
                    method: "GET",
                    responseType: "application/json",
                };
                var promiseDistrict = axios(GetDistrict);
                promiseDistrict.then(function (dataDistricts) {
                    dataDistricts.data.data.forEach(function (district) {
                        modal_districts.options[modal_districts.options.length] = new Option(capitalizeWords(district.DISTRICT_NAME), district.DISTRICT_ID);
                    });
                });
            }

        };
        modal_districts.onchange = function () {
            modal_wards.length = 1;
            if (this.value != "") {
                var GetWards = {
                    url: "http://localhost:8083/api/listWardsById?districtId=" + this.value,
                    method: "GET",
                    responseType: "application/json",
                };
                var promiseWard = axios(GetWards);
                promiseWard.then(function (dataWard) {
                    dataWard.data.data.forEach(function (ward) {
                        modal_wards.options[modal_wards.options.length] = new Option(capitalizeWords(ward.WARDS_NAME), ward.WARDS_ID);
                    });
                });
            }
        };
        modal_wards.onchange = function () {

        }

    }

    // function renderCity(data) {
    //     for (const x of data) {
    //         citis.options[citis.options.length] = new Option(x.Name, x.Id);
    //         citis1.options[citis1.options.length] = new Option(x.Name, x.Id);
    //         modal_citis.options[modal_citis.options.length] = new Option(x.Name, x.Id);
    //     }
    //
    //     citis1.onchange = function () {
    //         district1.length = 1;
    //         if (this.value != "") {
    //             const result = data.filter(n => n.Id === this.value);
    //             for (const k of result[0].Districts) {
    //                 district1.options[district1.options.length] = new Option(k.Name, k.Id);
    //             }
    //         }
    //         showStore();
    //     }
    //
    //     district1.onchange = function () {
    //         showStore();
    //     };
    //
    //     citis.onchange =  function () {
    //         districts.length = 1;
    //         wards.length = 1;
    //         if (this.value != "") {
    //             const result = data.filter(n => n.Id === this.value);
    //
    //             for (const k of result[0].Districts) {
    //                 districts.options[districts.options.length] = new Option(k.Name, k.Id);
    //             }
    //         }
    //
    //         // document.getElementById('receive_deli').textContent = "";
    //         // localStorage.removeItem("storeValid");
    //     };
    //     districts.onchange =  function () {
    //         console.log(this.value);
    //         wards.length = 1;
    //         const dataCity = data.filter((n) => n.Id === citis.value);
    //         if (this.value != "") {
    //             const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;
    //
    //             for (const w of dataWards) {
    //                 wards.options[wards.options.length] = new Option(w.Name, w.Id);
    //             }
    //         }
    //         // document.getElementById('receive_deli').textContent = "";
    //         // localStorage.removeItem("storeValid");
    //     };
    //     wards.onchange = function () {
    //         document.getElementById('error-message').textContent = "";
    //     }
    //
    //     modal_citis.onchange = function () {
    //         modal_districts.length = 1;
    //         modal_wards.length = 1;
    //
    //         if (this.value != "") {
    //             const result = data.filter(n => n.Id === this.value);
    //
    //             for (const k of result[0].Districts) {
    //                 modal_districts.options[modal_districts.options.length] = new Option(k.Name, k.Id);
    //             }
    //         }
    //
    //     };
    //     modal_districts.onchange = function () {
    //         modal_wards.length = 1;
    //         const dataCity = data.filter((n) => n.Id === modal_citis.value);
    //
    //         if (this.value != "") {
    //             const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;
    //
    //             for (const w of dataWards) {
    //                 modal_wards.options[modal_wards.options.length] = new Option(w.Name, w.Id);
    //             }
    //         }
    //     };
    //     modal_wards.onchange = function () {
    //
    //     }
    //
    // }

    function openTab(tabId) {
        document.getElementById('addressDetail').setAttribute('required', 'required');
        var receiveDeli = document.getElementById('receive_deli');
        var receiveStore = document.getElementById('receive_store');

        if (tabId === "tab2") {
            document.getElementById("toggle").style.display = "none";
            showOrder(0);
            document.getElementById('delivery_type').style.display = "none";
            receiveStore.classList.add("active");
            receiveStore.classList.remove("hidden");
            receiveDeli.classList.remove("active");
            receiveDeli.classList.add("hidden");
            document.getElementById('addressDetail').removeAttribute('required');
        }
        if (tabId === "tab1") {
            document.getElementById("toggle").style.display = "block";
            document.getElementById('delivery_type').style.display = "block";
            if (document.querySelector("#delivery_type .ship-item"))
                if (document.querySelector("#delivery_type .ship-item.active"))
                    showOrder(parseFloat(document.querySelectorAll("#delivery_type .ship-item.active input")[0].value.toLocaleString('vi-VN')));
                else showOrder(null);
            else
            {
                if(validateSelect()===""){
                    const closestStore = JSON.parse(localStorage.getItem("closestStore"));
                    calAllCostShipByTextAddress(closestStore.store.department)
                        .then(result => {
                            displayAllService(result);
                            showOrder(null);
                        })
                        .catch(error => console.log(error));
                }
                if(document.querySelector("#total_cart .cart_amount")==null)
                    showOrder(null);
            }

            receiveDeli.classList.add("active");
            receiveDeli.classList.remove("hidden");
            receiveStore.classList.remove("active");
            receiveStore.classList.add("hidden");
        }

        // Lấy tất cả các tab content
        var tabContents = document.querySelectorAll(".tab-content");

        // Ẩn tất cả các tab content
        tabContents.forEach(function (content) {
            content.classList.remove("active");
        });

        // Hiển thị tab content được chọn
        var selectedTab = document.getElementById(tabId);
        if (selectedTab) {
            selectedTab.classList.add("active");
        }

        var radioId = tabId + "-radio";
        var radioButton = document.getElementById(radioId);
        if (radioButton) {
            radioButton.checked = true;
        }
    }

</script>
<script>
    function selectRadio(element) {
        // Xóa lớp 'selected' từ tất cả các div
        var radios = document.querySelectorAll('.custom-radio');
        radios.forEach(function (radio) {
            radio.classList.remove('selected');
        });

        // Thêm lớp 'selected' cho div được chọn
        element.classList.add('selected');

        // Đánh dấu radio button tương ứng là được chọn
        var radioInput = element.querySelector('input[type="radio"]');
        radioInput.checked = true;
    }

    function getSelectedValue() {
        // Tìm radio button được chọn
        var selectedRadio = document.querySelector('input[name="radioGroup"]:checked');

        // Kiểm tra xem có radio button nào được chọn không
        if (selectedRadio) {
            // Lấy giá trị của radio button được chọn
            var selectedValue = selectedRadio.parentElement.selectedValue.trim();

            // Hiển thị giá trị được chọn
            document.getElementById('selectedValue').innerText = "Selected Value: " + selectedValue;
        } else {
            // Nếu không có radio button nào được chọn
            document.getElementById('selectedValue').innerText = "No option selected";
        }
    }
</script>
<script>


    // Function để thêm một mục vào danh sách
    function addItemToList(item) {
        // Tạo một phần tử li
        const newListItem = document.createElement('li');

        // Tạo một phần tử label
        const div = document.createElement('div');

        // Tạo phần tử input
        const inputElement = document.createElement('input');
        inputElement.setAttribute('type', 'radio');
        inputElement.setAttribute('name', 'option');
        inputElement.setAttribute('value', item.store.id); // Sử dụng storeId từ đối tượng item

        const pElement = document.createElement('label');
        pElement.textContent = item.store.department;
        pElement.style.marginLeft = "7px";
        pElement.style.marginRight = "4px";

        // Tạo phần tử span
        const spanElement = document.createElement('span');
        if (item.status == 1)
            spanElement.textContent = 'Còn hàng';
        else {
            spanElement.textContent = 'Nhận hàng sau 3 - 7 ngày';
            spanElement.style.color = "#e67e22";
        }

        // Gắn input và span vào label
        div.appendChild(inputElement);
        pElement.appendChild(spanElement);
        div.appendChild(pElement);

        // Gắn label vào li
        newListItem.appendChild(div);

        // Lấy danh sách ul theo id hoặc class
        const ulElement = document.getElementById('ul-address');

        // Gắn li vào ul
        ulElement.appendChild(newListItem);
    }


    function showStore() {
        let cart = localStorage.getItem('cart');
        var city = document.getElementById('city1');
        var district = document.getElementById('district1');
        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";

        var data = JSON.stringify({carts: JSON.parse(cart), city: valueCity, district: valueDistrict, wards: ""});
        $.ajax({
            url: '/cart/getStore/STORE',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function (response) {
                document.getElementById('ul-address').innerHTML = '';
                response.forEach(item => {
                    addItemToList(item);
                });
            }
        });
    }

    function findStore() {
        let cart = localStorage.getItem('cart');
        var city = document.getElementById('city');
        var district = document.getElementById('district');
        var ward = document.getElementById('ward');

        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        var valueWard = ward.options[ward.selectedIndex].textContent;

        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";
        if (ward.value == "")
            valueWard = "";

        var data = JSON.stringify({
            carts: JSON.parse(cart),
            city: valueCity,
            district: valueDistrict,
            wards: valueWard
        });
        return new Promise((resolve, reject) => {
            $.ajax({
                url: '/cart/getStore/DELIVERY',
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: data,
                success: function (response) {
                    if (response.length > 0) {
                        localStorage.setItem("storeValid", JSON.stringify(response));
                        console.log(response);
                        resolve();
                        // calCostShip()
                        //     .then(cost => showOrder(cost))
                        //     .catch(error => console.log(error));
                    }
                },
                error: function (error) {
                    reject(error);
                }
            });
        });

    }


    async function changeQuantity(cell) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        let cellIndex = cell.parentNode.parentNode;
        cart[cellIndex.rowIndex - 1].quantity = parseInt(cell.value);
        localStorage.setItem('cart', JSON.stringify(cart));

        showCart().then((result) => {
            if (document.querySelector('#receive_deli').textContent == null || document.querySelector('#receive_deli').textContent == "")
                showOrder(0);
            else {
                console.log(1);
                let fee = parseFloat(document.querySelector('#receive_deli').textContent.replace(/[.₫]/g, ''));
                showOrder(fee);
            }


        });

    }

    function deleteItem(cell) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        let cellIndex = cell.parentNode.parentNode;
        cart.splice(cellIndex.rowIndex - 1, 1);
        if (cart.length > 0)
            localStorage.setItem('cart', JSON.stringify(cart));
        else
            localStorage.removeItem('cart');
        showCart();
    }

</script>
<script>
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    function showMessage() {
        let messageBox = document.getElementById("messageBox");
        messageBox.classList.remove("hidden");
        setTimeout(function () {
            messageBox.classList.add("hidden");
        }, 2000);
    }

    // Show Value Order
    function showOrder(cost) {
        var total_price = document.getElementById('total_cart');
        var total_last = document.getElementById('subtotal');
        let price = 0;
        if (cost === null)
            cost = 0;

        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });

        if (document.querySelector('.product-price.product_total')) {
            // Xóa đơn vị tiền tệ và xóa , và số sau ,
            price = parseFloat(document.querySelector('.product-price.product_total').textContent.replace(/[.₫]/g, ''));
        }

        // Xóa
        const amounts = document.querySelectorAll('.cart_amount');
        amounts.forEach(element => {
            element.remove();
        });
        // Thêm
        const valTotal = document.createElement('p');
        valTotal.classList.add('cart_amount');
        valTotal.textContent = formatter.format(price);


        const valTotalLast = document.createElement('p');
        valTotalLast.classList.add('cart_amount');
        valTotalLast.textContent = formatter.format(price + cost);

        total_price.appendChild(valTotal);
        var costHtml = document.getElementById("receive_deli");

        if (cost != 0)
            costHtml.textContent = formatter.format(cost);
        total_last.appendChild(valTotalLast);
    }

    function sortWithSpecificIdFirst(array, specificId) {
        return array.sort((a, b) => {
            if (a.store.id === specificId) return -1;
            if (b.store.id === specificId) return 1;
            return a.store.id - b.store.id;
        });
    }

    function pay() {
        const type = document.querySelector('.tab-content.active').id;
        let cart = localStorage.getItem('cart');
        var paymentOption = document.querySelector('input[name="payment"]:checked');
        var voucher = document.querySelector('input[name="voucherRadio"]:checked');
        if (type === "tab2") {
            if (document.getElementById("ul-address").children) {
                // var selectedElement = document.querySelector('#ul-address.selected');
                var selectedRadioButton = document.querySelector('input[name="option"]:checked');
                if (selectedRadioButton) {
                    var status = selectedRadioButton.parentElement.querySelector('span').textContent;
                    var statusValue = status != 'Còn hàng' ? '0' : '1';
                    var orders = {
                        name: document.getElementById('name').value,
                        phone: document.getElementById('phone').value
                    }
                    let storeValid = [{
                        status: statusValue,
                        store: {
                            id: selectedRadioButton.value
                        }
                    }]
                    var orderCombine = {
                        orders: orders,
                        carts: JSON.parse(cart),
                        storeValid: storeValid,
                        voucher: voucher != null ? voucher.value : null
                    }

                    $.ajax({
                        url: '/cart/payment/STORE/' + paymentOption.value,
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(orderCombine),
                        success: function (response) {
                            if (response.status == "wait") {
                                window.location.href = response.url;
                            } else if (response.status == "success") {
                                localStorage.removeItem('cart');
                                localStorage.removeItem('storeValid');
                                window.location.href = response.url;
                            } else {
                                window.location.href = "/sign-in-up"
                            }
                        },
                        error: function (error) {
                        }
                    });
                }
            }

        }// End ReceiveStore
        else {
            var city = document.getElementById('city');
            var district = document.getElementById('district');
            var ward = document.getElementById('ward');
            var detail = document.getElementById('addressDetail').value;
            var delivery = document.querySelector('#delivery_type .ship-item.active');
            var inputsDelivery = delivery.querySelectorAll('input');

            var valueCity = city.options[city.selectedIndex].textContent;
            var valueDistrict = district.options[district.selectedIndex].textContent;
            var valueWard = ward.options[ward.selectedIndex].textContent;

            var address = "";
            if (detail != "")
                address += detail + ", "
            if (ward !== "")
                address += valueWard + ", "
            if (district !== "")
                address += valueDistrict + ", "
            if (city != "")
                address += valueCity;
            const currentTime = new Date();
            currentTime.setHours(currentTime.getHours() + parseInt(inputsDelivery[1].value));
            var orders = {
                name: document.getElementById('name').value,
                phone: document.getElementById('phone').value,
                address: address,
                delivery: {
                    cost: inputsDelivery[0].value,
                    intentTime: currentTime,
                    code: inputsDelivery[2].value,
                    name: delivery.querySelector('strong').textContent
                }
            }
            var storeValid = null;
            var closestStore = JSON.parse(localStorage.getItem('closestStore'));
            if (closestStore !== null) {
                storeValid = JSON.parse(localStorage.getItem('storeValid'));
                sortWithSpecificIdFirst(storeValid, closestStore.store.id);
            }
            orderCombine = {
                orders: orders,
                carts: JSON.parse(cart),
                storeValid: storeValid !== null ? storeValid : [],
                voucher: voucher != null ? voucher.value : null
            }
            $.ajax({
                url: '/cart/payment/DELIVERY/' + paymentOption.value,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(orderCombine),
                success: function (response) {
                    if (response.status == "wait") {
                        window.location.href = response.url;
                    } else if (response.status == "success") {
                        localStorage.removeItem('cart');
                        localStorage.removeItem('storeValid');
                        localStorage.removeItem('closestStore');
                        window.location.href = response.url;
                    } else {
                        window.location.href = "/sign-in-up"
                    }
                },
                error: function (error) {
                    console.log("errorPay", error);
                }
            });
        }
    }
</script>
<%--Xử lý sự kiện khi trang load xong--%>
<script>
    showCart();


    function reloadData(name, phone, receiveType, paymentType) {

    }


</script>
<%--Xử lý vị trí giao hàng--%>
<script>
    function renderModalAddress(city, districtValue, wardValue) {
        for (var i = 0; i < modal_citis.options.length; i++) {
            if (modal_citis.options[i].value === city) {
                modal_citis.selectedIndex = i;
                break;
            }
        }
        modal_districts.length = 1;
        modal_wards.length = 1;

        var GetDistrict = {
            url: "http://localhost:8083/api/listDistrictById?provinceId=" + city,
            method: "GET",
            responseType: "application/json",
        };
        var promiseDistrict = axios(GetDistrict);
        promiseDistrict.then(function (dataDistricts) {
            dataDistricts.data.data.forEach(function (district) {
                modal_districts.options[modal_districts.options.length] = new Option(capitalizeWords(district.DISTRICT_NAME), district.DISTRICT_ID);

                if (district.DISTRICT_ID == parseInt(districtValue)) {
                    modal_districts.selectedIndex = modal_districts.options.length - 1;
                }
            });
        });
        var GetWards = {
            url: "http://localhost:8083/api/listWardsById?districtId=" + districtValue,
            method: "GET",
            responseType: "application/json",
        };
        var promiseWard = axios(GetWards);
        promiseWard.then(function (dataWard) {
            dataWard.data.data.forEach(function (ward) {
                modal_wards.options[modal_wards.options.length] = new Option(capitalizeWords(ward.WARDS_NAME), ward.WARDS_ID);
                if (ward.WARDS_ID == parseInt(wardValue)) {
                    modal_wards.selectedIndex = modal_wards.options.length - 1;
                }
            });
        });
    }

    var isAdd = true;


    function resetActive() {
        var infoItems = document.querySelectorAll(".area-address .info-item");
        // Lặp qua mỗi info-item và thêm sự kiện click
        infoItems.forEach(function (otherItem) {
            otherItem.classList.remove("active");
        });
    }

    function addEventClickForDeliveryOption() {
        var items = document.querySelectorAll("#delivery_type .ship-item")
        items.forEach(function (item) {
            item.addEventListener("click", function () {
                item.parentNode.querySelectorAll(".active").forEach(function (active) {
                    active.classList.remove("active");
                });
                item.classList.add("active");
            })
        })
    }

    function addEventClick() {
        var infoItems = document.querySelectorAll(".area-address .info-item");
        // Lặp qua mỗi info-item và thêm sự kiện click
        infoItems.forEach(function (item) {
            item.addEventListener("click", function () {
                // Xóa lớp active từ tất cả các info-item khác
                infoItems.forEach(function (otherItem) {
                    otherItem.classList.remove("active");
                });

                // Thêm lớp active cho info-item được nhấp vào
                item.classList.add("active");
            });
        });
        document.getElementById('ul-address').addEventListener('click', function (event) {
            const closestLi = event.target.closest('li');
            if (closestLi) {
                // Tìm thẻ input radio trong thẻ li tương ứng
                const radioInput = closestLi.querySelector('input[type="radio"]');
                if (radioInput) {
                    // Gọi trực tiếp sự kiện click cho radioInput
                    radioInput.click();
                    showOrder(0);
                }
            }
        });
        // Sự kiện click được gắn vào thẻ ul để theo dõi các thẻ li
        document.getElementById('ul-payment').addEventListener('click', function (event) {
            // Kiểm tra xem phần tử được nhấp có phải là thẻ li không
            const closestLi = event.target.closest('li');
            if (closestLi) {
                // Tìm thẻ input radio trong thẻ li tương ứng
                const radioInput = closestLi.querySelector('input[type="radio"]');
                if (radioInput) {
                    // Gọi trực tiếp sự kiện click cho radioInput
                    radioInput.click();
                }
            }
        });

    }

    function addPlaceAddress() {
        var name = document.getElementById("modal-name");
        var phone = document.getElementById("modal-phone");
        var reminiscentName = document.getElementById("modal-nameAddress");

        var city = document.getElementById('modal-city');
        var district = document.getElementById('modal-district');
        var ward = document.getElementById('modal-ward');
        var detail = document.getElementById('modal-addressDetail').value;

        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        var valueWard = ward.options[ward.selectedIndex].textContent;

        var address = "";
        if (detail != "")
            address += detail + ", "
        if (ward !== "")
            address += valueWard + ", "
        if (district !== "")
            address += valueDistrict + ", "
        if (city != "")
            address += valueCity;
        let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
        var contentAddress = {
            name: name.value,
            phone: phone.value,
            reminiscentName: reminiscentName.value,
            city: {
                value: city.value,
                text: valueCity
            },
            district: {
                value: district.value,
                text: valueDistrict
            },
            ward: {
                value: ward.value,
                text: valueWard
            },
            detail: detail,
            fullAddress: address,
            isUse: false
        };
        if (isAdd) {
            placeAddress.push(contentAddress);
        } else {
            var infoItems = document.querySelectorAll(".info-item");
            for (let i = infoItems.length - 1; i >= 0; i--) {
                // Kiểm tra xem phần tử hiện tại có lớp active hay không
                if (infoItems[i].classList.contains("active")) {
                    placeAddress[infoItems.length - i - 1] = contentAddress;
                    isAdd = true;
                    break;
                }
            }
            if (!isAdd) {
                isAdd = true;
                placeAddress.push(contentAddress);
            }
        }
        localStorage.setItem('placeAddress', JSON.stringify(placeAddress));
        resetForm();
        showListAddress();
    }

    function deleteItemPlaceAddress() {
        var infoItems = document.querySelectorAll(".info-item");
        for (var i = 0; i < infoItems.length; i++) {
            // Kiểm tra xem phần tử hiện tại có lớp active hay không
            if (infoItems[i].classList.contains("active")) {
                let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
                placeAddress.splice(placeAddress.length - i - 1, 1);
                localStorage.setItem('placeAddress', JSON.stringify(placeAddress));
                showListAddress();
                break;
            }
        }
    }

    function btnAddNew() {
        resetForm();
        resetActive();
        isAdd = true;
    }

    function resetForm() {
        // Reset các giá trị của các trường input và select
        document.getElementById("modal-name").value = "";
        document.getElementById("modal-phone").value = "";
        document.getElementById("modal-city").selectedIndex = 0;
        document.getElementById("modal-district").selectedIndex = 0;
        document.getElementById("modal-ward").selectedIndex = 0;
        document.getElementById("modal-addressDetail").value = "";
        document.getElementById("modal-nameAddress").value = "";
    }

    function usePlaceAddress() {
        var infoItems = document.querySelectorAll(".info-item");
        let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
        for (var i = 0; i < infoItems.length; i++) {
            // Kiểm tra xem phần tử hiện tại có lớp active hay không
            if (infoItems[i].classList.contains("active")) {
                let content = placeAddress[placeAddress.length - i - 1];
                document.getElementById("name").value = content.name;
                document.getElementById("phone").value = content.phone;
                document.getElementById("addressDetail").value = content.detail;
                renderAddress(content.city.value, content.district.value, content.ward.value);
                document.getElementById("btn-close-modal").click();
                usePlaceAddressIndex(placeAddress.length - i - 1);
                break;
            }
            openTab("tab1");

        }
    }

    function usePlaceAddressIndex(index) {
        let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
        for (var i = 0; i < placeAddress.length; i++) {
            placeAddress[i].isUse = false;
        }
        placeAddress[index].isUse = true;

        document.getElementById("animated-text").style.visibility = "visible";
        document.getElementById("animated-text").textContent = placeAddress[index].reminiscentName;
        localStorage.setItem('placeAddress', JSON.stringify(placeAddress));
    }

    function replacePlaceAddress() {
        var infoItems = document.querySelectorAll(".info-item");
        for (var i = 0; i < infoItems.length; i++) {
            // Kiểm tra xem phần tử hiện tại có lớp active hay không
            if (infoItems[i].classList.contains("active")) {
                let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
                let content = placeAddress[placeAddress.length - i - 1];
                document.getElementById("modal-name").value = content.name;
                document.getElementById("modal-phone").value = content.phone;
                renderModalAddress(content.city.value, content.district.value, content.ward.value);
                document.getElementById("modal-addressDetail").value = content.detail;
                document.getElementById("modal-nameAddress").value = content.reminiscentName;
                isAdd = false;
                break;
            }
        }
    }

    function showListAddress() {
        let listPlaceAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
        var content = document.getElementById('content-address');
        content.innerHTML = '';
        for (let i = listPlaceAddress.length - 1; i >= 0; i--) {
            let placeAddress = listPlaceAddress[i];
            var divInfo = document.createElement('div');
            divInfo.classList.add('info-item');

            var h4 = document.createElement('h4');
            h4.textContent = placeAddress.reminiscentName;
            divInfo.appendChild(h4);

            var pName = document.createElement('p');
            pName.textContent = placeAddress.name + ' - ' + placeAddress.phone;
            divInfo.appendChild(pName);

            var pAddress = document.createElement('p');
            pAddress.textContent = placeAddress.fullAddress;
            divInfo.appendChild(pAddress);

            content.appendChild(divInfo);
        }
        addEventClick();
    }

    showListAddress();
</script>

<script>
    var temp_subtotal = 0;
    var temp_ship_value = 0;

    // Định nghĩa hàm xử lý sự kiện khi nhấn vào nút "Áp dụng"
    function applyButtonClicked(button) {
        // Lấy giá trị của radio button được chọn
        var selectedRadioButton = document.querySelector('input[name="voucherRadio"]:checked');
        if (selectedRadioButton) {
            var voucherCode = selectedRadioButton.value;        //Lấy voucher code
            var voucherMinimum = selectedRadioButton.getAttribute('data-minimum');      //Lấy giá trị tối thiểu
            var voucherDiscount = selectedRadioButton.getAttribute('data-discount');    //Lấy giá trị giảm giá
            var voucherType = selectedRadioButton.getAttribute('data-type');        //Lấy loại voucher

            //Lấy tổng tiền của cart
            var total_price = document.getElementById('total_cart');
            //Lấy thành tiền
            var subtotal = document.getElementById('subtotal');

            //Total
            var totalPriceElm = total_price.getElementsByClassName('cart_amount');
            total_price_value = totalPriceElm[0].textContent.trim();

            //Subtotal
            var subtotalElm = subtotal.getElementsByClassName('cart_amount');
            subtotal_value = subtotalElm[0].textContent.trim();

            //Shipping value
            var ship_value_elm = document.getElementById('receive_deli');
            ship_value = ship_value_elm.textContent.trim();

            var totalPriceNumber = parseFloat(total_price_value.replace(/[.₫]/g, ''));
            var subtotalNumber = parseFloat(subtotal_value.replace(/[.₫]/g, ''));
            var shipValueNumber = parseFloat(ship_value.replace(/[.₫]/g, ''));


            if (temp_subtotal == 0) {
                temp_subtotal = subtotalNumber;
            }
            if (temp_ship_value == 0) {
                temp_ship_value = shipValueNumber;
            }

            if (totalPriceNumber >= voucherMinimum) {
                if (voucherType === "DISCOUNT_DIRECT") {
                    var promotionElement = document.getElementById('promotion_value');

                    promotionElement.innerText = "-" + formatter.format(voucherDiscount);

                    promotionElement.classList.remove("hidden");

                    var new_subtotal = temp_subtotal - voucherDiscount;

                    subtotalElm[0].textContent = formatter.format(new_subtotal);

                    document.getElementById("btn-dimiss-voucher-modal").click();
                } else if (voucherType === "DISCOUNT_PERCENT") {
                    var promotionElement = document.getElementById('promotion_value');

                    //Nếu là giảm theo % sẽ thực hiện
                    //Tính số tiền được giảm
                    var discountValue = (voucherDiscount / 100) * totalPriceNumber;

                    promotionElement.innerText = "-" + formatter.format(discountValue);

                    promotionElement.classList.remove("hidden");

                    var new_subtotal = temp_subtotal - discountValue;

                    subtotalElm[0].textContent = formatter.format(new_subtotal);

                    //Đưa shipping value về default
                    //Tắt free ship
                    var free_ship = document.getElementById("free_ship_promotion");
                    free_ship.classList.add("hidden");
                    free_ship.classList.remove("active");

                    //Bật giá trị
                    //tắt thẻ giá trị
                    ship_value_elm.innerText = formatter.format(temp_ship_value);
                    ship_value_elm.classList.remove("hidden");
                    ship_value_elm.classList.add("active");

                    //tắt thẻ ship giảm giá
                    var promotion_ship = document.getElementById("promotion_ship");

                    //Hiển thị giá trị ban đầu
                    promotion_ship.classList.add("hidden");
                    promotion_ship.classList.remove("active");

                    document.getElementById("btn-dimiss-voucher-modal").click();
                } else if (voucherType === "FREE_SHIPPING") {
                    var promotionElement = document.getElementById('promotion_value');
                    promotionElement.classList.add("hidden");
                    promotionElement.classList.remove("active");

                    //Hiển thị giá trị cũ
                    var promotion_ship = document.getElementById("promotion_ship");

                    //Hiển thị giá trị ban đầu
                    promotion_ship.classList.add("active");
                    promotion_ship.classList.remove("hidden");

                    promotion_ship.innerText = formatter.format(temp_ship_value);

                    //Tính toán
                    var new_ship_value = temp_ship_value - voucherDiscount;

                    if (new_ship_value <= 0) {
                        //Hiện thẻ free-ship
                        var free_ship = document.getElementById("free_ship_promotion");
                        free_ship.classList.add("active");
                        free_ship.classList.remove("hidden");

                        //tắt thẻ giá trị
                        ship_value_elm.classList.remove("active");
                        ship_value_elm.classList.add("hidden");

                        var new_subtotal = temp_subtotal - temp_ship_value;

                        subtotalElm[0].textContent = formatter.format(new_subtotal);
                    } else {
                        //Tắt free ship
                        var free_ship = document.getElementById("free_ship_promotion");
                        free_ship.classList.add("hidden");
                        free_ship.classList.remove("active");

                        //Bật giá trị
                        ship_value_elm.classList.remove("hidden");
                        ship_value_elm.classList.add("active");

                        //Hiển thị giá trị ship mới
                        ship_value_elm.innerText = formatter.format(new_ship_value);

                        var new_subtotal = temp_subtotal - voucherDiscount;

                        subtotalElm[0].textContent = formatter.format(new_subtotal);
                    }

                    document.getElementById("btn-dimiss-voucher-modal").click();
                }
                var subtotal_first = document.getElementById("subtotal_first");
                subtotal_first.innerText = formatter.format(temp_subtotal);
            } else {
                console.log("hhhhh");
            }

            // Thực hiện các thao tác tính toán khác ở đây

        } else {
            // Nếu không có radio button nào được chọn
            console.log("Bạn chưa chọn voucher nào.");
        }
    }
</script>

<%--Xử lý khi web thực hiện xong--%>
<script>
    function capitalizeFirstLetter(string) {
        return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }

    function capitalizeWords(str) {
        return str.split(' ').map(capitalizeFirstLetter).join(' ');
    }

    document.addEventListener("DOMContentLoaded", function () {
        if (localStorage.getItem('cart') !== null) {
            localStorage.removeItem("storeValid");
            addEventClick();
            promise1.then(function (result) {
                var objectData = result.data.data;
                var dataCity = [];
                objectData.forEach(function (data) {
                    dataCity.push({
                        Id: data.PROVINCE_ID,
                        Name: capitalizeWords(data.PROVINCE_NAME)
                    })
                })
                renderCity(dataCity);

                let placeAddress = JSON.parse(localStorage.getItem('placeAddress')) || [];
                placeAddress.forEach(function (content) {
                    if (content.isUse === true) {
                        document.getElementById("animated-text").textContent = content.reminiscentName;
                        document.getElementById('name').value = content.name;
                        document.getElementById('phone').value = content.phone;
                        document.getElementById('addressDetail').value = content.detail;

                        renderAddress(content.city.value, content.district.value, content.ward.value).then(() => {
                            openTab("tab1");
                            getClosestStore().then(a => {
                                const closestStore = JSON.parse(localStorage.getItem("closestStore"));

                                calAllCostShipByTextAddress(closestStore.store.department)
                                    .then(result => {
                                        displayAllService(result);
                                    })
                                    .catch(error => console.log(error));
                            });
                        });
                        return;
                    }
                });
                document.getElementById("animated-text").style.visibility = "visible";
            });

        }
    });

    window.addEventListener('load', function () {
        var messageFromURL = getParameterByName('message');
        if (messageFromURL === "success") {
            showMessage();
        }
        var paymentURL = getParameterByName('payment');
        if (paymentURL === "failed") {
            var h3Element = document.getElementById('cart-sub').querySelector('h3');
            h3Element.textContent = "Hóa đơn thanh toán không thành công";
            h3Element.style.backgroundColor = " #BC3434";
        }

    });
    // if (localStorage.getItem('cart') !== null) {
    //     window.addEventListener('load', function () {
    //         localStorage.removeItem("storeValid");
    //         // Sự kiện click được gắn vào thẻ ul để theo dõi các thẻ li
    //         document.getElementById('ul-address').addEventListener('click', function (event) {
    //             // Kiểm tra xem phần tử được nhấp có phải là thẻ li không
    //             const closestLi = event.target.closest('li');
    //             if (closestLi) {
    //                 // Tìm thẻ input radio trong thẻ li tương ứng
    //                 const radioInput = closestLi.querySelector('input[type="radio"]');
    //                 if (radioInput) {
    //                     // Gọi trực tiếp sự kiện click cho radioInput
    //                     radioInput.click();
    //                     showOrder(0);
    //                 }
    //             }
    //         });
    //
    //         // Sự kiện click được gắn vào thẻ ul để theo dõi các thẻ li
    //         document.getElementById('ul-payment').addEventListener('click', function (event) {
    //             // Kiểm tra xem phần tử được nhấp có phải là thẻ li không
    //             const closestLi = event.target.closest('li');
    //             if (closestLi) {
    //                 // Tìm thẻ input radio trong thẻ li tương ứng
    //                 const radioInput = closestLi.querySelector('input[type="radio"]');
    //                 if (radioInput) {
    //                     // Gọi trực tiếp sự kiện click cho radioInput
    //                     radioInput.click();
    //                 }
    //             }
    //         });
    //         setTimeout(openTab("tab1"),5000);
    //
    //     });
    // }
</script>
</body>

</html>