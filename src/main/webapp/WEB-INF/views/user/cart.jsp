<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Cart page</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="assets/img/favicon.ico">

    <!-- CSS
        ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .cart_link a i span {
            font-size: 12px;
        }

        .error-message {
            color: red;
            font-size: 13px;
            /*font-family: "Times New Roman";*/
        }

        .flex-2 {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
        }

        .form-select {
            flex-grow: 1; /* Chia đều khoảng trống trên dòng */
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
            color: #242424;
            font-weight: 500;
            border-radius: 0px;
        }

        .flex-2 select input {
            width: 100%;
        }

        .coupon_inner input {
            width: 100%;
            height: 31px;
            margin: 0;
            color: #242424;
            font-weight: 500;
        }

        .coupon_inner .radio input {
            width: fit-content;
            height: fit-content;
        }

        .coupon_inner .radio label {
            line-height: 13px;
            margin-right: 30px;
            margin-left: 5px;
        }

        .tab-content {
            display: none;
            background: #f6f6f6;
            border: 1px solid #e1e1e1;
            padding: 20px 10px;
        }

        .active {
            display: block;
        }

        .tab-label {
            cursor: pointer;
            margin-right: 10px;
            padding: 5px;
        }

        .tab-label:hover {
            background-color: #f0f0f0;
        }

        .tab-label.active {
            background-color: #e0e0e0;
        }

        .tab-content .store input {
            width: fit-content;
            height: fit-content;
        }

        .store ul li label {
            color: #242424;
        }

        .store #ul-address li label input label {
            margin-left: 7px;
            margin-right: 4px;
        }

        .store ul li label span {
            color: #10a702;
            font-size: 12px;
        }

        .scroll-container {
            max-height: 200px; /* Chiều cao của phần tử chứa danh sách */
            overflow: auto; /* Tạo thanh trượt khi nội dung vượt quá kích thước của phần tử */
        }

        .hidden {
            display: none;
        }

        .cart_subtotal p.cart_amount_deli {
            color: red;
            font-size: 16px;
            font-weight: 600;
        }

        .cart_subtotal p.cart_amount_store {
            color: #10a702;
            font-size: 14px;
            font-weight: 600;
        }

        .ri-secure-payment-line ul li {
            display: flex;
        }

        .ri-secure-payment-line input {
            height: fit-content;
            width: fit-content;
            margin: 6px 10px 3px 0px;
        }

        .ri-secure-payment-line {
            padding-top: 10px;
            border-top: 2px solid black;
        }

        .align-center {
            margin: auto;
            max-width: 450px;
        }

        .button_back {
            width: 450px;
            background: #fff;
            border-radius: 3px;
            border: 1px solid #ff6a28;
            color: #ff6a28;
            display: inline-block;
            height: 45px;
            line-height: 45px;
            padding: 0 16px;
            text-transform: uppercase;
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 3px;
            margin-top: 10px;
        }

        .button_back:hover {
            cursor: pointer;
            color: #ffffff;
            background: #ff6a28;
        }

        .cart_empty {
            margin-top: 75px;
            margin-bottom: 300px;
            width: fit-content;
        }

        .cart_empty span {
            font-size: 16px;
            font-family: auto;
            color: black;
        }

        .hidden {
            display: none;
        }

        .success {
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            padding: 15px;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 999;
            font-family: "Emoji";
            animation: slideIn 0.5s, slideOut 0.5s 1.5s forwards;
        }


        .success i {
            margin-right: 5px; /* Khoảng cách giữa biểu tượng và văn bản */
        }

        @keyframes slideIn {
            from {
                top: -50px;
                opacity: 0;
            }
            to {
                top: 10px;
                opacity: 1;
            }
        }

        @keyframes slideOut {
            from {
                top: 10px;
                opacity: 1;
            }
            to {
                top: -50px;
                opacity: 0;
            }
        }

        .popup-buttons{gap: 5.5rem;justify-content: center;}
    </style>


</head>

<body>


<!-- Header Section Begin-->
<jsp:include page="header.jsp"/>
<!-- Header Section End -->

<div id="messageBox" class="hidden success">
    <p id="messageContent"><i class="fas fa-check-circle"></i>Đặt hàng thành công</p>
</div>

<div id="content">
    <!--breadcrumbs area start-->
    <div class="breadcrumbs_area other_bread">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb_content">
                        <ul>
                            <li><a href="index.jsp">home</a></li>
                            <li>/</li>
                            <li>cart</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--breadcrumbs area end-->

    <!-- shopping cart area start -->
    <div class="shopping_cart_area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="table_desc">
                        <div class="cart_page table-responsive">
                            <table>
                                <thead>
                                <tr>
                                    <th class="product_remove">Xóa</th>
                                    <th class="product_thumb">Hình ảnh</th>
                                    <th class="product_name">Sản phẩm</th>
                                    <th class="product-price">Giá</th>
                                    <th class="product_quantity">Số lượng</th>
                                    <th class="product_total">Tổng tiền(VNĐ)</th>
                                </tr>
                                </thead>
                                <tbody id="t-body">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <form action="javascript:pay()" method="post" id="form-cart">
                <!--coupon code area start-->
                <div class="coupon_area">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="coupon_code left">
                                <h3>Thông tin giao hàng</h3>

                                <div class="coupon_inner">
                                    <div class="flex-2" style="margin-bottom: 15px">
                                        <input
                                                placeholder="Họ và tên" name="name" type="text" id="name"
                                                required style="margin-right: 10px">
                                        <input
                                                placeholder="Số điện thoại nhận hàng" name="phone" type="text"
                                                id="phone"
                                                required>
                                    </div>

                                    <h4>CHỌN CÁCH THỨC NHẬN HÀNG</h4>

                                    <div class="flex-2 radio" style="margin-bottom: 20px">
                                        <div class="tab-label" onclick="openTab('tab1')">
                                            <input type="radio" id="tab1-radio" name="tab-radio" class="radio-input">
                                            <label>Giao tận nơi</label>
                                            </input>
                                        </div>

                                        <div class="tab-label" onclick="openTab('tab2')">
                                            <input type="radio" id="tab2-radio" name="tab-radio" class="radio-input">
                                            <label for="tab2-radio">Nhận tại cửa hàng</label>
                                        </div>
                                    </div>

                                    <div id="error-message" class="error-message"></div>
                                    <div class="tab-content" id="tab1">
                                        <div class="flex-2">
                                            <select class="form-select form-select-sm mb-3" id="city"
                                                    aria-label=".form-select-sm" style="margin-right: 10px">
                                                <option value="" selected>Chọn tỉnh thành</option>
                                            </select>
                                            <select class="form-select form-select-sm mb-3" id="district"
                                                    aria-label=".form-select-sm">
                                                <option value="" selected>Chọn quận huyện</option>
                                            </select>
                                        </div>

                                        <div class="flex-2">
                                            <select class="form-select form-select-sm" id="ward"
                                                    aria-label=".form-select-sm" style="margin-right: 10px">
                                                <option value="" selected>Chọn phường xã</option>
                                            </select>

                                            <input placeholder="Địa chỉ giao hàng" name="addressDetail"
                                                   id="addressDetail"
                                                   type="text" required>
                                        </div>
                                    </div>

                                    <div id="radio-error-message" class="error-message"></div>
                                    <div class="tab-content" id="tab2">
                                        <div class="flex-2">
                                            <select class="form-select form-select-sm mb-3" id="city1"
                                                    aria-label=".form-select-sm" style="margin-right: 10px">
                                                <option value="" selected>Chọn tỉnh thành</option>
                                            </select>

                                            <select class="form-select form-select-sm mb-3" id="district1"
                                                    aria-label=".form-select-sm">
                                                <option value="" selected>Chọn quận huyện</option>
                                            </select>

                                        </div>
                                        <div class="store scroll-container">
                                            <ul id="ul-address">
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6">
                            <div class="coupon_code right" id="cart-sub">
                                <h3>Hóa đơn</h3>
                                <div class="coupon_inner">
                                    <div class="cart_subtotal" id="total_cart">
                                        <p>Tổng tiền</p>
                                    </div>
                                    <div class="cart_subtotal" id="price_deli">
                                        <p>Phí giao hàng</p>
                                        <p class="cart_amount_deli hidden" id="receive_deli"></p>

                                        <p class="cart_amount_store active" id="receive_store">Miễn phí</p>
                                    </div>
                                    <div class="cart_subtotal" id="subtotal">
                                        <p>Thành tiền</p>
                                    </div>
                                    <div class="ri-secure-payment-line">
                                        <h4 style="font-size: 14px">Chọn phương thức thanh toán:</h4>
                                        <ul id="ul-payment">
                                            <li>
                                                <input type="radio" name="payment" value="RECEIVE" checked>
                                                <div>
                                                    <i class="fa-solid fa-money-bill"></i>
                                                    <span>Thanh toán tại cửa hàng</span>
                                                </div>
                                            </li>
                                            <li>
                                                <input type="radio" name="payment" value="PAYPAL">
                                                <div>
                                                    <i class="fa-sharp fa-regular fa-money-bill"></i>
                                                    <span>Momo</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="checkout_btn">
                                        <button type="submit" id="btn-pay">Thanh toán</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--coupon code area end-->

                <input name="address" id="address"
                       type="text" style="display: none">
            </form>
        </div>
    </div>
    <!-- shopping cart area end -->
</div>

<!--footer area start-->
<jsp:include page="footer.jsp"/>
<!--footer area start-->
<!-- JS
============================================ -->


<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    function validateSelect() {
        var selectCity = document.getElementById('city');
        var selectDistrict = document.getElementById('district');
        var selectWard = document.getElementById('ward');
        let message = "";
        let result = "";
        if (selectCity.value === "")
            message += "thành phố ";
        if (selectDistrict.value === "")
            message += "huyện ";
        if (selectWard.value === "")
            message += "xã ";
        if (message !== "")
            result = "Vui lòng chọn " + message;

        return result;
    }

    function validateRadio() {
        var radioButtons = document.getElementsByName("option");
        var isChecked = false;

        for (var i = 0; i < radioButtons.length; i++) {
            if (radioButtons[i].checked) {
                isChecked = true;
                break;
            }
        }

        var errorMessageElement = document.getElementById("radio-error-message");

        if (!isChecked) {
            errorMessageElement.textContent = "Vui lòng chọn cửa hàng muốn đến nhận";
            return false;
        }
        return true;
    }

</script>
<script type="module" defer>
    import PopupManager from 'https://cdn.jsdelivr.net/gh/jorgeabrahan/popup_library@67068b1/popup/Popup.js'

    const btnClose = '<i style="font-size: 22px;color: red;" class="fa-regular fa-circle-xmark"></i>';
    const ConfirmationPopup = new PopupManager({btnClose});
    var form = document.getElementById('form-cart');

    if (localStorage.getItem('cart') !== null) {
        document.getElementById("form-cart").addEventListener("submit", function (event) {
            // Ngăn chặn hành động mặc định của sự kiện gửi
            event.preventDefault();
            const type = document.querySelector('.tab-content.active').id;
            let validate = validateSelect();
            if (type === "tab1" && validate !== "")
                document.getElementById('error-message').textContent = validate;
            else if (type === "tab2" && validateRadio() === false) {
            } else {
                if (type === "tab1" && localStorage.getItem('storeValid') === null) {
                    ConfirmationPopup.display({
                        title: '<h4 style="color: blue;font-weight: 500; font-size: 1.4rem">Thông báo</h4>',
                        content: '<span style="color: black;">Sản phẩm của cửa hàng chưa thể đáp ứng đủ số lượng yêu cầu.<br>Nếu quý khách đồng ý đợi chúng tôi một thời gian chúng tôi sẽ nhập đủ số lượng sản phẩm quý khách yêu cầu.<br> Nhân viên chúng tôi sẽ gọi điện tư vấn với quý khách.</span>',
                        buttons: {
                            elements: [
                                {
                                    text: 'Đồng ý',
                                    type: 'confirm',
                                    handler: function () {
                                        handleConfirmClick();
                                    }
                                },
                                {
                                    text: 'Hủy',
                                    type: 'error',
                                    handler: () => ConfirmationPopup.close()
                                }
                            ]
                        }

                    });
                } else {
                    form.submit();
                }
            }
        });

        function handleConfirmClick() {
            ConfirmationPopup.close();
            form.submit();
        }
    }
</script>
<script>
    function loadEmpty() {
        document.getElementById('content').innerHTML = '<div class="shopping_cart_area" >' +
            '<div class="container">\n' +
            '            <div class="align-center">\n' +
            '                <div class="cart_empty">\n' +
            '                    <img src="https://codescandy.com/coach/rtl/assets/images/bag.svg" style="width: 400px; height: auto">\n' +
            '                        <div style="text-align: center; margin-top: 4px;">\n' +
            '                            <span>Không có sản phẩm trong giỏ hàng</span><br>\n' +
            '                            <a href="/index" class="button_back">Về trang chủ</a>\n' +
            '                        </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </div>' +
            '        </div>';
    }

    function showCart() {
        let cart = localStorage.getItem('cart');
        if (cart !== null) {
            $.ajax({
                url: '/cart/getItem',
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: cart,
                success: function (response) {
                    document.getElementById("t-body").innerHTML = response;
                    showStore();
                }
            });
            reloadCartLength();
        } else {
            loadEmpty();
        }
    }

    function calCostShip() {
        var city = document.getElementById('city');
        var district = document.getElementById('district');
        var ward = document.getElementById('ward');


        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        var valueWard = ward.options[ward.selectedIndex].textContent;
        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";
        if (ward.value == "")
            valueWard = "";

        return new Promise((resolve, reject) => {
            var store = localStorage.getItem('storeValid');

            if (ward.value === "" || ward.value === null) {
                return resolve(0);
            } else {
                $.ajax({
                    url: '/getCostShip/' + valueWard + '/' + valueDistrict + '/' + valueCity,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: store !== null ? store : [],
                    success: function (response) {
                        return resolve(response);
                    },
                    error: function (error) {
                        reject(error);
                    }

                });
            }
        });

    }
</script>
<script>
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");
    var citis1 = document.getElementById("city1");
    var districts1 = document.getElementById("district1");
    var Parameter = {
        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
        method: "GET",
        responseType: "application/json",
    };
    var promise = axios(Parameter);
    if (localStorage.getItem('cart') !== null) {
        promise.then(function (result) {
            renderCity(result.data);
        });
    }


    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Id);
            citis1.options[citis1.options.length] = new Option(x.Name, x.Id);
        }

        citis1.onchange = function () {
            district1.length = 1;
            if (this.value != "") {
                const result = data.filter(n => n.Id === this.value);
                for (const k of result[0].Districts) {
                    district1.options[district1.options.length] = new Option(k.Name, k.Id);
                }
            }
            showStore();
        }

        district1.onchange = function () {
            showStore();
        };

        citis.onchange = function () {
            district.length = 1;
            ward.length = 1;
            if (this.value != "") {
                const result = data.filter(n => n.Id === this.value);

                for (const k of result[0].Districts) {
                    district.options[district.options.length] = new Option(k.Name, k.Id);
                }
            }
            document.getElementById('receive_deli').textContent = "";
            localStorage.removeItem("storeValid");
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
            document.getElementById('receive_deli').textContent = "";
            localStorage.removeItem("storeValid");
        };
        ward.onchange = function () {
            document.getElementById('error-message').textContent = "";
            findStore();
        }
    }

    function openTab(tabId) {
        document.getElementById('addressDetail').setAttribute('required', 'required');
        var receiveDeli = document.getElementById('receive_deli');
        var receiveStore = document.getElementById('receive_store');

        if (tabId === "tab2") {
            showOrder(0);
            receiveStore.classList.add("active");
            receiveStore.classList.remove("hidden");
            receiveDeli.classList.remove("active");
            receiveDeli.classList.add("hidden");
            document.getElementById('addressDetail').removeAttribute('required');
        }
        if (tabId === "tab1") {
            calCostShip()
                .then(cost => showOrder(cost))
                .catch(error => console.log(error));
            receiveDeli.classList.add("active");
            receiveDeli.classList.remove("hidden");
            receiveStore.classList.remove("active");
            receiveStore.classList.add("hidden");
        }

        // Lấy tất cả các tab content
        var tabContents = document.querySelectorAll(".tab-content");

        // Ẩn tất cả các tab content
        tabContents.forEach(function (content) {
            content.classList.remove("active");
        });

        // Hiển thị tab content được chọn
        var selectedTab = document.getElementById(tabId);
        if (selectedTab) {
            selectedTab.classList.add("active");
        }

        var radioId = tabId + "-radio";
        var radioButton = document.getElementById(radioId);
        if (radioButton) {
            radioButton.checked = true;
        }
    }

    openTab("tab1");
</script>
<script>
    function selectRadio(element) {
        // Xóa lớp 'selected' từ tất cả các div
        var radios = document.querySelectorAll('.custom-radio');
        radios.forEach(function (radio) {
            radio.classList.remove('selected');
        });

        // Thêm lớp 'selected' cho div được chọn
        element.classList.add('selected');

        // Đánh dấu radio button tương ứng là được chọn
        var radioInput = element.querySelector('input[type="radio"]');
        radioInput.checked = true;
    }

    function getSelectedValue() {
        // Tìm radio button được chọn
        var selectedRadio = document.querySelector('input[name="radioGroup"]:checked');

        // Kiểm tra xem có radio button nào được chọn không
        if (selectedRadio) {
            // Lấy giá trị của radio button được chọn
            var selectedValue = selectedRadio.parentElement.selectedValue.trim();

            // Hiển thị giá trị được chọn
            document.getElementById('selectedValue').innerText = "Selected Value: " + selectedValue;
        } else {
            // Nếu không có radio button nào được chọn
            document.getElementById('selectedValue').innerText = "No option selected";
        }
    }
</script>
<script>
    // Function để thêm một mục vào danh sách
    function addItemToList(item) {
        // Tạo một phần tử li
        const newListItem = document.createElement('li');

        // Tạo một phần tử label
        const labelElement = document.createElement('label');

        // Tạo phần tử input
        const inputElement = document.createElement('input');
        inputElement.setAttribute('type', 'radio');
        inputElement.setAttribute('name', 'option');
        inputElement.setAttribute('value', item.store.id); // Sử dụng storeId từ đối tượng item

        const pElement = document.createElement('label');
        pElement.textContent = item.store.department;
        pElement.style.marginLeft = "7px";
        pElement.style.marginRight = "4px";

        // Tạo phần tử span
        const spanElement = document.createElement('span');
        if (item.status == 1)
            spanElement.textContent = 'Còn hàng';
        else {
            spanElement.textContent = 'Nhận hàng sau 3 - 7 ngày';
            spanElement.style.color = "#e67e22";
        }

        // Gắn input và span vào label
        labelElement.appendChild(inputElement);
        labelElement.appendChild(pElement);
        labelElement.appendChild(spanElement);

        // Gắn label vào li
        newListItem.appendChild(labelElement);

        // Lấy danh sách ul theo id hoặc class
        const ulElement = document.getElementById('ul-address');

        // Gắn li vào ul
        ulElement.appendChild(newListItem);
    }


    function showStore() {
        let cart = localStorage.getItem('cart');
        var city = document.getElementById('city1');
        var district = document.getElementById('district1');
        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";

        var data = JSON.stringify({carts: JSON.parse(cart), city: valueCity, district: valueDistrict, wards: ""});
        $.ajax({
            url: '/cart/getStore/STORE',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function (response) {
                console.log(response);
                document.getElementById('ul-address').innerHTML = '';
                response.forEach(item => {
                    addItemToList(item);
                });
            }
        });
    }

    function findStore() {
        let cart = localStorage.getItem('cart');
        var city = document.getElementById('city');
        var district = document.getElementById('district');
        var ward = document.getElementById('ward');

        var valueCity = city.options[city.selectedIndex].textContent;
        var valueDistrict = district.options[district.selectedIndex].textContent;
        var valueWard = ward.options[ward.selectedIndex].textContent;

        if (city.value == "")
            valueCity = "";
        if (district.value == "")
            valueDistrict = "";
        if (ward.value == "")
            valueWard = "";

        var data = JSON.stringify({
            carts: JSON.parse(cart),
            city: valueCity,
            district: valueDistrict,
            wards: valueWard
        });
        $.ajax({
            url: '/cart/getStore/DELIVERY',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: data,
            success: function (response) {
                if (response.length > 0) {
                    localStorage.setItem("storeValid", JSON.stringify(response));
                    calCostShip()
                        .then(cost => showOrder(cost))
                        .catch(error => console.log(error));
                }
            }
        });
    }


    function changeQuantity(cell) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        let cellIndex = cell.parentNode.parentNode;
        cart[cellIndex.rowIndex - 1].quantity = parseInt(cell.value);
        localStorage.setItem('cart', JSON.stringify(cart));
        showCart();
    }

    function deleteItem(cell) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        let cellIndex = cell.parentNode.parentNode;
        cart.splice(cellIndex.rowIndex - 1, 1);
        localStorage.setItem('cart', JSON.stringify(cart));
        showCart();
    }

</script>
<script>
    function showMessage(){
        let messageBox = document.getElementById("messageBox");
        messageBox.classList.remove("hidden");
        setTimeout(function () {
            messageBox.classList.add("hidden");
            window.location.reload();
        }, 2000);


    }
    // Show Value Order
    function showOrder(cost) {
        var total_price = document.getElementById('total_cart');
        var total_last = document.getElementById('subtotal');
        let price = 0;
        if (cost === null)
            cost = 0;

        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });

        if (document.querySelector('.product-price.product_total')) {
            // Xóa đơn vị tiền tệ và xóa , và số sau ,
            price = parseFloat(document.querySelector('.product-price.product_total').textContent.replace(/[.₫]/g, ''));
        }

        // Xóa
        const amounts = document.querySelectorAll('.cart_amount');
        amounts.forEach(element => {
            element.remove();
        });
        // Thêm
        const valTotal = document.createElement('p');
        valTotal.classList.add('cart_amount');
        valTotal.textContent = formatter.format(price);


        const valTotalLast = document.createElement('p');
        valTotalLast.classList.add('cart_amount');
        valTotalLast.textContent = formatter.format(price + cost);

        total_price.appendChild(valTotal);
        var costHtml = document.getElementById("receive_deli");

        if (cost != 0)
            costHtml.textContent = formatter.format(cost);
        total_last.appendChild(valTotalLast);
    }

    function pay() {
        const type = document.querySelector('.tab-content.active').id;
        let cart = localStorage.getItem('cart');
        let store = localStorage.getItem('storeValid');
        var paymentOption = document.querySelector('input[name="payment"]:checked');


        if (type === "tab2") {
            if (document.getElementById("ul-address").children) {
                // var selectedElement = document.querySelector('#ul-address.selected');
                var selectedRadioButton = document.querySelector('input[name="option"]:checked');
                if (selectedRadioButton) {
                    var status = selectedRadioButton.parentElement.querySelector('span').textContent;
                    var statusValue = status != 'Còn hàng' ? '0' : '1';
                    var orders = {
                        name: document.getElementById('name').value,
                        phone: document.getElementById('phone').value
                    }
                    let storeValid = [{
                        status: statusValue,
                        store: {
                            id: selectedRadioButton.value
                        }
                    }]
                    var orderCombine = {
                        orders: orders,
                        carts: JSON.parse(cart),
                        storeValid: storeValid
                    }

                    $.ajax({
                        url: '/cart/payment/STORE/' + paymentOption.value,
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(orderCombine),
                        success: function (response) {
                            if (response != "success") {
                                window.location.href = "/sign-in-up"
                            }
                            else {
                                localStorage.removeItem('cart');
                                localStorage.removeItem('storeValid');
                                showMessage();
                            }
                        },
                        error: function (error){
                            console.log("errorPay",error);
                        }
                    });
                }
            }

        }// End ReceiveStore
        else {
            var city = document.getElementById('city');
            var district = document.getElementById('district');
            var ward = document.getElementById('district');
            var detail = document.getElementById('addressDetail').value;

            var valueCity = city.options[city.selectedIndex].textContent;
            var valueDistrict = district.options[district.selectedIndex].textContent;
            var valueWard = ward.options[ward.selectedIndex].textContent;

            var address = "";
            if (detail != "")
                address += detail + ", "
            if (ward !== "")
                address += valueWard + ", "
            if (district !== "")
                address += valueDistrict + ", "
            if (city != "")
                address += valueCity;
            var orders = {
                name: document.getElementById('name').value,
                phone: document.getElementById('phone').value,
                address: address
            }
            var storeValid = null;
            if (localStorage.getItem('storeValid') !== null)
                storeValid = JSON.parse(localStorage.getItem('storeValid'));
            orderCombine = {
                orders: orders,
                carts: JSON.parse(cart),
                storeValid: storeValid !== null ? storeValid : []
            }
            $.ajax({
                url: '/cart/payment/DELIVERY/' + paymentOption.value,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(orderCombine),
                success: function (response) {
                    if (response != "success") {
                        window.location.href = "/sign-in-up"
                    }
                    else {
                        localStorage.removeItem('cart');
                        localStorage.removeItem('storeValid');
                        showMessage();
                    }
                },
                error: function (error){
                    console.log("errorPay",error);
                }
            });
        }
    }
</script>
<script>
    function getDistance(origin, destination) {
        $.ajax({
            url: '/getDistances/' + origin + '/' + destination,
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                console.log(response);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    // getDistance('Hồ Chí Minh','Hà Nội');
</script>

<%--Xử lý sự kiện khi trang load xong--%>
<script>
    showCart();
    if (localStorage.getItem('cart') !== null) {
        window.addEventListener('load', function () {

            localStorage.removeItem("storeValid");
            // Sự kiện click được gắn vào thẻ ul để theo dõi các thẻ li
            document.getElementById('ul-address').addEventListener('click', function (event) {
                // Kiểm tra xem phần tử được nhấp có phải là thẻ li không
                const closestLi = event.target.closest('li');
                if (closestLi) {
                    // Tìm thẻ input radio trong thẻ li tương ứng
                    const radioInput = closestLi.querySelector('input[type="radio"]');
                    if (radioInput) {
                        // Gọi trực tiếp sự kiện click cho radioInput
                        radioInput.click();
                        showOrder(0);
                    }
                }
            });

            // Sự kiện click được gắn vào thẻ ul để theo dõi các thẻ li
            document.getElementById('ul-payment').addEventListener('click', function (event) {
                // Kiểm tra xem phần tử được nhấp có phải là thẻ li không
                const closestLi = event.target.closest('li');
                if (closestLi) {
                    // Tìm thẻ input radio trong thẻ li tương ứng
                    const radioInput = closestLi.querySelector('input[type="radio"]');
                    if (radioInput) {
                        // Gọi trực tiếp sự kiện click cho radioInput
                        radioInput.click();
                    }
                }
            });
        });
    }
</script>
</body>

</html>