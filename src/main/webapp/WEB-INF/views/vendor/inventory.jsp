<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Stock - Vendor</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/admin/assets/img/favicon.png" rel="icon">
    <link href="/admin/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/admin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/admin/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/admin/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/admin/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">

    <style>
        .datatable-sorter::before{
            display: none;
        }
        .datatable-sorter::after{
            display: none;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="../vendor/header.jsp" />
<jsp:include page="sidebar.jsp"/>


<main id="main" class="main">

    <div class="pagetitle">
        <h1>Stock Management</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/vendor/home">Home</a></li>
                <li class="breadcrumb-item active">Order Detail</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">

            <!-- Left side columns -->
            <div class="col-lg-12">
                <div class="row">
                    <!-- Recent Sales -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="card-body">
                                <h5 class="card-title">The Store's Stock <span>| The list of the goods kept in the storehouse</span></h5>
                                <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                                    <li class="nav-item flex-fill" role="presentation">
                                        <button class="nav-link w-100 active" id="in-stock-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-in-stock" type="button" role="tab" aria-controls="home" aria-selected="true">In Stock</button>
                                    </li>
                                    <li class="nav-item flex-fill" role="presentation">
                                        <button class="nav-link w-100" id="out-stock-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-out-stock" type="button" role="tab" aria-controls="profile" aria-selected="false">Out Of Stock</button>
                                    </li>
                                </ul>
                                <div class="tab-content pt-2" id="borderedTabJustifiedContent">
                                    <div class="tab-pane fade show active" id="bordered-justified-in-stock" role="tabpanel" aria-labelledby="in-stock-tab">
                                        <table class="table datatable">
                                            <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Product Name</th>
                                                <th scope="col">Size</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Date Last Import</th>
                                                <th scope="col">Supplier</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${inventoryList}" var="inventory">
                                                <tr>
                                                    <th scope="row">${inventory.id}</th>
                                                    <td>${inventory.size.product.name}</td>
                                                    <td>${inventory.size.size}</td>
                                                    <td>${inventory.quantity}</td>
                                                    <td>${inventory.stock.createdAt}</td>
                                                    <td>${inventory.stock.supplier.name}</td>

                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="tab-pane fade" id="bordered-justified-out-stock" role="tabpanel" aria-labelledby="in-stock-tab">
                                        <table class="table datatable">
                                            <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Product Name</th>
                                                <th scope="col">Size</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Order ID</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${outOfStocks}" var="outStock">
                                                <tr>
                                                    <th scope="row">${outStock.id}</th>
                                                    <td>${outStock.size.product.name}</td>
                                                    <td>${outStock.size.size}</td>
                                                    <td>${outStock.quantity}</td>
                                                    <td>${outStock.orders.id}</td>
                                                    <td>
                                                        <button type="button" onclick="window.location.href='/vendor/order/${outStock.orders.account.id}/${outStock.orders.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div><!-- End Recent Sales -->
            </div><!-- End Right side columns -->

        </div>
    </section>

</main><!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

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

</body>

</html>