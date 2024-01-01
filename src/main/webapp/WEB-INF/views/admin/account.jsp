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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
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

              <div class="card-body">
                <h5 class="card-title">All Account</h5>
                <c:if test="${not empty successMessage}">
                  <div class="alert alert-primary bg-primary text-light border-0 alert-dismissible fade show" role="alert">
                      ${successMessage}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                  <div class="alert alert-danger bg-danger text-light border-0 alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                </c:if>
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#ExtralargeModal">
                  Add Account Vendor
                </button>
                <div class="modal fade" id="ExtralargeModal" tabindex="-1">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Register Account Vendor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                        <form class="row g-3 needs-validation" novalidate action="<c:url value="/admin/account/addNewAccountVendor"/> " method="post" onsubmit="return validateForm()">
                          <div class="col-12">
                            <label for="email" class="form-label">Email Register</label>
                            <div class="input-group has-validation">
                              <span class="input-group-text" id="inputGroupPrepend">@</span>
                              <input type="email" class="form-control" placeholder="Email address" value="${account.email}" id="email" name="email" required>
                              <div class="invalid-feedback">Please enter a valid Email address!</div>
                            </div>
                          </div>

                          <div class="col-12">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" placeholder="Password" value="${account.password}" id="password" name="password" required oninput="validatePassword()">
                            <div class="invalid-feedback" id="passwordError">Please enter a valid password!</div>
                          </div>

                          <div class="col-12">
                            <label for="rePassword" class="form-label">Re-enter Password</label>
                            <input type="password" name="rePassword" class="form-control" placeholder="Re-enter Password" id="rePassword" required oninput="validateRePassword()">
                            <div class="invalid-feedback" id="passwordMismatch">Passwords do not match!</div>
                          </div>
                          <div class="col-12">
                            <label class="form-label">Department Address</label>
                            <div class="tab-content" id="tab1">
                              <div class="flex-2">
                                <select class="form-select form-select-sm mb-3" id="city"
                                        aria-label=".form-select-sm" style="margin-right: 10px; font-size: 15px;">
                                  <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                                <select class="form-select form-select-sm mb-3" id="district"
                                        aria-label=".form-select-sm" style="margin-right: 10px; font-size: 15px;">
                                  <option value="" selected>Chọn quận huyện</option>
                                </select>
                              </div>

                              <div class="flex-2">
                                <select class="form-select form-select-sm" id="ward"
                                        aria-label=".form-select-sm" style="margin-right: 10px; font-size: 15px;">
                                  <option value="" selected>Chọn phường xã</option>
                                </select>

                                <input placeholder="Địa chỉ chi tiết" name="addressDetail"
                                       id="addressDetail"
                                       type="text" required style="margin-top: 10px; " class="form-control">
                              </div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" placeholder="Name" id="name" name="name">
                          </div>
                          <div class="col-md-6">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="number" class="form-control" placeholder="Phone Number" id="phoneNumber" name="phoneNumber">
                          </div>
                          <input type="text" hidden="hidden" name="addressDepartment" id="addressDepartment">
                          <div class="col-12">
                            <button class="btn btn-success w-100" type="submit" onclick="prepareCombinedValues()">Create Account</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div><!-- End Basic Modal-->

                <table class="table datatable ">
                  <thead>
                  <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Email</th>
                    <th scope="col">Role</th>
                    <th scope="col">Action</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${accountRepository.findAll()}" var="account">
                    <tr>
                      <th scope="row">${account.id}</th>
                      <td>${account.email}</td>
                      <td>
                        <c:choose>
                          <c:when test="${account.role == 'ADMIN'}">
                            <span class="badge bg-danger">${account.role}</span>
                          </c:when>
                          <c:when test="${account.role == 'VENDOR'}">
                            <span class="badge bg-success">${account.role}</span>
                          </c:when>
                          <c:when test="${account.role == 'USER'}">
                            <span class="badge bg-info">${account.role}</span>
                          </c:when>
                        </c:choose>
                      </td>
                      <td>
                        <button type="button" onclick="window.location.href='/admin/account/${account.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>


<script>
  function validateForm() {
    var password = document.getElementById("password").value;
    var rePassword = document.getElementById("rePassword");
    var mismatchMessage = document.getElementById("passwordMismatch");

    if (password !== rePassword.value) {
      mismatchMessage.style.display = "block";
      return false;
    } else {
      mismatchMessage.style.display = "none";
      return true;
    }
  }

  function validatePassword() {
    var passwordInput = document.getElementById("password");
    var passwordError = document.getElementById("passwordError");

    // Đặt các điều kiện của bạn ở đây
    var minLength = 8;
    var hasUpperCase = /[A-Z]/.test(passwordInput.value);
    var hasLowerCase = /[a-z]/.test(passwordInput.value);
    var hasSpecialCharacter = /[!@#$%^&*(),.?":{}|<>]/.test(passwordInput.value);

    if (
            passwordInput.value.length < minLength ||
            !hasUpperCase ||
            !hasLowerCase ||
            !hasSpecialCharacter
    ) {
      passwordError.style.display = "block";
      passwordInput.classList.add("is-invalid");
    } else {
      passwordError.style.display = "none";
      passwordInput.classList.remove("is-invalid");
    }
  }

  function validateRePassword() {
    var password = document.getElementById("password").value;
    var rePasswordInput = document.getElementById("rePassword");
    var passwordMismatchMessage = document.getElementById("passwordMismatch");

    if (password !== rePasswordInput.value) {
      passwordMismatchMessage.style.display = "block";
      rePasswordInput.setCustomValidity("Passwords do not match!"); // Bắt người dùng nhập lại
    } else {
      passwordMismatchMessage.style.display = "none";
      rePasswordInput.setCustomValidity(""); // Đặt trạng thái hợp lệ
    }
  }
</script>

<script>
  var citis = document.getElementById("city");
  var districts = document.getElementById("district");
  var wards = document.getElementById("ward");
  var Parameter = {
    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
    method: "GET",
    responseType: "application/json",
  };
  var promise = axios(Parameter);
  promise.then(function (result) {
    renderCity(result.data);
  });

  function renderCity(data) {
    for (const x of data) {
      citis.options[citis.options.length] = new Option(x.Name, x.Id);
    }
    citis.onchange = function () {
      district.length = 1;
      ward.length = 1;
      if(this.value != ""){
        const result = data.filter(n => n.Id === this.value);

        for (const k of result[0].Districts) {
          district.options[district.options.length] = new Option(k.Name, k.Id);
        }
      }
    };
    district.onchange = function () {
      ward.length = 1;
      const dataCity = data.filter((n) => n.Id === citis.value);
      if (this.value != "") {
        const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

        for (const w of dataWards) {
          wards.options[wards.options.length] = new Option(w.Name, w.Id);
        }
      }
    };
  }
</script>

<script>
  function prepareCombinedValues() {
    var city = document.getElementById('city');
    var district = document.getElementById('district');
    var ward = document.getElementById('district');
    var detail = document.getElementById('addressDetail').value;

    var valueCity = city.options[city.selectedIndex].textContent;
    var valueDistrict = district.options[district.selectedIndex].textContent;
    var valueWard = ward.options[ward.selectedIndex].textContent;


    var addressDepartment = detail + ", " + valueWard + ", " + valueDistrict + ", " + valueCity;

    // Cập nhật giá trị của thẻ input hidden
    document.getElementById("addressDepartment").value = addressDepartment;
    console.log(document.getElementById("addressDepartment").value);
  }
</script>
</body>

</html>