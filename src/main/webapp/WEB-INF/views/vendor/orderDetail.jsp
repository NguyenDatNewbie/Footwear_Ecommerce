<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Orders - Vendor</title>
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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
  <link href="/admin/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="/admin/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

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
      <a class="nav-link collapsed" href="<c:url value="/vendor/home"/>">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-basket"></i><span>Order</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="tables-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
        <li>
          <a href="<c:url value="/vendor/orderRcvStore"/>">
            <i class="bi bi-circle"></i><span>Orders To Process</span>
          </a>
        </li>
        <li>
          <a href="<c:url value="/vendor/order"/>" class="active">
            <i class="bi bi-circle"></i><span>Order Management</span>
          </a>
        </li>
      </ul>
    </li>

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-journal-text"></i><span>Inventory</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="forms-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="<c:url value="/vendor/listStock"/>">
            <i class="bi bi-circle"></i><span>Stock</span>
          </a>
        </li>
        <li>
          <a href="<c:url value="/vendor/stock"/>">
            <i class="bi bi-circle"></i><span>Import Product</span>
          </a>
        </li>
      </ul>
    </li><!-- End Forms Nav -->

  </ul>

</aside><!-- End Sidebar-->

<main id="main" class="main">

  <div class="pagetitle">
    <h1>Profile</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/vendor/home">Home</a></li>
        <li class="breadcrumb-item"><a href="/vendor/order">Orders</a></li>
        <li class="breadcrumb-item active">Order Detail</li>
      </ol>
    </nav>
  </div><!-- End Page Title -->

  <section class="section profile">
    <div class="row">
      <div class="col-xl-5">

        <div class="card">
          <div class="card-body profile-card pt-4 d-flex flex-column profile profile-overview label">

            <img src="${accountDetail.image}" alt="Profile" class="rounded-circle" style="align-items: center !important; margin: auto !important;">
            <div style="display: flex; justify-content: center; margin-bottom: 12px;">
              <h2>${order.name}</h2>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Email</div>
              <div class="col-lg-9 col-md-8">${account.email}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Phone number</div>
              <div class="col-lg-9 col-md-8">${order.phone}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Address</div>
              <div class="col-lg-9 col-md-8">${order.address}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Creation Time</div>
              <div class="col-lg-9 col-md-8">${order.createdAt}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Payment Type</div>
              <div class="col-lg-9 col-md-8 text-success">${order.paymentType}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Shipment Type</div>
              <div class="col-lg-9 col-md-8 text-info">${order.receiveType}</div>
            </div>
            <div class="row">
              <div class="col-lg-3 col-md-4 label ">Order Status</div>
              <div class="col-lg-9 col-md-8" style="margin-bottom: 16px;">
                <c:choose>
                  <c:when test="${order.status == 'WAIT'}">
                    <span class="badge bg-secondary">${order.status}</span>
                  </c:when>
                  <c:when test="${order.status == 'PREPARE'}">
                    <span class="badge bg-warning">${order.status}</span>
                  </c:when>
                  <c:when test="${order.status == 'ALREADY'}">
                    <span class="badge bg-primary">${order.status}</span>
                  </c:when>
                  <c:when test="${order.status == 'DELIVERY'}">
                    <span class="badge bg-info">${order.status}</span>
                  </c:when>
                  <c:when test="${order.status == 'COMPLETE'}">
                    <span class="badge bg-success">${order.status}</span>
                  </c:when>
                  <c:when test="${order.status == 'CANCEL'}">
                    <span class="badge bg-danger">${order.status}</span>
                  </c:when>
                </c:choose>
              </div>
              <div class="row">
                <div class="col-lg-3 col-md-4 label ">Order Cost</div>
                <div class="col-lg-9 col-md-8 text-dark">${formatVND.format(order.totalPrice)}</div>
              </div>
              <div class="row">
                <div class="col-lg-3 col-md-4 label ">Order From</div>
                <div class="col-lg-9 col-md-8">${order.store.department}</div>
              </div>
            </div>

          </div>
        </div>

      </div>

      <div class="col-xl-7">

        <div class="card">
          <div class="card-body pt-3">
            <h5 class="card-title" style="padding: 0!important;">Order Detail <span style="color: #51f000; font-style: italic; font-weight: 500;"> | Available for shipping</span></h5>
            <!-- Bordered Tabs -->
<%--            <ul class="nav nav-tabs nav-tabs-bordered">--%>

<%--              <li class="nav-item">--%>
<%--                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Order Detail</button>--%>
<%--              </li>--%>
<%--            </ul>--%>
<%--            <div class="tab-content pt-2">--%>
              <div class="tab-pane show active profile-edit pt-3">
                <!-- Table detail order -->
                <table class="table table-bordered">
                  <thead>
                  <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Product Image</th>
                    <th scope="col">Size</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Price</th>
                    <th scope="col">Total Price</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${orderItem}" var="item">
                    <tr>
                      <th scope="row">${item.id}</th>
                      <td>${item.inventory.size.product.name}</td>
                      <th scope="row"><img src="${item.inventory.size.product.images.get(0).img}" alt=""></th>
                      <td>${item.inventory.size.size}</td>
                      <td>${item.quantity}</td>
                      <td>${formatVND.format(item.price)}</td>
                      <td>${formatVND.format(item.price*item.quantity)}</td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
<%--            </div><!-- End Bordered Tabs -->--%>
          </div>
        </div>

        <div class="card">
          <div class="card-body pt-3">
            <h5 class="card-title" style="padding: 0!important;">Product out of stock <span style="color: red; font-style: italic; font-weight: 500;">| Immediate import required</span></h5>

            <!-- Bordered Tabs -->
<%--            <ul class="nav nav-tabs nav-tabs-bordered">--%>

<%--              <li class="nav-item">--%>
<%--                <button class="nav-link" data-bs-toggle="tab">Product out of stock</button>--%>
<%--              </li>--%>
<%--            </ul>--%>
<%--            <div class="tab-content pt-2">--%>
              <div class="tab-pane show active profile-edit pt-3">
                <!-- Table detail order -->
                <table class="table table-bordered">
                  <thead>
                  <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Product Image</th>
                    <th scope="col">Size</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Price</th>
                    <th scope="col">Total Price</th>
<%--                    <th scope="col">Action</th>--%>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${productOutOfStocks}" var="outStock">
                    <tr>
                      <th scope="row">${outStock.id}</th>
                      <td>${outStock.size.product.name}</td>
                      <th scope="row"><img src="${outStock.size.product.images.get(0).img}" alt=""></th>
                      <td>${outStock.size.size}</td>
                      <td>${outStock.quantity}</td>
                      <td>${formatVND.format(outStock.price)}</td>
                      <td>${formatVND.format(outStock.price*outStock.quantity)}</td>
                    <%--                      <td>--%>
<%--                        <button type="button" onclick="window.location.href='/vendor/order/${outStock.orders.account.id}/${outStock.orders.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>--%>
<%--                      </td>--%>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
<%--            </div><!-- End Bordered Tabs -->--%>
          </div>
        </div>
      </div>
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

</body>

</html>