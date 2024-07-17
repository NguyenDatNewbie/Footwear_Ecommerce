<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <!-- CSS
        ========================= -->
    <link rel="stylesheet" href="/assets/css/stepper.css">

    <!-- Plugins CSS -->
    <link rel="stylesheet" href="/assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="/assets/css/style.css">
    <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="/assets/img/favicon.ico">
    <style>
        .back{
            font-size: 16px;
            font-weight: 500;
            flex: 1;
        }
        .title{
            display: flex;
            width: 100%;
            font-size: 18px;
            font-family: Emoji;
            color: #242424;
        }
        .order-id{
            flex: 1;
            text-align: end;
        }
        .order-id span:first-child{
            padding-right: 3px;
            margin-right: 3px ;
        }
        .stepper li span{
            font-size: 16px;
        }
        .status{
            margin: 45px 0 65px;
        }
        .container .content{
            color: #242424;
        }
        .border-order{
            background-image: repeating-linear-gradient(45deg, #6fa6d6, #6fa6d6 33px, transparent 0, transparent 41px, #f18d9b 0, #f18d9b 74px, transparent 0, transparent 82px);
            background-position-x: -1.875rem;
            background-size: 7.25rem .1875rem;
            height: .1875rem;
            width: 100%;
        }
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

        /*.info-detail {*/
        /*    padding: 30px 15px 10px 5px;*/
        /*    display: flex;*/
        /*    flex-direction: column; !* Sắp xếp theo chiều dọc *!*/
        /*    align-items: flex-end; !* Căn phải *!*/
        /*}*/

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

        .individual{
           padding: 15px 30px 3px 30px;
        }
        .individual .title{
            font-size: 18px;
            font-weight: 600;
            font-family: Helvetica;
            line-height: 28px;
        }
        .individual .order-id span{
            font-size: 12px;
            text-align: right;
            word-wrap: break-word;
            color: rgba(0, 0, 0, .54);
            border: none;
            margin: 0;
            padding: 0;
            line-height: 14px;
            font-weight: 500;
        }
        .address{
            width: 30%;
            padding-right: 20px;
            border-right: 1px solid;
            font-family: EMOJI;
        }
        .information{display: flex}
        .address p {
            margin-top: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: bold;
        }
        .address span{
            font-size: 12px;
        }
        .vertical ol.stepper {
            display: grid;
            gap: 20px;
            background:
                    linear-gradient(var(--default-b) 0 0) no-repeat
                    calc((var(--circle-vertical) - 2px) / 2) 50% / 2px 100%;
            margin-bottom: 8px;
        }
        .vertical ol.stepper li i::before{
            height: var(--circle-vertical);
        }
        .vertical ol.stepper li i{
            font-size: 12px;
        }
        .vertical ol.stepper li {
            display: flex;
        }
        .vertical ol.stepper li.active::after {
            content: none;
        }
        .vertical ol.stepper span {
            font-size: 12px;
            font-weight: unset;
            color: rgba(0, 0, 0, .54);;
        }
        .vertical ol.stepper span:first-of-type{
            margin-right: 5px;
            color: #242424;
            margin-left: 10px;
        }
        .vertical ol.stepper span:last-child{
            margin-right: 5px;
        }
        #showMoreButton,#hiddenButton {
            display: none;
            border: none;
            background: none;
            color: #05a;
            font-weight: 400;
            padding-left: 25px;
        }
        .info-row{
            align-items: center;
            border-bottom: 1px dotted rgba(0, 0, 0, .09);
            display: flex;
            justify-content: flex-end;
            padding: 0 24px;
            text-align: right;
            font-family: Helvetica;
            background-color: #fafafa;
        }
        .subject{
            color: rgba(0, 0, 0, .54);
            font-size: 12px;
            padding: 13px 10px;
        }
        .detail{
            border-left: 1px dotted rgba(0, 0, 0, .09);
            justify-content: flex-end;
            padding: 13px 0 13px 10px;
            width: 240px;
            word-wrap: break-word;
            color: rgba(0, 0, 0, .8);
            font-size: 14px;
        }
        .back:hover{
            cursor: pointer;
            color: #ff6a28;
        }
        .back{
            user-select: none;
        }
        .container{
            margin-top: 30px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="content">
        <div class="title">
            <div class="back">
                <i class="fas fa-chevron-left" style="margin-right: 5px"></i><span>Trở lại</span>
            </div>
            <div class="order-id">
                <div style="display: flex; justify-content: flex-end">
                    <div>
                        <span>Mã đơn hàng: <strong>#${order.id}</strong></span>
                    </div>
                    <div style="padding-right: 7px; transform: translateY(52%); height: 12px; margin-right: 7px; border-right: 2px solid black"></div>
                    <div class="info-status">
                        <c:choose>
                            <c:when test="${order.status =='COMPLETE'}">
                                <span style="color: green">Đơn hàng đã được giao thành công</span>
                            </c:when>
                            <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">
                                <span style="color: blue">Đơn hàng đang đuợc xử lý</span>
                            </c:when>
                            <c:when test="${order.status =='ALREADY'}">
                                <span style="color: blue">Đơn hàng đã được chuẩn bị xong</span>
                            </c:when>
                            <c:when test="${order.status =='DELIVERY'}">
                                <span style="color: coral">Đơn hàng đang được giao</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: red">Đơn hàng đã được hủy</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
<%--                     <c:choose>--%>
<%--                         <c:when test="${order.status =='COMPLETE'}">--%>
<%--                             <span>Mã đơn hàng: ${order.id}</span>--%>
<%--                             <span>Đơn hàng đã được giao thành công</span>--%>
<%--                         </c:when>--%>
<%--                         <c:when test="${order.status =='PREPARE' || order.status =='WAIT'}">--%>
<%--                             <span>Mã đơn hàng: ${order.id}</span>--%>
<%--                             <span>Đơn hàng đang đuợc xử lý</span>--%>
<%--                         </c:when>--%>
<%--                         <c:when test="${order.status =='ALREADY'}">--%>
<%--                             <span>Mã đơn hàng: ${order.id}</span>--%>
<%--                             <span>Đơn hàng đã được chuẩn bị xong</span>--%>
<%--                         </c:when>--%>
<%--                         <c:when test="${order.status =='DELIVERY'}">--%>
<%--                             <span>Mã đơn hàng: ${order.id}</span>--%>
<%--                             <span>Đơn hàng đang được giao</span>--%>
<%--                         </c:when>--%>
<%--                         <c:otherwise>--%>
<%--                             <span>Mã đơn hàng: ${order.id}</span>--%>
<%--                             <span style="color: red">Đơn hàng đã được hủy</span>--%>
<%--                         </c:otherwise>--%>
<%--                     </c:choose>--%>
            </div>
        </div>
        <div class="status">
            <ol class="stepper">
                <li><i class="fas fa-file-alt"></i><span>${order.createdAt}</span><span>Đặt hàng</span></li>
                <li id="wait"><i class="fas fa-dolly-flatbed"></i><span> Chuẩn bị hàng</span></li>
                <li id="already"><i class="fas fa-box"></i><span>Đã chuẩn bị xong</span></li>
                <li id="delivery"><i class="fas fa-shipping-fast"></i><span>Vận chuyển</span></li>
                <li id="complete"><i class="fas fa-clipboard-check"></i><span>Đã giao</span></li>
            </ol>
        </div>
        <div>
            <div class="border-order"></div>
            <div class="individual">
                <div class="title">
                    <div><span>Địa chỉ nhận hàng</span></div>
                    <div class="order-id"><span>SPX Express</span><br><span>SPXVN03021380777B</span></div>
                </div>
                <div class="information">
                    <div class="address">
                        <p>${order.name}</p>
                        <span>SDT: ${order.phone}</span>
                        <br>
                        <span>Địa chỉ: ${order.address}</span>
                    </div>
                    <div class="delivery">
                        <div class="vertical">
                            <ol class="stepper">
                                <li class="active"><i class="fas fa-truck"></i><span>12:00 03-03-2024</span><span style="color: var(--active-b)">Đơn hàng đã được giao thành công</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng đã đến kho 3</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng đã đến kho 2</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng đã đến kho 1</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng chuyển đến đơn vị vận chuyển</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng đã đến kho 1</span></li>
                                <li ><i class="fas fa-dot-circle"></i><span>08:10 02-03-2024</span><span>Đơn hàng đã đến kho 1</span></li>
                                <li ><i class="far fa-calendar"></i><span>08:10 02-03-2024</span><span>Đặt hàng thành công</span></li>
                            </ol>
                            <button id="showMoreButton">Xem thêm</button>
                            <button id="hiddenButton">Rút gọn</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="products">
                <div class="order">
                    <div class="solid">
                        <div class="info-store">
                            <div class="name"><h4>Chi nhánh ${order.store.id} - ${order.store.department}</h4></div>

                        </div>
                    </div>
                    <div class="solid">
                        <div class="products">
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
                        <div class="info-row">
                            <div class="subject"><span>Tổng tiền hàng</span></div>
                            <div class="detail">
                                <div>${formatVND.format(order.totalPrice)}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="subject"><span>Phí vận chuyện</span></div>
                            <div class="detail">
                                <div>${formatVND.format(order.delivery.cost == null ? 0 : order.delivery.cost)}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="subject"><span>Giảm giá từ voucher</span></div>
                            <div class="detail">
                                <div>${formatVND.format(order.voucherValue)}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="subject"><span>Thành tiền</span></div>
                            <div class="detail">
                                <div style="color: red; font-size: 16px">${formatVND.format(order.totalPrice+(order.delivery.cost == null ? 0 : order.delivery.cost) -order.voucherValue)}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="subject"><span>Phương thức thanh toán</span></div>
                            <div class="detail">
                                <div>
                                    <c:choose>
                                        <c:when test="${order.paymentType == 'RECEIVE'}">
                                            Thanh toán khi nhận hàng
                                        </c:when>
                                        <c:when test="${order.paymentType == 'VNPAY'}">
                                            Vnpay
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>

<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var showMoreButton = document.getElementById("showMoreButton");
        var liItems = document.querySelectorAll(".vertical .stepper li");
        var hiddenButton = document.getElementById("hiddenButton");
        var back = document.querySelector(".back");

        // Chỉ hiển thị 4 mục đầu tiên
        for (var i = 0; i < liItems.length; i++) {
            if (i >= 4) {
                liItems[i].style.display = "none";
            }
        }

        // Hiển thị nút "Xem thêm" khi có nhiều hơn 4 mục
        if (liItems.length > 4) {
            showMoreButton.style.display = "block";
        }

        // Xử lý sự kiện khi nhấp vào nút "Xem thêm"
        showMoreButton.addEventListener("click", function() {
            // Hiển thị tất cả các mục khi nhấp vào nút "Xem thêm"
            for (var i = 0; i < liItems.length; i++) {
                liItems[i].style.display = "flex";
            }
            // Ẩn nút "Xem thêm" sau khi đã hiển thị tất cả các mục
            showMoreButton.style.display = "none";
            hiddenButton.style.display = "block";
        });

        // Xử lý sự kiện khi nhấp vào nút "Xem thêm"
        hiddenButton.addEventListener("click", function() {
            for (var i = 0; i < liItems.length; i++) {
                if (i >= 4) {
                    liItems[i].style.display = "none";
                }
            }
            // Ẩn nút "Xem thêm" sau khi đã hiển thị tất cả các mục
            showMoreButton.style.display = "block";
            hiddenButton.style.display = "none";
        });

        back.addEventListener("click", function() {
            location.href = "/orders";
        });

        function orderState(state){
            // console.log(state);
            if(state == "ALREADY")
                document.getElementById("already").classList.add("active");
            else if(state == "DELIVERY")
                document.getElementById("delivery").classList.add("active");
            else if(state == "COMPLETE")
                document.getElementById("complete").classList.add("active");
            else
                document.getElementById("wait").classList.add("active");
        }
        orderState("${order.status}");

    });

</script>
</body>
</html>
