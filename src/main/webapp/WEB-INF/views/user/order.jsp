<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <title>Đơn hàng</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <!-- CSS
        ========================= -->

    <!-- Plugins CSS -->
    <link rel="stylesheet" href="/assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="/assets/css/style.css">
    <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/favicon.ico">
    <style>
        .wait-product{
            padding-left: 10px;
            border-left: 1px solid black;
            color: blue!important;
        }
        .wait-quantity{
            padding-right: 10px;
        }
        .input-group input{
            font-family: Emoji;
        }
        .order {
            font-family: Emoji;
        }

        .info-store {
            display: flex;
            font-size: 16px;
            color: black;
            padding: 15px 15px 3px 15px;
        }

        .info-store .name {
            flex: 1;
            font-family: Helvetica;
        }

        .order {
            /*padding: 15px;*/
            background-color: white;
            margin-bottom: 15px;
        }

        .product {
            display: flex;
            padding-bottom: 10px;
            border-bottom: 1px solid #F2ECEC;
            margin-top: 15px;
        }

        .products {
            padding: 0 15px;
        }

        .info {
            margin-left: 10px;
            flex: 1;
        }

        .flex {
            display: flex;
            width: 100%;
        }

        .money {
            justify-content: space-between; /* Các phần tử con sẽ được đặt ở hai đầu */
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        .info-detail {
            padding: 30px 15px 10px 5px;
            display: flex;
            flex-direction: column; /* Sắp xếp theo chiều dọc */
            align-items: flex-end; /* Căn phải */
        }

        .product span {
            font-size: 14px;
            color: black;
        }

        .price {
            font-size: 18px;
        }

        .info-detail h4 {
            font-size: 18px;
        }

        .info-detail h4 span {
            color: red;
            font-size: 20px;
        }

        .info-detail {
            background-color: #FFFCF8;
        }

        .checkout_form {
            margin-top: 12px;
        }

        .checkout_form button {
            padding: 8px 20px;
            min-width: 120px;
            min-height: 40px;
            border-radius: 2px;
            font-size: 16px;
            margin-left: 10px;
            color: white;
            border: 1px solid;
            background-color: black;
        }

        .checkout_form button:hover {
            background-color: #ff6a28;
            color: white;
            cursor: pointer;
        }

        .card-body ul {
            background-color: white;
        }

        .page {
            margin: 0;
            background-color: #F3F3F3;
            padding: 10px 200px 50px 200px;
        }

        .card-body {
            padding-top: 0;
        }

        .nav-bar {
            background-color: white;
            font-size: 16px;
            font-weight: bold;
            color: black;
            font-family: Helvetica;
        }

        .nav-tabs .nav-link.active {
            border-radius: 0;
            border: none;
            border-bottom: 2px solid #ff6a28;
            color: #ff6a28;
        }

        .input-group {
            margin: 0px 0 10px 0;
        }

        .nav-tabs .nav-link {
            background-color: white;
        }

        .solid {
            border-bottom: 1px solid #F2ECEC;
        }

        .info-status {
            font-size: 18px;
        }

        .price span {
            margin-left: 10px;
        }

        .modal-body h4 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            color: #ff6a28;
            font-weight: 500;
        }

        .form-dialog {
            font-family: emoji;
            font-size: 16px;
            color: black;
        }

        .form-dialog label {
            font-weight: 600;
            margin-bottom: 3px;
        }

        .form-dialog textarea {
            width: 100%;
        }
        .pagination{
            justify-content: flex-end;
        }
        .pagination.listPage{
            background-color: transparent;
        }
        .pagination ul li{
            background-color: white;
            color: black;
        }
        .pagination ul li:hover{
            cursor: pointer;
            background: #ff6a28;
            color: #ffffff;
        }
        .pagination ul li .active{
            background: #ff6a28;
            color: #ffffff;
        }
        .products:hover{
            cursor: pointer;
            border: 2px solid transparent;
        }

        .product:hover span{
            color: #ff6a28!important;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="page">
    <div class="col-12">
        <div class="card recent-sales overflow-auto" style="border: none;background-color: #F3F3F3">
            <div class="card-body">
                <div class="nav-bar">
                    <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist"
                        onclick="handlePage()">
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100 active" id="all-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-all" type="button" role="tab"
                                    aria-controls="home" aria-selected="true">Tất cả
                            </button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="already-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-already" type="button" role="tab"
                                    aria-controls="contact" aria-selected="false">Nhận tại cửa hàng
                            </button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="prepare-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-prepare" type="button" role="tab"
                                    aria-controls="profile" aria-selected="false">Chuẩn bị
                            </button>
                        </li>

                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="delivery-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-delivery" type="button" role="tab"
                                    aria-controls="contact" aria-selected="false">Giao hàng
                            </button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="complete-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-complete" type="button" role="tab"
                                    aria-controls="contact" aria-selected="false">Hoàn thành
                            </button>
                        </li>
                        <li class="nav-item flex-fill" role="presentation">
                            <button class="nav-link w-100" id="cancel-tab" data-bs-toggle="tab"
                                    data-bs-target="#bordered-justified-cancel" type="button" role="tab"
                                    aria-controls="contact" aria-selected="false">Hủy
                            </button>
                        </li>
                    </ul>
                </div>

                <div class="tab-content pt-2" id="borderedTabJustifiedContent">
                    <div class="tab-pane fade show active" id="bordered-justified-all" role="tabpanel"
                         aria-labelledby="all-tab">
                        <div class="input-group">
                            <input type="search"
                                   id="input-search"
                                   class="form-control rounded"
                                   placeholder="Tìm kiếm đơn hàng theo tên sản phẩm và địa chỉ cửa hàng..."
                                   aria-label="Search"
                                   aria-describedby="search-addon"
                                   value="${not empty keyword ? keyword : ''}" />
                            <button type="button" class="btn btn-outline-primary" id="order-search" data-mdb-ripple-init><i
                                    class="fas fa-search"></i></button>
                        </div>
                        <c:forEach var="order"
                                   items="${orders}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>

                                    </c:choose>

                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="tab-pane fade" id="bordered-justified-prepare" role="tabpanel"
                         aria-labelledby="prepare-tab">
                        <c:forEach var="order"
                                   items="${ordersTabPrepare}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                    <div class="tab-pane fade" id="bordered-justified-already" role="tabpanel"
                         aria-labelledby="already-tab">
                        <c:forEach var="order"
                                   items="${ordersService.findOrdersByAccountReceive(account.id)}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - Địa
                                            chỉ: ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="tab-pane fade" id="bordered-justified-delivery" role="tabpanel"
                         aria-labelledby="delivery-tab">
                        <c:forEach var="order"
                                   items="${ordersRepository.findOrdersByAccountAndStatus(account.id,'DELIVERY')}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="tab-pane fade" id="bordered-justified-complete" role="tabpanel"
                         aria-labelledby="complete-tab">
                        <c:forEach var="order"
                                   items="${ordersRepository.findOrdersByAccountAndStatus(account.id,'COMPLETE')}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="tab-pane fade" id="bordered-justified-cancel" role="tabpanel"
                         aria-labelledby="cancel-tab">
                        <c:forEach var="order"
                                   items="${ordersRepository.findOrdersByAccountAndStatus(account.id,'CANCEL')}">
                            <div class="order">
                                <div class="solid">
                                    <div class="info-store">
                                        <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>
                                        <div>
                                            <div class="info-status">
                                                <c:choose>
                                                    <c:when test="${order.status =='COMPLETE'}">
                                                        <i class="fas fa-truck" style="color: green"></i>
                                                        <span style="color: green">Đơn hàng đã được giao thành công</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: #F6821C">HOÀN THÀNH</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                                        <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='ALREADY'}">
                                                        <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                                                    </c:when>
                                                    <c:when test="${order.status =='DELIVERY'}">
                                                        <i class="fas fa-truck" style="color: orange"></i>
                                                        <span style="color: coral">Đơn hàng đang được giao</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: red">Đơn hàng đã được hủy</span>
                                                        <span style="padding-left: 5px; border-left: 2px solid black; color: red">HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="solid">
                                    <div class="products" onclick="detail(${order.id})">
                                        <c:forEach items="${order.productOutOfStocks}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.color.id,item.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.color.color_name}, ${item.size.size}</span><br>
                                                    <div class="flex money">
                                                        <div><span class="wait-quantity">x${item.quantity}</span> <span class="wait-product">Chờ nhập hàng</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <div class="product">
                                                <div><img
                                                        src="${imageRepository.findAllByProductAndColor(item.inventory.color.id,item.inventory.size.product.id)[0].img}"
                                                        style="width: 90px"></div>
                                                <div class="info">
                                                    <span>${item.inventory.size.product.name}</span><br>
                                                    <span>Phân loại: ${item.inventory.color.color_name}, ${item.inventory.size.size}</span><br>
                                                        <div class="flex money">
                                                        <div><span>x${item.quantity}</span></div>
                                                        <div><span
                                                                style="color:red">${formatVND.format(item.price)}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-detail">
                                    <div class="price">
                                        <h4>Thành tiền:<span>${formatVND.format(order.totalPrice+order.delivery.cost-order.voucherValue)}</span>
                                        </h4>
                                    </div>
                                    <c:choose>
                                        <c:when test="${order.status =='COMPLETE' && evaluateRepository.checkExits(order).size()<=0}">
                                            <div class="checkout_form">
                                                <button data-toggle="modal" data-target="#modal-dialog"
                                                        onclick="getOrder(${order.id})">Đánh giá
                                                </button>
                                                <button onclick="repurchase(${order.id})">Mua lại</button>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status =='PREPARE' || order.status =='WAIT' || order.status =='ALREADY'}">
                                            <div class="checkout_form">
                                                <button onclick="cancel(${order.id})">Hủy</button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
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
<!-- Plugins JS -->

<jsp:include page="footer.jsp"/>

<div class="modal" id="modal-dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal"
                    aria-label="Close" style="left: 91%;">
                <span aria-hidden="true">&times;</span>
            </button>
            <div class="modal-body">
                <div><h4>Đánh Giá Sản Phẩm</h4></div>
                <form action="" method="post" class="form-dialog" id="form-evaluate">
                    <div>
                        <label for="rating">Chất lượng sản phẩm:</label><br>
                        <select id="rating" name="rate" style="width: 100%">
                            <option value="5">5 sao - Tuyệt vời</option>
                            <option value="4">4 sao - Hài lòng</option>
                            <option value="3">3 sao - Bình thường</option>
                            <option value="2">2 sao - Không hài lòng</option>
                            <option value="1">1 sao - Tệ</option>
                        </select>
                    </div>
                    <div>
                        <label for="comment">Bình luận:</label><br>
                        <textarea id="comment" name="comment" rows="5" placeholder="Nhập bình luận của bạn"></textarea>
                    </div>
                    <button type="submit" class="btn btn-info">Gửi đánh giá</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/admin/assets/vendor/tinymce/tinymce.min.js"></script>
<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
<%--// Phan trang--%>
<script>

    // Xử lý phân trang
    let thisPage = 1;
    let limit = 3;
    let list = document.querySelectorAll('.tab-pane.active .order');
    function reLoadItem() {
        list = document.querySelectorAll('.tab-pane.active .order');
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

    function listPage() {
        let count = Math.ceil(list.length / limit);
        console.log(count);
        document.querySelector('.listPage').innerHTML = '';
        if (count >1) {
            if (thisPage != 1) {
                let prev = document.createElement('li');
                let icon = document.createElement('i');
                icon.classList.add('fas', 'fa-angle-double-left');
                prev.appendChild(icon);
                prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
                document.querySelector('.listPage').appendChild(prev);
            }

            if (thisPage != count) {
                let next = document.createElement('li');
                let icon = document.createElement('i');
                icon.classList.add('fas', 'fa-angle-double-right');
                next.appendChild(icon);
                next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
                document.querySelector('.listPage').appendChild(next);
            }

            for (let i = 1; i <= count; i++) {
                let newPage = document.createElement('li');
                newPage.innerText = i;
                if (i == thisPage) {
                    newPage.classList.add('active');
                }
                newPage.setAttribute('onclick', "changePage(" + i + ")");
                document.querySelector('.listPage').appendChild(newPage);
            }
        }
    }

    function changePage(i) {
        thisPage = i;
        loadItem();
    }

    function handlePage() {
        thisPage = 1;
        list = document.querySelectorAll('.tab-pane.active .order');
        loadItem();
    }

    handlePage();

</script>
<script>
    function cancel(id) {
        $.ajax({
            url: "/orders/update/" + id,
            type: "POST",
            success: function () {
                window.location.reload();
            }
        });
    }
    function repurchase(id){
        $.ajax({
            url: "/orders/repurchase/" + id,
            type: "Get",
            success: function (response) {
                console.log(response);
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                response.forEach(function (data){
                    cart.push(data);
                })
                localStorage.setItem('cart',JSON.stringify(cart));
                window.location.href = "/cart";
            }
        });
    }
    function getOrder(id) {
        document.getElementById('form-evaluate').action = "/orders/evaluate/" + id;
    }


    window.addEventListener('load',function (){
        function tranferLink(){
            var input = document.getElementById('input-search').value;
            if(input===null || input==='')
                window.location.href = '/orders';
            else
                window.location.href = '/orders/search?keyword='+document.getElementById('input-search').value;
        }
        document.getElementById('input-search').addEventListener('keydown',function (event){
            if (event.key === "Enter") {
                tranferLink();
            }
        });
       document.getElementById('order-search').addEventListener('click',function (){
           tranferLink();
       });

    });
    function detail(id){
        location.href = "/orders/"+id;
    }
</script>

</body>