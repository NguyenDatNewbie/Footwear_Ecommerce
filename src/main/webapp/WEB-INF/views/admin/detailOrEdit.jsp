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
  <style>
    .form-check {
      padding-right: 10px;
      font-size: 15px;
    }

    .selected-size {
      background-color: yellow; /* Màu nền của checkbox khi được chọn */
    }
    .image-container {
      display: inline-block;
    }

    .image-container img {
      width: 150px;
      height: 150px;
      margin-right: 10px;
      margin-bottom: 10px;
    }

    .image-container video {
      width: 150px;
      height: 150px;
      margin-right: 10px;
      margin-bottom: 10px;
      margin-top: 10px;
    }

    .image-container a {
      display: block;
      margin-top: 10px; /* Khoảng cách giữa ảnh và nút xóa */
      font-size: 15px;
      width: 50px;
      margin-left: calc((150px - 50px) / 2); /* Căn giữa thẻ a theo chiều ngang */
    }
  </style>

</head>
<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
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
      <a class="nav-link" href="<c:url value="/admin/products"/>">
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
    <h1>Product Detail</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
        <li class="breadcrumb-item"><a href="<c:url value="/admin/products"/>">Product</a></li>
        <li class="breadcrumb-item active">Product Detail</li>
      </ol>
    </nav>
  </div><!-- End Page Title -->

  <section class="section dashboard">
    <div class="row">
      <div class="row justify-content-center">
        <div class="col-md-12">
      <div class="card">
        <div class="card-body">
<%--          <h5 class="card-title">Product Detail</h5>--%>

          <!-- Vertical Form -->
          <!-- No Labels Form -->
          <form class="row g-3" action="<c:url value="/admin/products/updateProduct"/> " method="post" enctype="multipart/form-data">
            <div class="col-md-12">
              <input hidden="hidden" type="text" class="form-control" placeholder="Product ID" value="${product.id}" id="id" name="id">
            </div>
            <div class="col-md-12">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Product Name</span>
              <input type="text" class="form-control" placeholder="Product Name" value="${product.name}" id="name" name="name">
            </div>
            <div class="col-md-4">
              <div class="col-md-12">
                <span class="card-title" style="font-size: 1em; margin-left: 5px;">Price</span>
                <input type="text" class="form-control" placeholder="Price" value="${product.price}" id="price" name="price">
              </div>
            </div>
            <div class="col-md-4">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Promotion</span>
              <input type="text" class="form-control" placeholder="Promotion" value="${product.promotion}" id="promotion" name="promotion">
            </div>
            <div class="col-md-4">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Category</span>
              <div class="mb-0">
                <select class="form-select" name="category">
                  <c:forEach items="${categories}" var="category">
                    <option value="${category.id}" id="category_id"
                            <c:if test="${category.id eq product.category.id}">
                              selected
                            </c:if>>${category.name}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="col-12">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Description</span>
              <input type="text" class="form-control" placeholder="Description" value="${product.description}" id="description" name="description">
            </div>
<%--            Size--%>
            <div class="col-md-4">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Status</span>
                <div class="form-check form-switch">
                  <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" ${product.enable ? 'checked' : ''} name="enable">
                  <c:choose>
                    <c:when test="${product.enable == true}">
                      <label class="form-check-label" for="flexSwitchCheckDefault">The product is being <label style="color: #06D001">activated</label></label>
                    </c:when>
                    <c:when test="${product.enable == false}">
                      <label class="form-check-label" for="flexSwitchCheckDefault">This product has been <label style="color: red">deactivated</label></label>
                    </c:when>
                  </c:choose>
                </div>
            </div>
            <div class="col-md-6" style="margin-bottom: 10px">
              <div class="widget_list color" style="margin-left: 5px;">
                <span class="card-title" style="font-size: 1em;">Size</span>
                <div style="display: flex">
                  <c:forEach items="${allSizes}" var="size">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input sizeCheckbox ${sizeCheckedMap[size] ? 'selected-size' : ''}"
                             value="${size}" id="size${size}" ${sizeCheckedMap[size] ? 'checked' : ''}>
                      <label class="form-check-label" for="size${size}">${size}</label>
                    </div>
                  </c:forEach>
                  <input type="hidden" id="selectedSizesInput" name="selectedSizes" value="">
                </div>
              </div>
            </div>


            <div class="col-md-12">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Image</span>
              <div class="mb-0">
                <c:forEach items="${imagesPro}" var="image">
                  <c:set var="isVideo" value="${image.img.indexOf('/video') != -1 ? 0 : -1}"/>
                  <div class="image-container">
                      <c:choose>
                        <c:when test="${isVideo == 0}">
                          <video controls src="${image.img}" height="150px" width="150px"></video>
                        </c:when>
                        <c:otherwise>
                          <img src="${image.img}" class="img-fluid rounded-start" style="width: 150px; height: 150px; margin-right: 10px; margin-top: 10px;">
                        </c:otherwise>
                      </c:choose>
                      <a href="/admin/products/delete-image/${image.id}" title="Delete" class="btn btn-danger" style="font-size: 15px"><i class="bi bi-trash"></i></a>
                  </div>
                </c:forEach>
              </div>
            </div>
            <div class="col-12 upload-image">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Add New Images</span>
              <input type="file" id="image-file" name="image-file" multiple/>
              <img id="uploaded-image" />
            </div>
            <div class="col-12 upload-video">
              <span class="card-title" style="font-size: 1em; margin-left: 5px;">Videos</span>
              <input type="file" id="video-file" name="video-file" accept="video/*" multiple/>
              <%--                            <img id="uploaded-video" />--%>
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-success">Update Product</button>
              <button type="reset" class="btn btn-secondary" id="listProductBtn">Cancel</button>
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
<script>
  document.getElementById('listProductBtn').addEventListener('click', function () {
    window.location.href = "/admin/products";
  });


  document.addEventListener("DOMContentLoaded", function () {
    var sizeCheckboxes = document.querySelectorAll('.sizeCheckbox');
    var selectedSizesInput = document.getElementById('selectedSizesInput');

    // Thêm sự kiện 'change' cho mỗi checkbox lựa chọn
    sizeCheckboxes.forEach(function (checkbox) {
      checkbox.addEventListener('change', updateSelectedOptions);
    });

    function updateSelectedOptions() {
      // Tạo một mảng để lưu trữ giá trị của các checkbox lựa chọn được chọn
      var selectedOptionsArray = [];

      // Kiểm tra trạng thái của từng checkbox lựa chọn và thêm giá trị vào mảng
      sizeCheckboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
          selectedOptionsArray.push(checkbox.value);
        }
      });

      // Hiển thị danh sách trong phần tử selectedOptions
      selectedSizesInput.value = selectedOptionsArray.join(',');
      console.log(selectedOptionsArray);
    }

  });
</script>

</body>

</html>