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
    /* The container */
    .container-color {
      display: block;
      position: relative;
      padding-left: 35px;
      margin-bottom: 12px;
      cursor: pointer;
      font-size: 22px;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }

    /* Hide the browser's default checkbox */
    .container-color input {
      position: absolute;
      opacity: 0;
      cursor: pointer;
      height: 0;
      width: 0;
    }

    /* Create a custom checkbox */
    .checkmark {
      position: absolute;
      top: 0;
      left: 0;
      height: 25px;
      width: 25px;
      background-color: #eee;
      border: 1px solid #000;
    }


    /* Create the checkmark/indicator (hidden when not checked) */
    .checkmark:after {
      content: "";
      position: absolute;
      display: none;
    }

    /* Show the checkmark when checked */
    .container-color.active input:checked ~ .checkmark:after {
      display: block;
    }

    /* Style the checkmark/indicator */
    .container-color.active .checkmark:after {
      left: 7px;
      top: 1px;
      width: 10px;
      height: 17px;
      border: solid white;
      border-width: 0 3px 3px 0;
      -webkit-transform: rotate(45deg);
      -ms-transform: rotate(45deg);
      transform: rotate(45deg);
    }
    .container-color p{
      display: none;
    }
    .form-check{
      padding-right: 10px;
      font-size: 15px;
    }

  </style>
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
    <h1>Manager Product</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<c:url value="/admin/home"/>">Home</a></li>
        <li class="breadcrumb-item active">Product</li>
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
                <h5 class="card-title">All Product Of Reid Shop</h5>
                <!-- Basic Modal -->
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#ExtralargeModal">
                  New Product
                </button>
                <div class="modal fade" id="ExtralargeModal" tabindex="-1">
                  <div class="modal-dialog modal-dialog-centered modal-xl">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Add New Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                        <form class="row g-3" action="<c:url value="/admin/products/addNewProduct"/> " method="post" enctype="multipart/form-data">
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
                                  <option value="${category.id}" id="category_id">${category.name}</option>
                                </c:forEach>
                              </select>
                            </div>
                          </div>
                          <div class="col-md-6" style="margin-bottom: 10px">
                            <div class="widget_list color" style="margin-left: 5px;">
                              <span class="card-title" style="font-size: 1em;">Color</span>
                              <div style="display: flex">
                                <label class="container-color" data-value="White">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: #DEE9F2"></span>
                                  <p>White</p>
                                </label>
                                <label class="container-color" data-value="Black">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: black"></span>
                                  <p>Black</p>
                                </label>
                                <label class="container-color" data-value="Grey">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: #95ABBD"></span>
                                  <p>Grey</p>
                                </label>
                                <label class="container-color" data-value="Green">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: green"></span>
                                  <p>Green</p>
                                </label>
                                <label class="container-color" data-value="Red">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: red"></span>
                                  <p>Red</p>
                                </label>
                                <label class="container-color" data-value="Orange">
                                  <input type="checkbox">
                                  <span class="checkmark" style="background-color: #F57B1B"></span>
                                  <p>Orange</p>
                                </label>
                              </div>
                            </div>
                          </div>
                          <input type="hidden" name="color" id="color" value="White">
                          <div class="col-md-6" style="margin-bottom: 10px">
                            <div class="widget_list color" style="margin-left: 5px;">
                              <span class="card-title" style="font-size: 1em;">Size</span>
                              <div style="display: flex">
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="38">
                                  <label class="form-check-label">38</label>
                                </div>
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="39">
                                  <label class="form-check-label">39</label>
                                </div>
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="40">
                                  <label class="form-check-label">40</label>
                                </div>
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="41">
                                  <label class="form-check-label">41</label>
                                </div>
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="42">
                                  <label class="form-check-label">42</label>
                                </div>
                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input sizeCheckbox" value="43">
                                  <label class="form-check-label">43</label>
                                </div>
                                <input type="hidden" id="selectedSizesInput" name="selectedSizes" value="">
                              </div>
                            </div>
                          </div>
                          <div class="col-12">
                            <span class="card-title" style="font-size: 1em; margin-left: 5px;">Description</span>
                            <textarea class="form-control" placeholder="Description" value="${product.description}" id="description" name="description" style="height: 100px;"></textarea>
                          </div>
                          <div class="col-12 upload-image">
                            <span class="card-title" style="font-size: 1em; margin-left: 5px;">Images</span>
                            <input type="file" id="image-file" name="image-file" multiple/>
<%--                            <img id="uploaded-image" />--%>
                          </div>
                          <div class="col-12 upload-video">
                            <span class="card-title" style="font-size: 1em; margin-left: 5px;">Videos</span>
                            <input type="file" id="video-file" name="video-file" accept="video/*" multiple/>
<%--                            <img id="uploaded-video" />--%>
                          </div>
                          <div class="text-center">
                            <button type="submit" class="btn btn-primary">Add</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                          </div>
                        </form><!-- End No Labels Form -->
                      </div>
                    </div>
                  </div>
                </div><!-- End Basic Modal-->

                <table class="table table-hover datatable">
                  <thead>
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Product Name</th>
                      <th scope="col">Price</th>
                      <th scope="col">Promotion</th>
                      <th scope="col">Sold</th>
                      <th scope="col">Category</th>
                      <th scope="col">Description</th>
                      <th scope="col">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${productRepository.AllProductOfSystem()}" var="product">
                      <tr>
                        <th scope="row">${product.id}</th>
                        <td>${product.name}</td>
                        <td style="text-align: center;">${formatVND.format(product.price)}</td>
                        <td style="text-align: center;">${product.promotion}%</td>
                        <td style="text-align: center;">${product.sold}</td>
                        <td style="text-align: center;">${product.category.name}</td>
                        <td>${product.description}</td>
                        <td>
                          <button type="button" onclick="window.location.href='/admin/products/edit/${product.id}'" class="btn btn-info">Detail</button>
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
<script>
  //Màu
  document.addEventListener("DOMContentLoaded", function () {
    // Lắng nghe sự kiện click cho tất cả các phần tử có lớp "filter"
    var filterButtons = document.querySelectorAll(".container-color span");

    filterButtons.forEach(function (button) {
      button.addEventListener("click", function () {
        filterButtons.forEach(function (button) {
          if(button.parentElement.classList.contains('active'))
            button.parentElement.classList.remove('active');
        });
        button.parentElement.classList.add('active');
        document.getElementById('color').value =  button.parentElement.querySelector('p').textContent;
        console.log("Color: ", document.getElementById('color').value);
      });
    });

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