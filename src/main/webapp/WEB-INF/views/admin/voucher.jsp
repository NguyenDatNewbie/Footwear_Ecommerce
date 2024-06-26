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
        <h1>Voucher Reid-Shop Manager</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
                <li class="breadcrumb-item active">Voucher</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    <section class="section">
        <div class="row">
            <!-- Default Card -->
            <div class="card">
                <div class="card-body-title" style="display: flex; align-items: center; justify-content: space-between">
                    <div class="content-header">
                        <img width="50" height="50" src="https://img.icons8.com/ios/100/create-new.png"
                             alt="create-new"/>
                        <div class="header-dsc">
                            <h4 class="create-title">Voucher</h4>
                            <p style="font-size: 14px; color: darkgrey">List of voucher</p>
                        </div>
                    </div>
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verticalycentered"><i class="bi bi-pencil-square me-1"></i> Create new
                        voucher
                    </button>
                    <div class="modal fade" id="verticalycentered" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Create new voucher</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form class="row g-3" action="<c:url value="/admin/voucher/addNewVoucher"/> " method="post">
                                        <div class="col-md-6">
                                            <label for="inputTitle" class="form-label">Title</label>
                                            <input type="text" class="form-control" id="inputTitle" name="title">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="inputCode" class="form-label">Voucher Code</label>
                                            <input type="text" class="form-control" id="inputCode" style="text-transform:uppercase" maxlength="15" required oninput="validateInput(this)" name="voucherCode">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="inputDiscount" class="form-label">Discount Value</label>
                                            <input type="number" class="form-control" id="inputDiscount" required oninput="checkNegativeInput(this)" min="0" name="discountValue">
                                            <div id="discountErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="inputType" class="form-label">Type</label>
                                            <select id="inputType" class="form-select" name="voucherType">
                                                <option selected value="DISCOUNT_DIRECT" id="inputVoucherType" >Discount direct</option>
                                                <option value="DISCOUNT_PERCENT" id="inputVoucherType">Discount percent</option>
                                                <option value="FREE_SHIPPING" id="inputVoucherType">Free ship</option>
                                                <%--<option>Member</option>--%>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="inputQuantity" class="form-label">Quantity</label>
                                            <input type="number" class="form-control" id="inputQuantity" required min="1" name="quantity">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="inputMinimumValue" class="form-label">Minimum Value</label>
                                            <input type="number" class="form-control" id="inputMinimumValue" required min="0" oninput="checkNegativeInputMinimum(this)" name="minimumValue">
                                            <div id="minimumErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="inputMaxDiscount" class="form-label">Max Discount</label>
                                            <input type="number" class="form-control" id="inputMaxDiscount" required min="0" oninput="checkNegativeInputMaxdiscount(this)" name="maxDiscount">
                                            <div id="maxDiscountErrorMessage" class="invalid-feedback" style="font-size: 12px;">Please enter a value >= 0</div>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="inputExpirationDate" class="form-label">Expiration Date</label>
                                            <input type="date" class="form-control" id="inputExpirationDate" required name="expirationDateFormatYet">
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <textarea class="form-control" placeholder="Description" id="inputDescription" style="height: 100px;" name="description"></textarea>
                                                <label for="inputDescription">Description</label>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <button type="reset" class="btn btn-secondary">Reset</button>
                                            <button type="submit" class="btn btn-success">Create</button>
                                        </div>
                                    </form><!-- End Multi Columns Form -->
                                </div>
                            </div>
                        </div>
                    </div><!-- End Vertically centered Modal-->
                </div>
            </div><!-- End Default Card -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Voucher Created List</h5>

                    <!-- Pills Tabs -->
                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home"
                                    aria-selected="true">All
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-profile" type="button" role="tab"
                                    aria-controls="pills-profile" aria-selected="false">In Force
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-contact" type="button" role="tab"
                                    aria-controls="pills-contact" aria-selected="false">Expire
                            </button>
                        </li>
                    </ul>
                    <div class="tab-content pt-2" id="myTabContent">
                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                             aria-labelledby="home-tab">
                            <p>All vouchers in the system include both valid and expired ones</p>
                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-octagon me-1"></i>
                                        ${param.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="bi bi-check-circle me-1"></i>
                                        ${param.success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            <table class="table datatable" style="font-size: 14px" id="table-all-voucher">
                                <thead>
                                <tr>
                                    <th scope="col">ID</th>
<%--                                    <th scope="col">Voucher Code</th>--%>
                                    <th scope="col">Title</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Discount Value</th>
                                    <th scope="col">Discount Max</th>
                                    <th scope="col">Minimum Value</th>
                                    <th scope="col">Expiration Value</th>
                                    <th scope="col">Voucher Type</th>
                                    <th scope="col">Status Voucher</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${voucherRepository.findAll()}" var="voucher">
                                    <tr>
                                        <th scope="row">${voucher.id}</th>
<%--                                        <td>${voucher.voucherCode}</td>--%>
                                        <td>${voucher.title}</td>
                                        <td>${voucher.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    ${formatterDecimal.format(voucher.discountValue)} %
                                                </c:when>
                                                <c:otherwise>
                                                    ${formatVND.format(voucher.discountValue)}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${formatVND.format(voucher.maxDiscount)}</td>
                                        <td>${formatVND.format(voucher.minimumValue)}</td>
                                        <td>${dateFormat.format(voucher.expirationDate)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_DIRECT'}">
                                                    <span class="badge border-secondary border-1 text-secondary" style="font-size: 12px;">Direct</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    <span class="badge border-success border-1 text-success" style="font-size: 12px;">Percent</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'FREE_SHIPPING'}">
                                                    <span class="badge border-info border-1 text-info" style="font-size: 12px;">Free ship</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'MEMBER'}">
                                                    <span class="badge border-primary border-1 text-primary">Member</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.expirationDate.before(now)}">
                                                    <span class="badge bg-danger" style="font-size: 13px">Expire</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success" style="font-size: 13px">In Force</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" onclick="window.location.href='/admin/voucher/edit/${voucher.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="profile-tab">
                            <p>All system vouchers that are still valid</p>
                            <table class="table datatable" style="font-size: 14px" id="table-Force-voucher">
                                <thead>
                                <tr>
                                    <th scope="col">ID</th>
<%--                                    <th scope="col">Voucher Code</th>--%>
                                    <th scope="col">Title</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Discount Value</th>
                                    <th scope="col">Discount Max</th>
                                    <th scope="col">Minimum Value</th>
                                    <th scope="col">Expiration Value</th>
                                    <th scope="col">Voucher Type</th>
                                    <th scope="col">Status Voucher</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${voucherService.findVouchersInForce()}" var="voucher">
                                    <tr>
                                        <th scope="row">${voucher.id}</th>
<%--                                        <td>${voucher.voucherCode}</td>--%>
                                        <td>${voucher.title}</td>
                                        <td>${voucher.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    ${formatterDecimal.format(voucher.discountValue)} %
                                                </c:when>
                                                <c:otherwise>
                                                    ${formatVND.format(voucher.discountValue)}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${formatVND.format(voucher.maxDiscount)}</td>
                                        <td>${formatVND.format(voucher.minimumValue)}</td>
                                        <td>${dateFormat.format(voucher.expirationDate)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_DIRECT'}">
                                                    <span class="badge border-secondary border-1 text-secondary" style="font-size: 12px;">Direct</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    <span class="badge border-success border-1 text-success" style="font-size: 12px;">Percent</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'FREE_SHIPPING'}">
                                                    <span class="badge border-info border-1 text-info" style="font-size: 12px;">Free ship</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'MEMBER'}">
                                                    <span class="badge border-primary border-1 text-primary">Member</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.expirationDate.before(now)}">
                                                    <span class="badge bg-danger" style="font-size: 13px">Expire</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success" style="font-size: 13px">In Force</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" onclick="window.location.href='/admin/voucher/edit/${voucher.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="contact-tab">
                            <p>All vouchers in the system have expired</p>
                            <table class="table datatable" style="font-size: 14px" id="table-expiration-voucher">
                                <thead>
                                <tr>
                                    <th scope="col">ID</th>
<%--                                    <th scope="col">Voucher Code</th>--%>
                                    <th scope="col">Title</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Discount Value</th>
                                    <th scope="col">Discount Max</th>
                                    <th scope="col">Minimum Value</th>
                                    <th scope="col">Expiration Value</th>
                                    <th scope="col">Voucher Type</th>
                                    <th scope="col">Status Voucher</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${voucherService.findVouchersExpiration()}" var="voucher">
                                    <tr>
                                        <th scope="row">${voucher.id}</th>
<%--                                        <td>${voucher.voucherCode}</td>--%>
                                        <td>${voucher.title}</td>
                                        <td>${voucher.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    ${formatterDecimal.format(voucher.discountValue)} %
                                                </c:when>
                                                <c:otherwise>
                                                    ${formatVND.format(voucher.discountValue)}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${formatVND.format(voucher.maxDiscount)}</td>
                                        <td>${formatVND.format(voucher.minimumValue)}</td>
                                        <td>${dateFormat.format(voucher.expirationDate)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_DIRECT'}">
                                                    <span class="badge border-secondary border-1 text-secondary" style="font-size: 12px;">Direct</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'DISCOUNT_PERCENT'}">
                                                    <span class="badge border-success border-1 text-success" style="font-size: 12px;">Percent</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'FREE_SHIPPING'}">
                                                    <span class="badge border-info border-1 text-info" style="font-size: 12px;">Free ship</span>
                                                </c:when>
                                                <c:when test="${voucher.voucherType == 'MEMBER'}">
                                                    <span class="badge border-primary border-1 text-primary">Member</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${voucher.expirationDate.before(now)}">
                                                    <span class="badge bg-danger" style="font-size: 13px">Expire</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success" style="font-size: 13px">In Force</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" onclick="window.location.href='/admin/voucher/edit/${voucher.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div><!-- End Pills Tabs -->
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