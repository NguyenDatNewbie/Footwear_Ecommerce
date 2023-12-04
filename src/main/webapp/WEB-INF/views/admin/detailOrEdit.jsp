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
      <div class="row justify-content-center">
        <div class="col-md-6">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Product Detail</h5>

          <!-- Vertical Form -->
          <!-- No Labels Form -->
          <form class="row g-3" action="<c:url value="/admin/products/updateProduct"/> " method="post">
            <div class="col-md-12">
              <input hidden="hidden" type="text" class="form-control" placeholder="Product ID" value="${product.id}" id="id" name="id">
            </div>
            <div class="col-md-12">
              <input type="text" class="form-control" placeholder="Product Name" value="${product.name}" id="name" name="name">
            </div>
            <div class="col-md-6">
              <input type="text" class="form-control" placeholder="Price" value="${product.price}" id="price" name="price">
            </div>
            <div class="col-md-6">
              <input type="text" class="form-control" placeholder="Promotion" value="${product.promotion}" id="promotion" name="promotion">
            </div>
            <div class="col-12">
              <input type="text" class="form-control" placeholder="Description" value="${product.description}" id="description" name="description">
            </div>
            <div class="col-12">
              <input type="number" class="form-control" placeholder="Category ID" value="${product.category.id}" id="category_id" name="category" />
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-primary">Update Product</button>
              <button type="reset" class="btn btn-secondary">List Product</button>
            </div>
          </form><!-- End No Labels Form -->

        </div>
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