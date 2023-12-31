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
<jsp:include page="sidebar.jsp" />

<main id="main" class="main">

  <div class="pagetitle">
    <h1>Profile</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/admin">Home</a></li>
        <li class="breadcrumb-item"><a href="/admin/account">Account</a></li>
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
            <!-- Bordered Tabs -->
            <ul class="nav nav-tabs nav-tabs-bordered">

              <li class="nav-item">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Order Detail</button>
              </li>
            </ul>
            <div class="tab-content pt-2">

              <div class="tab-pane show active profile-edit pt-3" id="profile-edit">
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

            </div><!-- End Bordered Tabs -->

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