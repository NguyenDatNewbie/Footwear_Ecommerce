<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dashboard - NiceAdmin Bootstrap Template</title>
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
    <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">

</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
<jsp:include page="sidebar.jsp" />

<main id="main" class="main">

    <div class="pagetitle">
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/vendor/home">Home</a></li>
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">

            <!-- Left side columns -->
            <div class="col-lg-12">
                <div class="row">

                    <!-- Orders Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card sales-card">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" href="#" id="todayOrder">Today</a></li>
                                    <li><a class="dropdown-item" href="#" id="monthOrder">This Month</a></li>
                                    <li><a class="dropdown-item" href="#" id="allOrders">All</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Orders <span id="orderText">| Today</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cart"></i>
                                    </div>
                                    <div class="ps-3">

                                        <h6 id="totalOrders">${orderToday}</h6>
                                        <span class="text-success small pt-1 fw-bold" id="orderIncreaseText"></span> <span class="text-muted small pt-2 ps-1" id="increaseOrderText">Keep up the good work</span>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div><!-- End Orders Card -->

                    <!-- Sales Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card revenue-card">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" href="#" id="todaySale">Today</a></li>
                                    <li><a class="dropdown-item" href="#" id="monthSale">This Month</a></li>
                                    <li><a class="dropdown-item" href="#" id="allSale">All</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Sales <span id="salesText">| Today</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="totalSales">${formatVND.format(saleToday)}</h6>
                                        <span class="text-muted small pt-2 ps-1">More orders need to be sold.</span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div><!-- End Sales Card -->

                    <!-- Revenue Card -->
                    <div class="col-xxl-4 col-xl-12">

                        <div class="card info-card customers-card">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" id="todayRevenue">Today</a></li>
                                    <li><a class="dropdown-item" id="weekRevenue">This Week</a></li>
                                    <li><a class="dropdown-item" id="monthRevenue">This Month</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Revenue <span id="revenueText">| Today</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="revenue">${formatVND.format(revenueToday)}</h6>
                                        <span class="text-muted small pt-2 ps-1">The store's revenue needs to be increased.</span>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div><!-- End Revenue Card -->

                    <!-- Reports -->
                    <div class="col-12">
                        <div class="card">

                            <div class="card-body">
                                <h5 class="card-title">Reports <span>/This Week</span></h5>

                                <!-- Line Chart -->
                                <div id="reportsChart"></div>

                                <script>
                                    document.addEventListener("DOMContentLoaded", () => {
                                        new ApexCharts(document.querySelector("#reportsChart"), {
                                            series: [{
                                                name: 'Sales',
                                                data: ${listTotalPriceOfThisWeekStore},
                                            }, {
                                                name: 'Revenue',
                                                data: ${listRevenue},
                                            }],
                                            chart: {
                                                height: 350,
                                                type: 'area',
                                                toolbar: {
                                                    show: false
                                                },
                                            },
                                            markers: {
                                                size: 4
                                            },
                                            colors: ['#4154f1', '#2eca6a'],
                                            fill: {
                                                type: "gradient",
                                                gradient: {
                                                    shadeIntensity: 1,
                                                    opacityFrom: 0.3,
                                                    opacityTo: 0.4,
                                                    stops: [0, 90, 100]
                                                }
                                            },
                                            dataLabels: {
                                                enabled: false
                                            },
                                            stroke: {
                                                curve: 'smooth',
                                                width: 2
                                            },
                                            xaxis: {
                                                type: 'category',
                                                categories: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                                            },
                                            tooltip: {
                                                x: {
                                                    format: 'dd/MM/yy HH:mm'
                                                },
                                            }
                                        }).render();
                                    });
                                </script>
                                <!-- End Line Chart -->

                            </div>

                        </div>
                    </div><!-- End Reports -->

                    <!-- Recent Sales -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" href="#">Today</a></li>
                                    <li><a class="dropdown-item" href="#">This Month</a></li>
                                    <li><a class="dropdown-item" href="#">This Year</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Recent Sales <span>| Today</span></h5>

                                <table class="table table-borderless datatable">
                                    <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Customer</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Total Price</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ordersAll}" var="order">
                                            <tr>
                                                <th scope="row">${order.id}</th>
                                                <td>${order.account.accountDetail.name}</td>
                                                <td>${order.phone}</td>
                                                <td>${order.address}</td>
                                                <td>${formatVND.format(order.totalPrice)}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>

                        </div>
                    </div><!-- End Recent Sales -->

                    <!-- Top Selling -->
                    <div class="col-12">
                        <div class="card top-selling overflow-auto">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" href="#">Today</a></li>
                                    <li><a class="dropdown-item" href="#">This Month</a></li>
                                    <li><a class="dropdown-item" href="#">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body pb-0">
                                <h5 class="card-title">Top Selling <span>| Today</span></h5>

                                <table class="table table-borderless">
                                    <thead>
                                    <tr>
                                        <th scope="col">Preview</th>
                                        <th scope="col">Product</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Sold</th>
                                        <th scope="col">Promotion</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${productRepository.findAllByProductSold()}" var="product">
                                        <tr>
                                            <th scope="row"><a href="#"><img src="${product.images.get(0).img}" alt=""></a></th>
                                            <td><a href="#" class="text-primary fw-bold">${product.name}</a></td>
                                            <td>${formatVND.format(product.price)}</td>
                                            <td class="fw-bold">${product.sold}</td>
                                            <td>${product.promotion}</td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>

                        </div>
                    </div><!-- End Top Selling -->
                </div>
            </div><!-- End Left side columns -->

            <!-- Right side columns -->
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
<script src="/admin/assets/js/admin.js"></script>

<script>
    $(document).ready(function() {
        $('#allOrders').click(function() {
            $.ajax({
                url: '/vendor/home/getTotalOrderStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var newTotalOrder = response;
                    $('#totalOrders').text(newTotalOrder);
                    $('#orderText').text("| All");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#todayOrder').click(function() {
            $.ajax({
                url: '/vendor/home/getTodayOrderStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var newTodayOrder = response;
                    $('#totalOrders').text(newTodayOrder);
                    $('#orderText').text("| Today");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#monthOrder').click(function() {
            $.ajax({
                url: '/vendor/home/getMonthOrderStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var newMonthOrder = response;
                    $('#totalOrders').text(newMonthOrder);
                    $('#orderText').text("| This Month");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#allSale').click(function() {
            $.ajax({
                url: '/vendor/home/getTotalSalesStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var allSale = response;
                    $('#totalSales').text(formatter.format(allSale));
                    $('#salesText').text("| All Sales");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#todaySale').click(function() {
            $.ajax({
                url: '/vendor/home/getTodaySalesStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var todaySale = response;
                    $('#totalSales').text(formatter.format(todaySale));
                    $('#salesText').text("| Today");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#monthSale').click(function() {
            $.ajax({
                url: '/vendor/home/getMonthSalesStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var monthSale = response;
                    $('#totalSales').text(formatter.format(monthSale));
                    $('#salesText').text("| This Month");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#todayRevenue').click(function() {
            $.ajax({
                url: '/vendor/home/getRevenueTodayStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var todayRevenue = response;
                    $('#revenue').text(formatter.format(todayRevenue));
                    $('#revenueText').text("| Today");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#monthRevenue').click(function() {
            $.ajax({
                url: '/vendor/home/getRevenueMonthStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var monthRevenue = response;
                    $('#revenue').text(formatter.format(monthRevenue));
                    $('#revenueText').text("| This Month");
                }
            });
        });
    });
    $(document).ready(function() {
        $('#weekRevenue').click(function() {
            $.ajax({
                url: '/vendor/home/getRevenueMonthStore', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                success: function(response) {
                    var weekRevenue = response;
                    $('#revenue').text(formatter.format(weekRevenue));
                    $('#revenueText').text("| This Week");
                }
            });
        });
    });
</script>

</body>

</html>