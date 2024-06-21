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
      <a class="nav-link " href="<c:url value="/admin/categories"/>">
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
    <h1>Category Management</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
        <li class="breadcrumb-item"><a href="<c:url value="/admin/categories"/>">Categories</a></li>
        <li class="breadcrumb-item active">Detail</li>

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
                <h5 class="card-title">Category Detail</h5>

                <!-- Vertical Form -->
                <!-- No Labels Form -->
                <form class="row g-3" action="<c:url value="/admin/categories/updateCate"/> " method="post">
                  <div class="col-md-12">
                    <input hidden="hidden" type="text" class="form-control" placeholder="Product ID" value="${category.id}" id="id" name="id">
                  </div>
                  <div class="col-md-12">
                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Category Name</span>
                    <input type="text" class="form-control" placeholder="Category Name" value="${category.name}" id="name" name="name">
                  </div>
                  <div class="col-md-12">
                    <span class="card-title" style="font-size: 1em; margin-left: 5px;">Category Parent</span>
                    <input type="text" class="form-control" placeholder="Category Parent" value="${category.parent}" id="parent" name="parent">
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn btn-success">Update Category</button>
                    <button type="reset" class="btn btn-secondary" id="listCateBtn">Cancel</button>
                  </div>
                </form><!-- End No Labels Form -->
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
<script>
  document.getElementById('listCateBtn').addEventListener('click', function () {
    window.location.href = "/admin/categories";
  });
</script>
</body>

</html>