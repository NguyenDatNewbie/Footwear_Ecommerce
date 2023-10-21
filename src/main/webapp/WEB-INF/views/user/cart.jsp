<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Cart page</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="assets/img/favicon.ico">

    <!-- CSS
        ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body>
<!-- Header Section Begin-->
<jsp:include page="header.jsp" />
<!-- Header Section End -->

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
        <form action="./pay" method="post" id="form-cart">
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
                                <tbody>
                                <c:forEach items="${listCart}" var="cartItem">
                                    <c:set var="item" scope="session"
                                           value="${productDAO.getProduct(cartItem.productId)}" />
                                    <tr>
                                        <td class="product_remove"
                                            onclick="deleteItem(${cartItem.id})"><a><i
                                                class="fa fa-trash-o"></i></a></td>
                                        <td class="product_thumb"><a href="#"><img
                                                style="width: 120px"
                                                src="${ImagesDAO.getByProductId(item.id).img}" alt=""></a></td>
                                        <td class="product_name"><a href="#">${item.name}</a></td>
                                        <td class="product-price"><c:out
                                                value="${item.price - item.price*item.promotion/100}" /></td>
                                        <td class="product_quantity"><input min="1" max="100"
                                                                            value="${cartItem.count}" type="number" name="quantity"
                                                                            onchange="load(this.value,${cartItem.id})"></td>
                                        <td class="product_total"><c:out
                                                value="${(item.price - item.price*item.promotion/100)*cartItem.count}" /></td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                        <div class="cart_submit">
                            <a class="button" href="./shop">Tiếp tục mua sắm</a>
                        </div>
                    </div>
                </div>
            </div>

            <!--coupon code area start-->
            <div class="coupon_area">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="coupon_code left">
                            <h3>Thông tin giao hàng</h3>
                            <div class="coupon_inner">
                                <input placeholder="Địa chỉ giao hàng" name="address" id="address"
                                       type="text" required> <input
                                    placeholder="Số điện thoại nhận hàng" name="phone" type="text" id="phone"
                                    required>

                                <div class="product_variant size"
                                     style="margin-top: 15px; margin-bottom: 0px;">
                                    <h3 style="background: white; margin-right: 117px;">Chi
                                        nhánh</h3>
                                    <select class="select_option" id="store" name="storeId">
                                        <c:forEach items="${storeDAO.getAll()}" var="store">
                                            <option value="${store.id}">${store.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6">
                        <div class="coupon_code right" id="cart-sub">
                            <h3>Hóa đơn</h3>
                            <div class="coupon_inner">
                                <div class="cart_subtotal">
                                    <p>Tổng tiền</p>
                                    <p class="cart_amount">${cartItemDAO.TotalPrice(cart)}</p>
                                </div>
                                <div class="cart_subtotal" id="price_deli">
                                    <p>Phí giao hàng</p>
                                    <p class="cart_amount">30000.00</p>
                                </div>
                                <div class="cart_subtotal">
                                    <p>Đơn vị vận chuyển</p>
                                    <select class="select_option" id="deliveryOption" name="deliveryId"
                                            onchange="changeDeli(this)">
                                        <c:forEach items="${iDeliveryDAO.getAll()}" var="delivery">
                                            <option value="${delivery.id}">${delivery.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="cart_subtotal" style="margin-top: 12px;" id="subtotal">
                                    <p>Thành tiền</p>
                                    <c:choose>
                                        <c:when test="${cartItemDAO.TotalPrice(cart)!=0}">
                                            <p class="cart_amount">${cartItemDAO.TotalPrice(cart)+30000}VNĐ</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="cart_amount">0VNĐ</p>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                                <div class="checkout_btn">
                                    <button type="submit">Thanh toán</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--coupon code area end-->

        </form>
    </div>
</div>
<!-- shopping cart area end -->


<!--footer area start-->
<jsp:include page="footer.jsp" />
<!--footer area start-->
<!-- JS
============================================ -->


<!--map js code here-->
<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdWLY_Y6FL7QGW5vcO3zajUEsrKfQPNzI"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="assets/js/map.js"></script>


<!-- Plugins JS -->
<script src="assets/js/plugins.js"></script>

<!-- Main JS -->
<script src="assets/js/main.js"></script>

<script>
    function load(quantity,id) {
        var store = document.getElementById("store").value;
        var deliveryOption = document.getElementById("deliveryOption").value;
        var address = document.getElementById("address").value;
        var phone = document.getElementById("phone").value;
        $.ajax({
            url : "./loadCart",
            type : "get",
            data : {
                quantity : quantity,
                id: id,
                store: store,
                deliveryOption: deliveryOption,
                address: address,
                phone: phone
            },
            success : function(data) {
                var row = document.getElementById("form-cart");
                row.innerHTML = data;

            },
            error : function(xhr) {
            }
        });

    };

    function changeDeli(obj) {
        var id = obj.value;
        $.ajax({
            url : "./loadDeli",
            type : "get",
            data : {
                id: id
            },
            success : function(data) {
                var row = document.getElementById("cart-sub");
                row.innerHTML = data;
            },
            error : function(xhr) {
            }
        });
    };






    function deleteItem(id) {
        var store = document.getElementById("store").value;
        var deliveryOption = document.getElementById("deliveryOption").value;
        var address = document.getElementById("address").value;
        var phone = document.getElementById("phone").value;
        $.ajax({
            url : "./delete",
            type : "get",
            data : {
                id: id,
                store: store,
                deliveryOption: deliveryOption,
                address: address,
                phone: phone
            },
            success : function(data) {
                var row = document.getElementById("form-cart");
                row.innerHTML = data;
            },
            error : function(xhr) {
            }
        });
    };
</script>

</body>

</html>