<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="now" value="<%= new java.util.Date() %>"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Reid - Admin</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/admin/assets/img/favicon.png" rel="icon">
    <link href="/admin/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/admin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/admin/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/admin/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">

    <style>
        .card-body-title {
            padding: 0px 20px 0px 20px;
        }

        .content-header {
            margin-left: 15px;
            display: flex;
            align-items: center;
        }

        .create-title {
            margin-top: 20px;
            margin-bottom: 2px;
            font-weight: 650;
        }

        .header-dsc {
            margin-left: 15px;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp"/>
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/home"/>">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/products"/>">
                <i class="bi bi-shop"></i>
                <span>Products</span>
            </a>
        </li><!-- End Order Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/order"/>">
                <i class="bi bi-journal-text"></i>
                <span>Orders</span>
            </a>
        </li><!-- End Order Page Nav -->
        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/admin/voucher"/>">
                <i class="bi bi-gift"></i>
                <span>Voucher</span>
            </a>
        </li><!-- End Category Page Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/stores"/>">
                <i class="bi bi-diagram-3"></i>
                <span>Stores</span>
            </a>
        </li><!-- End Category Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/account"/>">
                <i class="bi bi-person"></i>
                <span>Accounts</span>
            </a>
        </li><!-- End Account Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/categories"/>">
                <i class="bi bi-card-list"></i>
                <span>Categories</span>
            </a>
        </li><!-- End Category Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/posts"/>">
                <i class="bi bi-file-earmark-word"></i>
                <span>Posts</span>
            </a>
        </li><!-- End Category Page Nav -->
    </ul>

</aside><!-- End Sidebar-->

<main id="main" class="main">
    <div class="pagetitle">
        <h1>Voucher Detail</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
                <li class="breadcrumb-item"><a href="<c:url value="/admin/voucher"/>">Voucher</a></li>
                <li class="breadcrumb-item active">Voucher Detail</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section">
        <div class="row">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <form class="row g-3" action="<c:url value="/admin/voucher/updateVoucher"/> " method="post">
                                <div class="col-md-12">
                                    <input hidden="hidden" type="text" class="form-control" placeholder="Product ID" value="${voucher.id}" id="id" name="id">
                                </div>
                                <div class="col-md-6">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Title</span>
                                    <input type="text" class="form-control" id="inputTitle" name="title" value="${voucher.title}">
                                </div>
                                <div class="col-md-6">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Voucher Code</span>
                                    <input type="text" class="form-control" id="inputCode" style="text-transform:uppercase" maxlength="15" required oninput="validateInput(this)" name="voucherCode" value="${voucher.voucherCode}">
                                </div>
                                <div class="col-md-6">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Discount Value</span>
                                    <input type="number" class="form-control" id="inputDiscount" required oninput="checkNegativeInput(this)" min="0" name="discountValue" value="${voucher.discountValue}">
                                    <div id="discountErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                </div>
                                <div class="col-md-4">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Voucher Type</span>
<%--                                    <select id="inputType" class="form-select" name="voucherType">--%>
<%--                                        <option selected value="DISCOUNT_DIRECT" id="discountDirect" >Discount direct</option>--%>
<%--                                        <option value="DISCOUNT_PERCENT" id="discountPercent">Discount percent</option>--%>
<%--                                        <option value="FREE_SHIPPING" id="freeShip">Free ship</option>--%>
<%--                                    </select>--%>
                                    <select id="inputType" class="form-select" name="voucherType">
                                        <c:forEach items="${['DISCOUNT_DIRECT', 'DISCOUNT_PERCENT', 'FREE_SHIPPING']}" var="type">
                                            <option value="${type}" ${voucher.voucherType == type ? 'selected' : ''}>
                                                <c:out value="${type}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Quantity</span>
                                    <input type="number" class="form-control" id="inputQuantity" required min="1" name="quantity" value="${voucher.quantity}">
                                </div>
                                <div class="col-md-4">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Minimum Value</span>
                                    <input type="number" class="form-control" id="inputMinimumValue" required min="0" oninput="checkNegativeInputMinimum(this)" name="minimumValue" value="${voucher.minimumValue}">
                                    <div id="minimumErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                </div>
                                <div class="col-md-4">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Max Discount</span>
                                    <input type="number" class="form-control" id="inputMaxDiscount" required min="0" oninput="checkNegativeInputMaxdiscount(this)" name="maxDiscount" value="${voucher.maxDiscount}">
                                    <div id="maxDiscountErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                </div>
                                <div class="col-md-4">
                                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Expiration Date</span>
                                    <input type="date" class="form-control" id="inputExpirationDate" required name="expirationDateFormatYet" value="${voucher.expirationDate}">
                                </div>
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea class="form-control" placeholder="Description" id="inputDescription" style="height: 100px;" name="description">${voucher.description}</textarea>
                                        <label for="inputDescription">Description</label>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="reset" class="btn btn-secondary" id="listVoucherBtn">Cancel</button>
                                    <button type="submit" class="btn btn-success">Update Voucher</button>
                                </div>
                            </form><!-- End Multi Columns Form -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main><!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/admin/assets/vendor/chart.js/chart.umd.js"></script>
<script src="/admin/assets/vendor/echarts/echarts.min.js"></script>
<script src="/admin/assets/vendor/quill/quill.min.js"></script>
<script src="/admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="/admin/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="/admin/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="/admin/assets/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

<script>
    document.getElementById('listVoucherBtn').addEventListener('click', function () {
        window.location.href = "/admin/voucher";
    });
    function validateInput(event) {
        const input = event.target.value;
        const regex = /^[a-zA-Z0-9]*$/; // Regex cho phép chữ cái và số

        if (!regex.test(input)) {
            // Nếu input không phù hợp với regex, loại bỏ ký tự không hợp lệ
            event.target.value = input.replace(/[^a-zA-Z0-9]/g, '');
        }
    }
</script>
<script>
    function checkNegativeInput(inputElement) {
        var inputValue = parseFloat(inputElement.value);
        var errorMessageElement = inputElement.id === "inputDiscount" ? document.getElementById("discountErrorMessage") : document.getElementById("quantityErrorMessage");

        if (inputValue < 0) {
            errorMessageElement.style.display = "block";
        } else {
            errorMessageElement.style.display = "none";
        }
    }
    function checkNegativeInputMinimum(inputElement) {
        var inputValue = parseFloat(inputElement.value);
        var errorMessageElement = inputElement.id === "inputMinimumValue" ? document.getElementById("minimumErrorMessage") : document.getElementById("quantityErrorMessage");

        if (inputValue < 0) {
            errorMessageElement.style.display = "block";
        } else {
            errorMessageElement.style.display = "none";
        }
    }

    function checkNegativeInputMaxdiscount(inputElement) {
        var inputValue = parseFloat(inputElement.value);
        var errorMessageElement = inputElement.id === "inputMaxDiscount" ? document.getElementById("maxDiscountErrorMessage") : document.getElementById("quantityErrorMessage");

        if (inputValue < 0) {
            errorMessageElement.style.display = "block";
        } else {
            errorMessageElement.style.display = "none";
        }
    }
    function convertToUppercase(input) {
        input.value = input.value.toUpperCase();
    }

</script>
<script type="text/javascript">
    $(document).ready(function() {
        var showAlert = "<c:out value='${showAlert}' />"; // Sử dụng dấu nháy đơn trong giá trị value

        if (showAlert === "true") {
            // Hiển thị alert
            $('.alert').addClass('show');
        }
    });
</script>
</body>

</html>