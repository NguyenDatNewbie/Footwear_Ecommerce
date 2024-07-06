<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Import Product - Vendor</title>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">


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
        .content{
            padding: 20px 0 15px 0;
            font-size: 18px;
            color: #012970;
            font-family: "Poppins", sans-serif;
        }
        .content h5{
            font-weight: 600;
        }
        .check span{
            font-size: 16px;
        }
        .table-striped>tbody>tr:nth-of-type(odd)>*{
            --bs-table-bg-type: rgb(224, 247, 250);
        }
        .datatable-sorter::before{
            display: none;
        }
        .datatable-sorter::after{
            display: none;
        }
        .datatable-sorter{
            padding: 0;
        }
        .button-icon:hover{
            color: #ff6a28;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="../vendor/header.jsp"/>
<jsp:include page="sidebar.jsp"/>



<main id="main" class="main">
    <div class="pagetitle">
        <h1>Stock Management</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/vendor/home">Home</a></li>
                <li class="breadcrumb-item active">Import Product</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">
            <div class="alert alert-success alert-dismissible fade show hidden" role="alert">
                <i class="bi bi-check-circle me-1"></i>
                Nhập hàng thành công
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="col-lg-8">
                <div class="row">
                    <!-- Recent Sales -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="card-body">
                                <h5 class="card-title" style="display: flex;justify-content: space-between;">
                                    <div>Product <span>| The list of products to be restocked</span></div>
                                    <div>
                                        <button class="button-icon" style="font-size: 17px">
                                            <i class="bi bi-download"></i>
                                            Export
                                        </button>
                                    </div>
                                </h5>
                                <table class="table datatable">
                                    <thead>
                                    <tr>
                                        <th scope="col">Product Name</th>
                                        <th scope="col">Order</th>
                                        <th scope="col">Color</th>
                                        <th scope="col">Size</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Inventory</th>
                                        <th scope="col">Restock</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${importProduct}" var="outStock">
                                        <tr>
                                            <td>${outStock.size.product.id} - ${outStock.size.product.name}</td>
                                            <td>${outStock.orders.id}</td>
                                            <td>${outStock.color.color_name}</td>
                                            <td>${outStock.size.size}</td>
                                            <td>${outStock.quantity}</td>
                                            <c:set var="inventory" value="${iInventoryService.getQuantityOfProduct(storeID, outStock.size.id, outStock.color.id)}"/>
                                            <td>${inventory}</td>
                                            <td>${outStock.quantity - inventory}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div><!-- End Recent Sales -->
            </div><!-- End Right side columns -->
            <div class="col-lg-4">

                    <div class="card">
                        <div class="card-body">
                            <form class="row g-3">
                                <div class="col-12">
                                    <h5 class="card-title">Supplier</h5>
                                    <select class="form-select">
                                        <c:forEach var="supplier" items="${listSupplier}">
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
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="content statistics">
                                        <div>
                                            <h6>Total Price</h6>
                                            <span></span>
                                        </div>
                                        <div>
                                            <h6>Quantity</h6>
                                            <span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="content check">
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <div>
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between;">
                            <h5 class="card-title">Import Stock<span style="margin-left:6px; font-size: 14px">|</span><button class="button-icon" style="font-size: 16px"><i class="bi bi-upload"></i> Upload File </button></h5>
                            <button class="btn btn-outline-success" onclick="add()" style="margin: 20px 0 0 0;width: 75px;font-weight: 550;font-size: 17px;">Lưu</button>
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
                                <button class="button-icon" onclick="check()" style="color: blueviolet"><i class="bi bi-check"
                                                                                   style="font-size: 18px"></i><br><span>Kiểm kê</span>
                                </button>
                            </div>
                            <table class="table table-striped datatable datatable-table" id="stockTable">
                                <input value="" style="display: none" id="itemTable">
                                <thead>
                                <tr style="background-color: #4dd0e1">
                                    <th scope="row" width="30px" style="text-align: center">STT</th>
                                    <th scope="col">Sản phẩm *</th>
                                    <th scope="col" width="120px">Kích thước *</th>
                                    <th scope="col" width="120px">Màu *</th>
                                    <th scope="col" width="120px">Số lượng *</th>
                                    <th scope="col">Đơn giá (VNĐ) *</th>
                                    <th scope="col">Ưu tiên Order</th>
                                </tr>
                                </thead>
                                <tbody id="product-content">
                                <tr>
                                    <th scope="row" style="text-align: center">#</th>
                                    <td>
                                        <div id="autocomplete-container">
                                            <input type="text" id="autocomplete-input" placeholder="Search..."
                                                   autocomplete="off"   style="width: 100%">
                                            <ul id="autocomplete-list"></ul>
                                        </div>
                                    </td>
                                    <td>
                                        <select id="size" style="width: 100%; padding: 2px">
                                        </select>
                                    </td>
                                    <td>
                                        <select id="color" style="width: 100%; padding: 2px">
                                            <c:forEach var="color" items="${colors}">
                                                <option value="${color.id}">${color.color_name}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td><input type="number" id="quantity" oninput="validateInput(this)"></td>
                                    <td><input type="number" id="price" oninput="validateInput(this)"></td>
                                    <td>
                                        <select id="priority" style="width: 100%; padding: 2px">
                                            <option value="0" >None</option>
                                            <c:forEach var="outOfStock" items="${productOutOfStock}">
                                                <option value="${outOfStock.orders.id}">${outOfStock.orders.id} - ${outOfStock.orders.createdAt}</option>
                                            </c:forEach>
                                        </select>
                                    </td>

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
    const formatVND = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    function resetInput() {
        var name = document.getElementById("autocomplete-input");
        name.value = '';
        name.disabled=false;
        var size = document.getElementById("size");
        size.innerHTML = '';
        size.disabled= false;
        document.getElementById("color").disabled = false;
        document.getElementById("priority").value = "0";
        document.getElementById("quantity").value = '';
        document.getElementById("price").value = '';
        document.querySelector(".check").innerHTML='';
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
    function calculator(){
        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        let price = 0;
        let quantity = 0;
        console.log(stocks);
        stocks.forEach(function (stock){
            price += parseFloat(stock.price);
            quantity += parseInt(stock.quantity);
        })
        var content = document.querySelectorAll(".statistics div");
        content[0].querySelector("span").textContent=formatVND.format(price);
        content[1].querySelector("span").textContent=quantity;
    }
    function setSelectedOptions(selectElement,valueToSelect){
        for (var i = 0; i < selectElement.options.length; i++) {
            if (selectElement.options[i].value == valueToSelect) {
                selectElement.selectedIndex = i;
                break;
            }
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

        select = document.getElementById("color");
        setSelectedOptions(select,value.color.id);

        select = document.getElementById("priority");
        setSelectedOptions(select,value.priorityOrder.id);

        document.getElementById("quantity").value = value.quantity;
        document.getElementById("price").value = value.price;
    }

    function addData() {
        let name = document.getElementById("autocomplete-input").value;
        var select = document.getElementById("size");
        var selectColor = document.getElementById("color");
        var selectPriority = document.getElementById("priority");
        let optionValue = select.value;
        let optionSize = select.options[selectElement.selectedIndex].textContent;

        let price = document.getElementById("price").value;
        let quantity = document.getElementById("quantity").value;

        var stocks = JSON.parse(localStorage.getItem("stocks")) || [];
        if(!document.getElementById("autocomplete-input").disabled) {
            var check = stocks.findIndex(c =>   c.size.id == optionValue && c.price == price
                && c.color.id == selectColor.value && c.priorityOrder.id=== selectPriority.value);
            if (check !== -1) {
                stocks[check].quantity = parseInt(stocks[check].quantity) + parseInt(quantity);
                localStorage.setItem("stocks", JSON.stringify(stocks));
            } else {
                var data;
                data = {
                    name: name,
                    size: {
                        id: optionValue,
                        size: optionSize
                    },
                    color:{
                        id: selectColor.value,
                        color_name: selectColor.options[selectColor.selectedIndex].textContent
                    },
                    priorityOrder: {
                        id: selectPriority.value,
                        text: selectPriority.options[selectPriority.selectedIndex].textContent
                    },
                    quantity: quantity,
                    price: price
                }
                stocks.push(data);
                localStorage.setItem("stocks", JSON.stringify(stocks));
            }
        }
        else {
            let index = document.getElementById("itemTable").value;
            stocks[index].quantity=quantity;
            stocks[index].price=price;
            stocks[index].color = {
                id: selectColor.value,
                color_name: selectColor.options[selectColor.selectedIndex].textContent
            };
            stocks[index].priorityOrder ={
                id: selectPriority.value,
                text: selectPriority.options[selectPriority.selectedIndex].textContent
            }
            localStorage.setItem("stocks", JSON.stringify(stocks));
        }
        resetInput();
        showData();
    }
    function check(){
        $.ajax({
            url: '/vendor/stock/check/inventory?size=' + document.getElementById("size").value
                +"&color="+document.getElementById("color").value,
            type: "get",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                document.querySelector(".check").innerHTML ='<div>\n' +
                    '                    <h5 style="margin: 0">Sản phẩm</h5><span>' +
                    response.product +' - '+ response.color +
                    '</span>\n' +
                    '                </div>\n' +
                    '                <div style="display: flex;justify-content: space-between;">\n' +
                    '                    <h5>Kích thước:</h5><span>' +
                    response.size+
                    '</span>\n' +
                    '                </div>\n' +
                    '                <div style="display: flex;justify-content: space-between;">\n' +
                    '                    <h5>Tồn kho:</h5> <span>' +
                    response.quantity+
                    '</span>\n' +
                    '                </div>'

            }
        });
    }
    // Hàm gọi lại để xử lý sự kiện click cho từng dòng
    function createRowClickHandler(index, stock) {
        document.getElementById("itemTable").value = index;
        getText(stock);
    }
    function showData() {
        document.querySelector(".check").innerHTML='';
        // Lấy thẻ table từ DOM (có thể có id là "stockTable")
        var table = document.getElementById("stockTable");

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
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            // Thiết lập nội dung cho từng ô
            cell1.innerHTML = stt;
            cell1.style.textAlign = "center";
            cell2.innerHTML = stock.name;
            cell3.innerHTML = stock.size.size;
            cell4.innerHTML = stock.color.color_name;
            cell5.innerHTML = stock.quantity;
            cell6.innerHTML = formatVND.format(parseFloat(stock.price));
            cell7.innerHTML = stock.priorityOrder.text;

            row.style.cursor = "pointer";
            row.onclick = function () {
                createRowClickHandler(i, stocks[i]);
            }
        };
        calculator();
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
<script>
    function validateInput(input) {
        if (input.value < 0) {
            alert("Vui lòng nhập một số lớn hơn hoặc bằng 0.");
            input.value = 1; // Hoặc bạn có thể đặt giá trị mặc định khác
        }
    }
</script>
<%--Export file--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelector('.button-icon').addEventListener("click",function (){
            exportFile();
        })
        var btn = document.querySelectorAll('.button-icon');
        btn[1].addEventListener("click",function (){
            openNewTab("/excel/import");
        })
    });

    function exportFile(){
        $.ajax({
            url: '/excel/download?store=${storeID}',
            type: "get",
            xhrFields: {
                responseType: 'blob' // Xác định kiểu dữ liệu phản hồi là blob (binary data)
            },
            success: function(response, status, xhr) {
                // Xử lý phản hồi thành công
                var contentType = xhr.getResponseHeader('Content-Type');
                var contentDisposition = xhr.getResponseHeader('Content-Disposition');


                // Tạo một đường dẫn URL tạm thời cho file Excel
                var blob = new Blob([response], { type: contentType });
                var url = window.URL.createObjectURL(blob);

                // Tạo một thẻ <a> ẩn để tải xuống file
                var a = document.createElement('a');
                a.href = url;
                a.download = getFileName(contentDisposition); // Lấy tên file từ Content-Disposition header
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);

                // Giải phóng đường dẫn URL
                window.URL.revokeObjectURL(url);

            },
            error: function(xhr, status, error) {

                // Xử lý lỗi
                console.error('Lỗi khi gọi API: ' + error);
            }
        });
    }

    function getFileName(contentDisposition) {
        var filename = '';
        var startIndex = contentDisposition.indexOf('filename=');
        if (startIndex !== -1) {
            filename = contentDisposition.substring(startIndex + 9);
            filename = filename.replace(/"/g, ''); // Loại bỏ dấu ngoặc kép (nếu có)
        }
        return filename;
    }

    function openNewTab(url) {
        var newTab = window.open(url, '_blank');
        newTab.focus();
    }

</script>
</body>

</html>