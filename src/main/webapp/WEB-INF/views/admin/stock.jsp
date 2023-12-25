<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/common/taglib.jsp" %>
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
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

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
        .button-icon {
            background-color: transparent;
            border: none;
            margin-right: 10px;
            font-size: 14px;
        }

        #autocomplete-container {
            position: relative;
        }

        tr input {
            width: 100%;
            padding: 3px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        #autocomplete-input {
            width: 100%;
            padding: 3px;
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
        .hidden{
            display: none;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp"/>
<!-- ======= Sidebar ======= -->
<jsp:include page="sidebar.jsp"/>


<main id="main" class="main">
    <section class="section dashboard">
        <div class="row">
            <div class="alert alert-success alert-dismissible fade show hidden" role="alert">
                <i class="bi bi-check-circle me-1"></i>
                Nhập hàng thành công
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <form class="row g-3">
                            <div class="col-12">
                                <h5 class="card-title">Nhà cung cấp</h5>
                                <select class="form-select">
                                    <c:forEach var="supplier" items="${supplierRepository.findAll()}">
                                        <c:choose>
                                            <c:when test="${loop.index eq 0}">
                                                <option value="${supplier.id}" selected>${supplier.name}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${supplier.id}">${supplier.name}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
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
                            <div><h5>Tổng tiền: <span>Tiền</span></h5></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div style="display: flex">
                            <h5 class="card-title" style="flex: 1">Nhập kho</h5>
                            <button class="btn btn-outline-success" onclick="add()" style="margin: 20px 0 15px 0;width: 75px;font-weight: 550;font-size: 17px;">Lưu</button>
                        </div>
                        <div class="datatable-container">
                            <!-- Table with stripped rows -->
                            <div>
                                <button class="button-icon" onclick="addData()" style="color: blue"><i
                                        class="bi bi-file-earmark-arrow-down"></i><br><span>Lưu dòng</span></button>
                                <button class="button-icon" onclick="resetInput()" style="color: green"><i class="bi bi-plus"
                                                                                   style="font-size: 18px"></i><br><span>Thêm mới</span>
                                </button>
                                <button class="button-icon" onclick="deleteItem()" style="color: red"><i class="bi bi-x"
                                                                                  style="font-size: 18px"></i><br><span>Xóa</span>
                                </button>
                                <button class="button-icon" style="color: blueviolet"><i class="bi bi-check"
                                                                                   style="font-size: 18px"></i><br><span>Kiểm kê</span>
                                </button>
                            </div>
                            <table class="table table-striped datatable datatable-table" id="stockTable">
                                <input value="" style="display: none" id="itemTable">
                                <thead>
                                <tr>
                                    <th scope="row" width="30px" style="text-align: center">STT</th>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col" width="120px">Kích thước</th>
                                    <th scope="col" width="100px">Số lượng</th>
                                    <th scope="col">Đơn giá (VNĐ)</th>
                                </tr>
                                </thead>
                                <tbody id="product-content">
                                <tr>
                                    <th scope="row" style="text-align: center">#</th>
                                    <td>
                                        <div id="autocomplete-container">
                                            <input type="text" id="autocomplete-input" placeholder="Search..."
                                                   style="width: 100%">
                                            <ul id="autocomplete-list"></ul>
                                        </div>
                                    </td>
                                    <td>
                                        <select id="size" style="width: 100%; padding: 2px">
                                        </select>
                                    </td>
                                    <td><input type="number" id="quantity"></td>
                                    <td><input type="number" id="price"></td>
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

<%--Get data--%>
<script>
    let arraysData = [];
    let sizesData = [];
    var inputElement = document.getElementById("autocomplete-input");
    var listElement = document.getElementById("autocomplete-list");
    var selectElement = document.getElementById("size");
    inputElement.addEventListener("input", function () {
        getData();
        var inputValue = inputElement.value.toLowerCase();
        var matches = arraysData.filter(function (arr) {
            return arr.name.toLowerCase().includes(inputValue);
        });
        displayMatches(matches);
    });

    function displayMatches(matches) {
        if (matches.length === 0) {
            listElement.style.display = "none";
            return;
        }

        listElement.innerHTML = "";
        selectElement.innerHTML = "";
        matches.forEach(function (match) {
            var listItem = document.createElement("li");
            listItem.textContent = match.name;
            listItem.addEventListener("click", function () {
                inputElement.value = match.name;
                listElement.style.display = "none";
                // Tao list select size
                var isTrue = true;
                match.sizes.forEach(function (size) {
                    var option = document.createElement("option");
                    option.value = size.id;
                    option.textContent = size.size;
                    if (isTrue) {
                        option.selected = true;
                        isTrue = false;
                    }
                    selectElement.appendChild(option);
                });
            });
            listElement.appendChild(listItem);
        });

        listElement.style.display = "block";
    }

    // Hide autocomplete list when clicking outside the container
    document.addEventListener("click", function (event) {
        if (!event.target.closest("#autocomplete-container")) {
            listElement.style.display = "none";
        }
    });

    function getData() {
        var inputElement = document.getElementById("autocomplete-input");
        var inputValue = inputElement.value;
        $.ajax({
            url: '/vendor/stock/getProduct?query=' + inputValue,
            type: "get",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                arraysData = response;
            }
        });
    }


</script>
<%--Handle--%>
<script>
    function reset() {
        localStorage.removeItem("stock");
    }

    function resetInput() {
        var name = document.getElementById("autocomplete-input");
        name.value = '';
        name.disabled=false;
        var size = document.getElementById("size");
        size.innerHTML = '';
        size.disabled= false;
        document.getElementById("quantity").value = '';
        document.getElementById("price").value = '';
    }
    function deleteItem(){
        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        var index = parseInt(document.getElementById("itemTable").value);
        // Kiểm tra xem index có phải là một số hợp lệ hay không
        if (!isNaN(index) && index >= 0 && index < stocks.length) {
            // Sử dụng filter để tạo một mảng mới không chứa phần tử ở vị trí index
            stocks = stocks.filter(function (_, i) {
                return i !== index;
            });
            resetInput();
            localStorage.setItem("stocks", JSON.stringify(stocks));
            showData();
        }
    }
    function getText(value) {
        var name = document.getElementById("autocomplete-input")
        name.value = value.name;
        name.disabled = true;

        // Tao select size
        var select = document.getElementById("size");
        select.innerHTML = '';
        var option = document.createElement("option");
        option.value = value.size.id;
        option.textContent = value.size.size;
        option.selected = true;
        select.appendChild(option);
        select.disabled = true;

        document.getElementById("quantity").value = value.quantity;
        document.getElementById("price").value = value.price;
    }

    function addData() {
        let name = document.getElementById("autocomplete-input").value;
        var select = document.getElementById("size");
        let optionValue = select.value;
        let optionSize = select.options[selectElement.selectedIndex].textContent;

        let price = document.getElementById("price").value;
        let quantity = document.getElementById("quantity").value;

        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        if(!document.getElementById("autocomplete-input").disabled) {
            let  check = stocks.find(c => c.name == name && c.size.id == optionValue && c.price == price);
            var data;
            if (check) {
                data = check;
                data.quantity = parseInt(data.quantity) + parseInt(quantity);
            } else {
                data = {
                    name: name,
                    size: {
                        id: optionValue,
                        size: optionSize
                    },
                    quantity: quantity,
                    price: price
                }
            }
            stocks.push(data);
        }
        else {
            let index = document.getElementById("itemTable").value;
            stocks[index].quantity=quantity;
            stocks[index].price=price;
        }
        localStorage.setItem("stocks", JSON.stringify(stocks));
        resetInput();
        showData();
    }
    // Hàm gọi lại để xử lý sự kiện click cho từng dòng
    function createRowClickHandler(index, stock) {
        console.log(index);
        document.getElementById("itemTable").value = index;
        getText(stock);
    }
    function showData() {
        // Lấy thẻ table từ DOM (có thể có id là "stockTable")
        var table = document.getElementById("stockTable");

        // Xóa hết các dòng (trừ dòng đầu tiên là dòng tiêu đề) trong bảng
        for (var i = table.rows.length - 1; i > 1; i--) {
            table.deleteRow(i);
        }
        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        // Lặp qua mảng stocks và thêm từng dòng vào bảng
        var stt = 0;
        for(let i=stocks.length-1;i>=0;i--){
            var row = table.insertRow(stt + 2); // +2 để tránh ghi đè dòng tiêu đề va cac input
            stt += 1;
            var stock = stocks[i];
            // Thêm các ô vào dòng
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);

            // Thiết lập nội dung cho từng ô
            cell1.innerHTML = stt;
            cell1.style.textAlign = "center";
            cell2.innerHTML = stock.name;
            cell3.innerHTML = stock.size.size;
            cell4.innerHTML = stock.quantity;
            cell5.innerHTML = stock.price;

            row.style.cursor = "pointer";
            row.onclick = function () {
                createRowClickHandler(i, stocks[i]);
            }
        };
    }
    showData();
</script>
<script>
    function add(){
        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        var select = document.querySelector('.form-select');
        $.ajax({
            url: '/vendor/stock/save/' + select.value,
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(stocks),
            success: function (response) {
               var alert = document.querySelector(".alert-success");
               alert.classList.remove("hidden");
                setTimeout(function () {
                    alert.classList.add("hidden");
                    window.location.reload();
                }, 2000);
                localStorage.removeItem("stocks");
            }
        });
    }
</script>
</body>

</html>