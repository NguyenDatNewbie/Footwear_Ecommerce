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
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
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
                                        <span class="text-muted small pt-2 ps-1" id="increaseOrderText">Keep up the good work</span>

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

                    <!-- Reports -->
                    <div class="col-12">
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

                            <div class="card-body">
                                <h5 class="card-title">Reports <span>/This Week</span></h5>

                                <!-- Line Chart -->
                                <div id="reportsChart"></div>

                                <script>
                                    document.addEventListener("DOMContentLoaded", () => {
                                        new ApexCharts(document.querySelector("#reportsChart"), {
                                            series: [{
                                                name: 'Sales',
                                                data: ${ordersRepository.listTotalPriceOfThisWeek()},
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
                                        <c:forEach items="${ordersRepository.findAll()}" var="order">
                                            <tr>
                                                <th scope="row">${order.id}</th>
                                                <td>${order.account.accountDetail.name}</td>
                                                <td>${order.phone}</td>
                                                <td>${order.address}</td>
                                                <td>${order.totalPrice}</td>
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
<%--            <div class="col-lg-4">--%>

<%--                <!-- Recent Activity -->--%>
<%--                <div class="card">--%>
<%--                    <div class="filter">--%>
<%--                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>--%>
<%--                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">--%>
<%--                            <li class="dropdown-header text-start">--%>
<%--                                <h6>Filter</h6>--%>
<%--                            </li>--%>

<%--                            <li><a class="dropdown-item" href="#">Today</a></li>--%>
<%--                            <li><a class="dropdown-item" href="#">This Month</a></li>--%>
<%--                            <li><a class="dropdown-item" href="#">This Year</a></li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

<%--                    <div class="card-body">--%>
<%--                        <h5 class="card-title">Recent Activity <span>| Today</span></h5>--%>

<%--                        <div class="activity">--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">32 min</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Quia quae rerum <a href="#" class="fw-bold text-dark">explicabo officiis</a> beatae--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">56 min</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Voluptatem blanditiis blanditiis eveniet--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">2 hrs</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Voluptates corrupti molestias voluptatem--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">1 day</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Tempore autem saepe <a href="#" class="fw-bold text-dark">occaecati voluptatem</a> tempore--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">2 days</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Est sit eum reiciendis exercitationem--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                            <div class="activity-item d-flex">--%>
<%--                                <div class="activite-label">4 weeks</div>--%>
<%--                                <i class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>--%>
<%--                                <div class="activity-content">--%>
<%--                                    Dicta dolorem harum nulla eius. Ut quidem quidem sit quas--%>
<%--                                </div>--%>
<%--                            </div><!-- End activity item-->--%>

<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div><!-- End Recent Activity -->--%>

<%--                <!-- Budget Report -->--%>
<%--                <div class="card">--%>
<%--                    <div class="filter">--%>
<%--                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>--%>
<%--                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">--%>
<%--                            <li class="dropdown-header text-start">--%>
<%--                                <h6>Filter</h6>--%>
<%--                            </li>--%>

<%--                            <li><a class="dropdown-item" href="#">Today</a></li>--%>
<%--                            <li><a class="dropdown-item" href="#">This Month</a></li>--%>
<%--                            <li><a class="dropdown-item" href="#">This Year</a></li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

<%--                    <div class="card-body pb-0">--%>
<%--                        <h5 class="card-title">Budget Report <span>| This Month</span></h5>--%>

<%--                        <div id="budgetChart" style="min-height: 400px;" class="echart"></div>--%>

<%--                        <script>--%>
<%--                            document.addEventListener("DOMContentLoaded", () => {--%>
<%--                                var budgetChart = echarts.init(document.querySelector("#budgetChart")).setOption({--%>
<%--                                    legend: {--%>
<%--                                        data: ['Allocated Budget', 'Actual Spending']--%>
<%--                                    },--%>
<%--                                    radar: {--%>
<%--                                        // shape: 'circle',--%>
<%--                                        indicator: [{--%>
<%--                                            name: 'Sales',--%>
<%--                                            max: 6500--%>
<%--                                        },--%>
<%--                                            {--%>
<%--                                                name: 'Administration',--%>
<%--                                                max: 16000--%>
<%--                                            },--%>
<%--                                            {--%>
<%--                                                name: 'Information Technology',--%>
<%--                                                max: 30000--%>
<%--                                            },--%>
<%--                                            {--%>
<%--                                                name: 'Customer Support',--%>
<%--                                                max: 38000--%>
<%--                                            },--%>
<%--                                            {--%>
<%--                                                name: 'Development',--%>
<%--                                                max: 52000--%>
<%--                                            },--%>
<%--                                            {--%>
<%--                                                name: 'Marketing',--%>
<%--                                                max: 25000--%>
<%--                                            }--%>
<%--                                        ]--%>
<%--                                    },--%>
<%--                                    series: [{--%>
<%--                                        name: 'Budget vs spending',--%>
<%--                                        type: 'radar',--%>
<%--                                        data: [{--%>
<%--                                            value: [4200, 3000, 20000, 35000, 50000, 18000],--%>
<%--                                            name: 'Allocated Budget'--%>
<%--                                        },--%>
<%--                                            {--%>
<%--                                                value: [5000, 14000, 28000, 26000, 42000, 21000],--%>
<%--                                                name: 'Actual Spending'--%>
<%--                                            }--%>
<%--                                        ]--%>
<%--                                    }]--%>
<%--                                });--%>
<%--                            });--%>
<%--                        </script>--%>

<%--                    </div>--%>
<%--                </div><!-- End Budget Report -->--%>

<%--&lt;%&ndash;                <!-- Website Traffic -->&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div class="card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div class="filter">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li class="dropdown-header text-start">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h6>Filter</h6>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </li>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">Today</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">This Month</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">This Year</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </ul>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    <div class="card-body pb-0">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <h5 class="card-title">Website Traffic <span>| Today</span></h5>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        <div id="trafficChart" style="min-height: 400px;" class="echart"></div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        <script>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            document.addEventListener("DOMContentLoaded", () => {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                echarts.init(document.querySelector("#trafficChart")).setOption({&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    tooltip: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        trigger: 'item'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    legend: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        top: '5%',&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        left: 'center'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    series: [{&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        name: 'Access From',&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        type: 'pie',&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        radius: ['40%', '70%'],&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        avoidLabelOverlap: false,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        label: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            show: false,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            position: 'center'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        emphasis: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            label: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                show: true,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                fontSize: '18',&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                fontWeight: 'bold'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            }&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        labelLine: {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            show: false&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        data: [{&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            value: 1048,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            name: 'Search Engine'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                value: 735,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                name: 'Direct'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                value: 580,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                name: 'Email'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                value: 484,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                name: 'Union Ads'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            },&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            {&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                value: 300,&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                name: 'Video Ads'&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            }&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        ]&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    }]&ndash;%&gt;--%>
<%--&lt;%&ndash;                                });&ndash;%&gt;--%>
<%--&lt;%&ndash;                            });&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </script>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div><!-- End Website Traffic -->&ndash;%&gt;--%>

<%--&lt;%&ndash;                <!-- News & Updates Traffic -->&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div class="card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div class="filter">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li class="dropdown-header text-start">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h6>Filter</h6>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </li>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">Today</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">This Month</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <li><a class="dropdown-item" href="#">This Year</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </ul>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    <div class="card-body pb-0">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <h5 class="card-title">News &amp; Updates <span>| Today</span></h5>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        <div class="news">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="post-item clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img src="/admin/assets/img/news-1.jpg" alt="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4><a href="#">Nihil blanditiis at in nihil autem</a></h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p>Sit recusandae non aspernatur laboriosam. Quia enim eligendi sed ut harum...</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <div class="post-item clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img src="/admin/assets/img/news-2.jpg" alt="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4><a href="#">Quidem autem et impedit</a></h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p>Illo nemo neque maiores vitae officiis cum eum turos elan dries werona nande...</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <div class="post-item clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img src="/admin/assets/img/news-3.jpg" alt="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4><a href="#">Id quia et et ut maxime similique occaecati ut</a></h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p>Fugiat voluptas vero eaque accusantium eos. Consequuntur sed ipsam et totam...</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <div class="post-item clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img src="/admin/assets/img/news-4.jpg" alt="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4><a href="#">Laborum corporis quo dara net para</a></h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p>Qui enim quia optio. Eligendi aut asperiores enim repellendusvel rerum cuder...</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            <div class="post-item clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img src="/admin/assets/img/news-5.jpg" alt="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4><a href="#">Et dolores corrupti quae illo quod dolor</a></h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <p>Odit ut eveniet modi reiciendis. Atque cupiditate libero beatae dignissimos eius...</p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        </div><!-- End sidebar recent posts-->&ndash;%&gt;--%>

<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div><!-- End News & Updates -->&ndash;%&gt;--%>

<%--            </div><!-- End Right side columns -->--%>

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


</body>

</html>