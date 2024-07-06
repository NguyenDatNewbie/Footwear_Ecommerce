<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>List Stock - Vendor</title>
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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">


    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <style>

        tr input {
            width: 100%;
            padding: 3px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        #autocomplete-list li {
            padding: 8px;
            cursor: pointer;
            background-color: #f9f9f9;
        }

        #autocomplete-list li:hover {
            background-color: #ddd;
        }


        .content h5 {
            font-weight: 600;
        }

        .check span {
            font-size: 16px;
        }

        .table-striped > tbody > tr:nth-of-type(odd) > * {
            --bs-table-bg-type: rgb(224, 247, 250);
        }

        .datatable-sorter::before {
            display: none;
        }

        .datatable-sorter::after {
            display: none;
        }

        .datatable-sorter {
            padding: 0;
        }

        .button-icon:hover {
            color: #ff6a28;
        }
        #stockTable tbody tr:hover td{
            color: #ff6a28;
            cursor: pointer;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="../vendor/header.jsp"/>
<!-- ======= Sidebar ======= -->

<jsp:include page="sidebar.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
        <h1>List Stock</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/vendor/home">Home</a></li>
                <li class="breadcrumb-item active">List</li>
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
                                <div class="tab-content pt-2" id="borderedTabJustifiedContent">
                                    <div class="tab-pane fade show active" id="bordered-justified-in-stock"
                                         role="tabpanel" aria-labelledby="in-stock-tab">
                                        <table class="table table-borderless datatable" id="stockTable">
                                            <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Supplier</th>
                                                <th scope="col">Creation Time</th>
                                                <th scope="col">Total Quantity</th>
                                                <th scope="col">Total Price</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="stock" items="${stocks}">
                                                <tr>
                                                    <th scope="row">${stock.id}</th>
                                                    <td>${stock.supplier.name}</td>
                                                    <td>${stock.createdAt}</td>
                                                    <td>${stock.totalQuantity}</td>
                                                    <td>${formatVND.format(stock.totalPrice)}</td>
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var table = document.getElementById('stockTable');
        var rows = table.getElementsByTagName('tr');

        for (var i = 1; i < rows.length; i++) { // Bắt đầu từ 1 để bỏ qua header
            rows[i].addEventListener('click', function() {
                window.open("/vendor/stock/list/"+this.cells[0].textContent, '_blank');
            });
        }
    });
</script>

</body>

</html>