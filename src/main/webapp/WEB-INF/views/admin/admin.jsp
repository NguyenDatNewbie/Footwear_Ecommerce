<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>

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
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

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
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">

</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/admin/home"/>">
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
            <a class="nav-link collapsed" href="<c:url value="/admin/voucher"/>">
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
        <h1>Dashboard</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
                <li class="breadcrumb-item active">Dashboard</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">

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

                                    <li><a class="dropdown-item" href="#" id="today">Today</a></li>
                                    <li><a class="dropdown-item" href="#" id="thisMonth">This Month</a></li>
                                    <li><a class="dropdown-item" href="#" id="thisYear">This Year</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Orders <span id="orderText">| All</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cart"></i>
                                    </div>
                                    <div class="ps-3">

                                        <h6 id="totalOrders">${ordersService.countAllOrders()}</h6>
                                        <span class="text-muted small pt-2 ps-1" id="increaseOrderText">Keep up the good work. Fighting!</span>

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

                                    <li><a class="dropdown-item" href="#" id="todaySales">Today</a></li>
                                    <li><a class="dropdown-item" href="#" id="monthSales">This Month</a></li>
                                    <li><a class="dropdown-item" href="#" id="yearSales">This Year</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Sales <span id="salesText">| All</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="totalSales">${formatVND.format(ordersService.revenueAll())}</h6>
                                        <span class="text-muted small pt-2 ps-1">It is important to sell more orders.</span>
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
                                    <li><a class="dropdown-item" id="thisWeekRevenue">This Week</a></li>
                                    <li><a class="dropdown-item" id="thisMonthRevenue">This Month</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Revenue <span id="revenueText">| Today</span></h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="revenue">0 ₫</h6>
                                        <span class="text-muted small pt-2 ps-1">Increased revenue is the goal of every store.</span>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div><!-- End Revenue Card -->

                    <!-- Chart Revenue month -->
                    <div class="col-12">
                        <div class="card">
                            <div class="filter" style="top: 20px; right: 20px;">
                                <div id="reportrange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%; border-radius: 10px;">
                                    <i class="bi bi-calendar2-event-fill"></i>
                                    <span></span> <i class="bi bi-caret-down-fill"></i>
                                </div>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Reports <span>| Daily Statistics</span></h5>

                                <!-- Bar Chart -->
                                <div id="reportsChart"></div>
                            </div>
                        </div>
                    </div><!-- End Chart Revenue month -->
                </div>
            </div>
            <!-- Left side columns -->
            <div class="col-lg-8">
                <div class="row">

                    <!-- Recent Sales -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>

                                    <li><a class="dropdown-item" id="todayOrders">Today</a></li>
                                    <li><a class="dropdown-item" id="weekOrders">This Week</a></li>
                                    <li><a class="dropdown-item" id="monthOrders">This Month</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Recent Sales <span id="orderTitle">| All Order</span></h5>

                                <table class="table table-borderless datatable" id="recent-order-table">
                                    <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Customer</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Store</th>
                                        <th scope="col">Total Price</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ordersRepository.findAll()}" var="order">
                                            <tr>
                                                <th scope="row">${order.id}</th>
                                                <td>${order.account.accountDetail.name}</td>
                                                <td>${order.phone}</td>
                                                <td>${order.store.department}</td>
<%--                                                <td>${order.store.account.accountDetail.name}</td>--%>
                                                <td>${formatVND.format(order.totalPrice)}</td>
                                                <td>
                                                    <a href="/admin/account/${order.account.id}/${order.id}" title="Detail" class="btn btn-info" style="font-size: 15px"><i class="bi bi-file-earmark-text"></i></a>
                                                </td>
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
                                        <c:forEach items="${productService.top5ProductSoldTop()}" var="product">
                                        <tr>
                                            <th scope="row"><a href="<c:url value="/admin/products/edit/${product.id}"/>"><img src="${product.images.get(0).img}" alt=""></a></th>
                                            <td><a href="<c:url value="/admin/products/edit/${product.id}"/>" class="text-primary fw-bold">${product.name}</a></td>
                                            <td>${product.price}</td>
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
            <div class="col-lg-4">

                <!-- Website Traffic -->
                <div class="card">
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
                        <h5 class="card-title">Payment Type <span>| Today</span></h5>

                        <div id="trafficChart" style="min-height: 400px;" class="echart"></div>

                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                echarts.init(document.querySelector("#trafficChart")).setOption({
                                    tooltip: {
                                        trigger: 'item'
                                    },
                                    legend: {
                                        top: '5%',
                                        left: 'center'
                                    },
                                    series: [{
                                        name: 'Access From',
                                        type: 'pie',
                                        radius: ['40%', '70%'],
                                        avoidLabelOverlap: false,
                                        label: {
                                            show: false,
                                            position: 'center'
                                        },
                                        emphasis: {
                                            label: {
                                                show: true,
                                                fontSize: '18',
                                                fontWeight: 'bold'
                                            }
                                        },
                                        labelLine: {
                                            show: false
                                        },
                                        data: [{
                                                value: ${numRecv},
                                                name: 'RECEIVE'
                                            },
                                            {
                                                value: ${numVNpay},
                                                name: 'VNPAY'
                                            },
                                            {
                                                value: ${numMOMO},
                                                name: 'MOMO'
                                            },
                                            {
                                                value: ${numPayPal},
                                                name: 'PAYPAL'
                                            },
                                        ]
                                    }]
                                });
                            });
                        </script>

                    </div>
                </div><!-- End Website Traffic -->

<%--                <!-- News & Updates Traffic -->--%>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Orders</h5>
                        <!-- Pie Chart -->
                        <canvas id="pieChart" style="max-height: 400px;"></canvas>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                new Chart(document.querySelector('#pieChart'), {
                                    type: 'pie',
                                    data: {
                                        labels: [
                                            'Waiting',
                                            'Preparing',
                                            'Already',
                                            'Delivery',
                                            'Complete',
                                            'Cancel'
                                        ],
                                        datasets: [{
                                            label: 'Number of Orders: ',
                                            data: [${waitOrders}, ${preOrders}, ${readyOrders}, ${deliOrders}, ${completeOrders}, ${cancelOrders}],
                                            backgroundColor: [
                                                'rgb(255, 205, 86)',    //waiting
                                                'rgb(201, 203, 207)',    //prepare
                                                'rgb(75, 192, 192)',    //already
                                                'rgb(54, 162, 235)',    //delivery
                                                'rgb(63, 244, 95)',     //Complete
                                                'rgb(255, 99, 132)'    //cancel
                                            ],
                                            hoverOffset: 4
                                        }]
                                    }
                                });
                            });
                        </script>
                        <!-- End Pie CHart -->
                    </div>
                </div><!-- End News & Updates -->

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
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

<!-- Template Main JS File -->
<script src="/admin/assets/js/main.js"></script>
<script src="/admin/assets/js/admin.js"></script>
<script>
    var options = {
        series: [],
        chart: {
            height: 350,
            type: 'bar',
            toolbar: {
                show: false
            },
        },
        plotOptions: {
            bar: {
                horizontal: false,
                columnWidth: '55%',
                endingShape: 'rounded'
            },
        },
        fill: {
            type: "gradient",
            gradient: {
                shadeIntensity: 1,
                opacityFrom: 0.3,
                opacityTo: 0.4,
                stops: [0, 90, 100]
            }
        },
        noData: {
            text: 'Loading...'
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            curve: 'smooth',
            width: 2,
            colors: ['transparent']
        },
        yaxis:  [
            {
                title: {
                    text: '$ (VNĐ)'
                }
            },
            // {
            //     opposite: true,
            //     title: {
            //         text: 'Million (VND)'
            //     }
            // }
        ],
        fill: {
            opacity: 1
        },
        xaxis: {
            type: 'datetime',
        },
        tooltip: {
            x: {
                format: 'dd/MM/yyyy HH:mm'
            },
        }
    }
    //Tạo chart
    var chart = new ApexCharts(document.querySelector("#reportsChart"), options);

    //Thực hiện tính toán
    $(function() {

        var start = moment().subtract(10, 'days');
        var end = moment();

        function cb(start, end) {
            $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));

            // Get list of dates
            let dates = [];
            let currentDate = start.clone();
            while (currentDate.isSameOrBefore(end)) {
                dates.push(currentDate.format('YYYY-MM-DD'));
                currentDate.add(1, 'days');
            }
            console.log("Dates: ", dates);
            var revenueData = [];
            var salesData = [];
            var orderData = []

            // Hàm để cập nhật series khi cả hai dữ liệu đã sẵn sàng
            function updateChart() {
                if (revenueData.length && salesData.length && orderData.length) {
                    chart.updateSeries([{
                        name: 'Order',
                        data: orderData
                    }, {
                        name: 'Sales',
                        data: salesData
                    },
                    {
                        name: 'Revenue',
                        data: revenueData
                    }]);
                }
            }
            $.ajax({
                url: '/admin/home/orderOfDates', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(dates),
                success: function(response) {
                    console.log('Success:', response);

                    // chart.appendSeries({
                    //     name: 'Account',
                    //     data: response
                    // })
                    orderData = response;
                    updateChart();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });

            //lấy doanh số theo ngày
            $.ajax({
                url: '/admin/home/calculateSales', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(dates),
                success: function(response) {
                    console.log('Success:', response);
                    salesData = response;
                    updateChart();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });

            // Lấy doanh thu theo ngày
            $.ajax({
                url: '/admin/home/calculateRevenue', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(dates),
                success: function(response) {
                    console.log('Success:', response);
                    revenueData = response;
                    updateChart();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }

        $('#reportrange').daterangepicker({
            startDate: start,
            endDate: end,
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                'This Month': [moment().startOf('month'), moment().endOf('month')],
                'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        }, cb);

        cb(start, end);

    });
    //Hiển thị
    chart.render();
</script>
<script>
    $(document).ready(function() {
        $('#todayOrders').click(function() {
            $.ajax({
                url: '/admin/home/getOrdersToday', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                    $('#recent-order-table tbody').empty();
                    if (response && Array.isArray(response) && response.length > 0) {
                        console.log("response: ", response);
                        response.forEach(function (order) {
                            var $row = $('<tr></tr>');
                            $row.append('<th scope="row">' + order.id + '</th>');
                            $row.append('<td>' + order.name + '</td>');
                            $row.append('<td>' + order.phone + '</td>');
                            $row.append('<td>' + order.store.department + '</td>');
                            $row.append('<td>' + order.totalPrice + ' đ' + '</td>');
                            $row.append('<td><a href="/admin/account/' + order.account.id + '/' + order.id + '" title="Detail" class="btn btn-info" style="font-size: 15px"><i class="bi bi-file-earmark-text"></i></a></td>');


                            // Append the row to the table body
                            $('#recent-order-table tbody').append($row);
                        });
                    } else {
                        $('#recent-order-table tbody').append('<tr><td class="datatable-empty" colspan="6">No orders today</td></tr>');
                    }
                    $('#orderTitle').text("| Today");
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });

    $(document).ready(function() {
        $('#weekOrders').click(function() {
            $.ajax({
                url: '/admin/home/getOrdersWeek', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                    $('#recent-order-table tbody').empty();
                    if (response && Array.isArray(response) && response.length > 0) {
                        console.log("response: ", response);
                        response.forEach(function (order) {
                            var $row = $('<tr></tr>');
                            $row.append('<th scope="row">' + order.id + '</th>');
                            $row.append('<td>' + order.name + '</td>');
                            $row.append('<td>' + order.phone + '</td>');
                            $row.append('<td>' + order.store.department + '</td>');
                            $row.append('<td>' + order.totalPrice + ' đ' + '</td>');
                            $row.append('<td><a href="/admin/account/' + order.account.id + '/' + order.id + '" title="Detail" class="btn btn-info" style="font-size: 15px"><i class="bi bi-file-earmark-text"></i></a></td>');


                            // Append the row to the table body
                            $('#recent-order-table tbody').append($row);
                        });
                    } else {
                        $('#recent-order-table tbody').append('<tr><td class="datatable-empty" colspan="6">No orders today</td></tr>');
                    }
                    $('#orderTitle').text("| Today");
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });

    $(document).ready(function() {
        $('#monthOrders').click(function() {
            $.ajax({
                url: '/admin/home/getOrdersMonth', // Địa chỉ máy chủ để gửi yêu cầu
                method: 'GET',
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                    $('#recent-order-table tbody').empty();
                    if (response && Array.isArray(response) && response.length > 0) {
                        console.log("response: ", response);
                        response.forEach(function (order) {
                            var $row = $('<tr></tr>');
                            $row.append('<th scope="row">' + order.id + '</th>');
                            $row.append('<td>' + order.name + '</td>');
                            $row.append('<td>' + order.phone + '</td>');
                            $row.append('<td>' + order.store.department + '</td>');
                            $row.append('<td>' + order.totalPrice + ' đ' + '</td>');
                            $row.append('<td><a href="/admin/account/' + order.account.id + '/' + order.id + '" title="Detail" class="btn btn-info" style="font-size: 15px"><i class="bi bi-file-earmark-text"></i></a></td>');


                            // Append the row to the table body
                            $('#recent-order-table tbody').append($row);
                        });
                    } else {
                        $('#recent-order-table tbody').append('<tr><td class="datatable-empty" colspan="6">No orders today</td></tr>');
                    }
                    $('#orderTitle').text("| Today");
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });
</script>

</body>

</html>