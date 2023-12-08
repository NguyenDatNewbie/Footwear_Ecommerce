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

  <section class="section dashboard">
    <div class="row">

      <!-- Left side columns -->
      <div class="col-lg-12">
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
                    <th scope="col">Phone Number</th>
                    <th scope="col">Name</th>
                    <th scope="col">Address</th>
                    <th scope="col">Total Price</th>
                    <th scope="col">Store</th>
                    <th scope="col">Creation Time</th>
<%--                    <th scope="col">Payment Type</th>--%>
                    <th scope="col">Receive Type</th>
                    <th scope="col">Status</th>
                    <th scope="col">Action</th>
                  </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${orders}" var="order">
                      <tr>
                        <th scope="row">${order.id}</th>
                        <td>${order.phone}</td>
                        <td>${order.name}</td>
                        <td>${order.address}</td>
                        <td>${formatVND.format(order.totalPrice)}</td>
                        <td>${order.store.department}</td>
                        <td>${order.createdAt}</td>
<%--                        <td>--%>
<%--                          <c:choose>--%>
<%--                            <c:when test="${order.paymentType == 'RECEIVE'}">--%>
<%--                              <span class="badge text-success">${order.paymentType}</span>--%>
<%--                            </c:when>--%>
<%--                            <c:when test="${order.paymentType == 'MOMO'}">--%>
<%--                              <span class="badge text-danger">${order.paymentType}</span>--%>
<%--                            </c:when>--%>
<%--                            <c:when test="${order.paymentType == 'PAYPAL'}">--%>
<%--                              <span class="badge text-info">${order.paymentType}</span>--%>
<%--                            </c:when>--%>
<%--                          </c:choose>--%>
<%--                        </td>--%>
                        <td>
                          <c:choose>
                            <c:when test="${order.receiveType == 'DELIVERY'}">
                              <span class="badge bg-info">${order.receiveType}</span>
                            </c:when>
                            <c:when test="${order.receiveType == 'STORE'}">
                              <span class="badge bg-light text-dark">${order.receiveType}</span>
                            </c:when>
                          </c:choose>
                        </td>
                        <td>
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
                        </td>
                        <td>
                          <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                          <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                          <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>

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