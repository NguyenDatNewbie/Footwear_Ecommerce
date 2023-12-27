<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/common/taglib.jsp" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Contact us page</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="/assets/img/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    <!-- CSS
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="/assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="/assets/css/style.css">
    <style>
        .content {
            margin: 50px 20px;
        }

        .address select {
            width: 100%;
            height: 30px;
            background-color: black;
            color: white;
            font-weight: 550;
            font-size: 16px;
            font-family: Emoji;
            padding: 5px;
        }

        .list-frame {
            background-color: #FBF6EE;
            width: 100%;
            color: black;
            font-size: 14px;
            font-family: Emoji;
            border-right: 1px solid black;
            border-left: 1px solid black;
        }

        .department {
            padding: 5px;
            border-bottom: 1px solid black;
        }

        #address li:hover {
            cursor: pointer;
            background: #FFB534;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="content">
    <!--contact area start-->
    <div class="contact_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-12 address">
                    <div style="display: flex">
                        <div style="margin-right: 3%; width: 50%">
                            <select id="city">
                                <c:forEach items="${storeRepository.findOneColumnCity()}" var="city">
                                    <c:choose>
                                        <c:when test="${loopStatus.first}">
                                            <option value="${city}" selected>${city}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${city}">${city}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                        <div style="width: 50%; margin-left: 3%">
                            <select id="district">
                            </select>
                        </div>
                    </div>
                    <div>
                        <div class="list-frame">
                            <ul id="address">

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-12">
                    <div id="map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.485398611104!2d106.76933817514038!3d10.850637657820295!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752763f23816ab%3A0x282f711441b6916f!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBTxrAgcGjhuqFtIEvhu7kgdGh14bqtdCBUaMOgbmggcGjhu5EgSOG7kyBDaMOtIE1pbmg!5e0!3m2!1svi!2s!4v1703687312025!5m2!1svi!2s"
                                width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--contact area end-->
</div>

<jsp:include page="footer.jsp"/>
<!-- JS
============================================ -->

<!--map js code here-->
<!-- Plugins JS -->
<script src="/assets/js/plugins.js"></script>
<!-- Main JS -->
<script src="/assets/js/main.js"></script>

<script>
    function getDistrist() {
        return new Promise(function (resolve, reject) {
            console.log(0);
            $.ajax({
                url: '/contact/district/' + document.getElementById('city').value,
                type: "get",
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    createOptionDistrict(response, function () {
                        resolve();
                    });
                },
                error: function (error) {
                    reject(error); // Gọi reject khi có lỗi trong AJAX request
                }

            });
        })
    }

    function createOptionDistrict(response, callback) {
        var select = document.getElementById('district');
        select.innerHTML = '';
        var op = document.createElement('option');
        op.textContent = "Chọn quận huyện";
        op.value = '0';
        op.selected = true;
        select.appendChild(op);
        response.forEach(function (data) {
            var op = document.createElement('option');
            op.textContent = data;
            op.value = data;
            select.appendChild(op);
        });
        callback();
    }

    function getStores() {
        var address = document.getElementById('city').value;
        var district = document.getElementById('district').value;
        if (district !== '0')
            address = district + ',' + address;
        console.log(address);
        $.ajax({
            url: '/contact/getStore?address=' + address,
            type: "get",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                createStores(response);
            }
        });
    }

    function createStores(response) {
        var ul = document.getElementById('address');
        ul.innerHTML = '';
        response.forEach(function (data) {
            var li = document.createElement('li');
            var div = document.createElement('div');
            div.classList.add('department');
            var span = document.createElement('span');
            var i = document.createElement('i');
            i.classList.add('fas');
            i.classList.add('fa-store');
            i.style.marginRight = "3px";
            span.textContent = data.department;
            div.appendChild(i);
            div.appendChild(span);
            li.appendChild(div);
            ul.appendChild(li);

            // Thêm sự kiện click cho mỗi li
            li.addEventListener('click', function () {
                console.log(data.department);
                createMap(data.department);
            });
        });
    }

    function createMap(address) {
        document.getElementById('map').innerHTML = '<iframe\n' +
            '                                width="600"\n' +
            '                                height="450"\n' +
            '                                style="border:0"\n' +
            '                                loading="lazy"\n' +
            '                                allowfullscreen\n' +
            '                                referrerpolicy="no-referrer-when-downgrade"\n' +
            '                                src="https://www.google.com/maps/embed/v1/place?language=vi-vn&key=AIzaSyAUic2ta4mUKXuPpbszvDGMy1D8FosuFm8&q=' +
            address +
            '">\n' +
            '                        </iframe>'
    }

    window.addEventListener('load', function () {
        document.getElementById('city').addEventListener('change', function () {
            getDistrist().then(function () {
                getStores();
            })
            document.getElementById('district').addEventListener('change', function () {
                getStores();
            })
        });
        getDistrist().then(function () {
            getStores();
        })
        document.getElementById('district').addEventListener('change', function () {
            getStores();
        })
    })
</script>


</body>
</html>
