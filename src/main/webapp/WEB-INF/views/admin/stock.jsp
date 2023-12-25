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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
  <style>
    .button-icon{
      background-color: transparent;
      border: none;
      margin-right: 10px;
      font-size: 14px;
    }

    #autocomplete-container {
      position: relative;
    }
    tr input{
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    #autocomplete-input {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    #autocomplete-list {
      position: absolute;
      z-index: 1;
      list-style: none;
      margin: 0;
      padding: 0;
      width: 100%;
      max-height: 200px; /* Giới hạn chiều cao của danh sách */
      overflow-y: auto; /* Tạo ra thanh cuộn khi nội dung vượt quá chiều cao */
      border: 1px solid #ccc;
      border-top: none;
      border-bottom-left-radius: 4px;
      border-bottom-right-radius: 4px;
      display: none;
    }

    #autocomplete-list li {
      padding: 8px;
      cursor: pointer;
      background-color: #f9f9f9;
    }

    #autocomplete-list li:hover {
      background-color: #ddd;
    }
  </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
<jsp:include page="sidebar.jsp" />


<main id="main" class="main">
  <section class="section dashboard">
    <div class="row">
        <div class="col-lg-6">
        <div class="card">
          <div class="card-body">
            <form class="row g-3">
              <div class="col-12">
                <h5 class="card-title">Nhà cung cấp</h5>
                <select class="form-select">
                  <option selected>  Nhà cung cấp 1
                  </option>
                  <option> Nhà cung cấp 1</option>
                </select>
              </div>
            </form>
          </div>
        </div>
        </div>
      <div class="col-lg-6">
        <div class="card">
          <div class="card-body">
            <div class="contact_area">
              <div class="form-title">Tổng tiền: <span>Tiền</span></div>
              <div> <h5>Tổng tiền: <span>Tiền</span></h5></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div>
      <div class="col-lg-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Nhập kho</h5>
            <form autocomplete="off">

            <div class="datatable-container">
            <!-- Table with stripped rows -->
              <div>
                <button class="button-icon" style="color: green"><i class="bi bi-file-earmark-arrow-down"></i><br><span>Save</span></button>
                <button class="button-icon" style="color: red"><i class="bi bi-x" style="font-size: 18px"></i><br><span>Delete</span></button>
                <button class="button-icon" style="color: blue"><i class="bi bi-check" style="font-size: 18px"></i><br><span>Check</span></button>
              </div>
            <table class="table table-striped datatable datatable-table">
              <thead>
              <tr>
                <th scope="row" width="30px" style="text-align: center">STT</th>
                <th scope="col" >Sản phẩm</th>
                <th scope="col" width="100px">Số lượng</th>
                <th scope="col">Đơn giá</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <th scope="row" style="text-align: center">#</th>
                <td>
                  <div id="autocomplete-container">
                    <input type="text" id="autocomplete-input" placeholder="Search..." style="width: 100%">
                    <ul id="autocomplete-list"></ul>
                  </div>
                </td>
                <td><input type="text"></td>
                <td><input type="text"></td>
              </tr>

              <tr>
                <th scope="row" style="text-align: center">1</th>
                <td>Brandon Jacob</td>
                <td>Designer</td>
                <td>28</td>
              </tr>
              </tbody>
            </table>
            <!-- End Table with stripped rows -->
            </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
</main>


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
  let arraysData = [];

  var inputElement = document.getElementById("autocomplete-input");
  var listElement = document.getElementById("autocomplete-list");

  inputElement.addEventListener("input", function() {
    getData();
    var inputValue = inputElement.value.toLowerCase();
    var matches = arraysData.filter(function(arr) {
      return arr.toLowerCase().includes(inputValue);
    });

    displayMatches(matches);
  });

  function displayMatches(matches) {
    if (matches.length === 0) {
      listElement.style.display = "none";
      return;
    }

    listElement.innerHTML = "";
    matches.forEach(function(match) {
      var listItem = document.createElement("li");
      listItem.textContent = match;
      listItem.addEventListener("click", function() {
        inputElement.value = match;
        listElement.style.display = "none";
      });
      listElement.appendChild(listItem);
    });

    listElement.style.display = "block";
  }

  // Hide autocomplete list when clicking outside the container
  document.addEventListener("click", function(event) {
    if (!event.target.closest("#autocomplete-container")) {
      listElement.style.display = "none";
    }
  });

  function getData(){
    var inputElement = document.getElementById("autocomplete-input");
    var inputValue = inputElement.value;
    $.ajax({
      url: '/vendor/stock/getProduct?query='+inputValue,
      type: "get",
      contentType: "application/json; charset=utf-8",
      success: function (response) {
        arraysData=response;
        console.log(arraysData);
      }
    });
  }





</script>

</body>

</html>