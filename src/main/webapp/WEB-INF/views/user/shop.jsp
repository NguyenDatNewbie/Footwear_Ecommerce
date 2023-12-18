<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Shop</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="../../assets/img/favicon.ico">

    <!-- CSS
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="../../assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="../../assets/css/style.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>



    <style>
        .grid_list .product_thumb {
            margin-bottom: 0;
            min-width: 33.333333%;
            margin-right: 15px;
            width: 200px;
        }
        @media only screen and (min-width: 768px) and (max-width: 991px) {
            .grid_list .product_thumb {
                flex: 0 0 40.667%;
                min-width: 40.667%;
            }
        }
        @media only screen and (max-width: 767px) {
            .grid_list .product_thumb {
                flex: 0 0 100%;
                min-width: 100%;
                margin-right: 0;
                margin-bottom: 25px;
            }
        }
        .sidebar_widget.widget_categories ul li:focus {
            color: #ff6a28;
            font-style: oblique;
            font-size: 16px;
        }
        .ul_menu_children li{
            margin-left: 20px;

        }

        .ul_menu_children li a:hover span{
            color: #ff6a28;
        }


        .listPage li:hover{
            background: #ff6a28;
            color: #ffffff;
        }
        .listPage .active{
            background: #ff6a28;
            color: #ffffff;
        }
        .box {
            width: 30px;
            height: 30px;
            margin: 3px;
            display: inline-block;
            text-align: center;
            line-height: 30px;
            font-size: 14px;
            font-weight: bold;
            border: 1px solid #e9ecef;
            background: #fff;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .box_size:focus {
            outline: none;
        }
        .widget_list .active {
            background: #ff6a28;
            color: #ffffff;
            outline: none;
        }

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
        .brand-sidebar{
            margin-bottom: 5px;
        }
        .brand-sidebar p{
            color: black;
        }
        .brand-sidebar:hover > p,.brand-sidebar.active > p {
            color: #ff6a28;
            cursor: pointer;
        }
        .brand-sidebar:hover > p > span,
        .brand-sidebar.active > p > span
        {
            background: #ff6a28;
            color: #fff;
        }
        .brand-sidebar > p > input{
            display: none;
        }
        .brand-sidebar > p > span{
            float: right;
            background: #ebebeb;
            color: #c3c3c3;
            font-size: 12px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            text-align: center;
            border-radius: 50%;
        }
        .ul_menu .active{
            background: none;
        }
        .filter:hover{
            cursor: pointer;
            color: #ff6a28;
            width: fit-content;
        }
        .fa-times:before{
            margin-right: 5px;
        }
        .widget_list {
            margin-bottom: 30px;
        }
        .sidebar_widget > ul > li > p {
            padding-bottom: 0;
        }
        .sidebar_widget ul li{
            position: relative;
        }
        .sidebar_widget ul li ul input{
            display: none;
        }
        .brand-sidebar p{
            margin: 0px;
        }
        .sidebar_widget ul li{
            margin-bottom: 10px;
        }
        .sidebar_widget ul li ul {
            display:none;
            position:absolute;
            background:#fff;
            z-index: 2;
            left: 100%;
            top: 0;
            min-width: 200px;
            font-weight: 500;
            color: black;
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
        }
        .sidebar_widget ul li ul li{
            padding: 8px;
            margin: 0px;
        }
        .sidebar_widget ul li ul li:hover p{
            cursor: pointer;
            color: #ff6a28;
        }

        /*.sidebar_widget ul li ul li {*/
        /*    width:100%;*/
        /*    border-bottom:1px solid rgba(255,255,255,.3);*/
        /*}*/

        .sidebar_widget ul li:hover ul{
            display:block;
        }

    </style>
</head>

<body>


<jsp:include page="header.jsp"/>

<!--shop  area start-->
<div class="shop_area shop_reverse" style="margin-top: 50px">
    <div class="container">
        <div class="shop_inner_area">
            <div class="row">
                <div class="col-lg-3 col-md-12">
                    <!--sidebar widget start-->
                    <div class="sidebar_widget">
                        <div class="widget_list widget_filter">
                            <h2>Lọc theo giá</h2>
                            <form action="javascript:filterAll()">
                                <div id="slider-range"></div>
                                <button type="submit">Lọc</button>
                                <input type="text" name="productValue" id="amount" />
                            </form>
                        </div>
                        <div class="filter" style="display: none">
                            <i class="fas fa-times"style="margin-bottom: 10px;font-size: 18px;">Clear Filter</i>
                        </div>
                        <div class="widget_list sidebar_widget">
                            <h2>Brand</h2>
                            <ul style="font-size: 14px" class="ul_menu">
                                <c:forEach var="category" items="${categoryRepository.findAll()}">
                                    <li class="brand-sidebar">
                                        <p title="${category.name}">${category.name}<span>${productRepository.findAllByCategoryAndIsParent(category.id).size()}</span><input value="${category.id}"></p>
                                        <c:if test="${categoryRepository.familyByParent(category.id).size()>0}">
                                            <ul class="ul_menu_children">
                                                <c:forEach var="categoryChildren" items="${categoryRepository.familyByParent(category.id)}">
                                                    <li class="brand-sidebar"><p title="${categoryChildren.name}">${categoryChildren.name}</p><input value="${categoryChildren.id}"></li>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                        <div class="widget_list size">
                            <h2>Size</h2>
                            <div class="size_product" >
                                <div class="box box_size" onclick="changeSize(this)">37</div>
                                <div class="box box_size" onclick="changeSize(this)">38</div>
                                <div class="box box_size" onclick="changeSize(this)">39</div>
                                <div class="box box_size" onclick="changeSize(this)">40</div>
                                <div class="box box_size" onclick="changeSize(this)">41</div>
                                <div class="box box_size" onclick="changeSize(this)">42</div>
                                <div class="box box_size" onclick="changeSize(this)">43</div>
                                <div class="box box_size" onclick="changeSize(this)">44</div>
                                <div class="box box_size" onclick="changeSize(this)">45</div>
                                <div class="box box_size" onclick="changeSize(this)">46</div>
                            </div>
                        </div>

                        <div class="widget_list color">
                            <h2>Color</h2>
                            <div style="display: flex">
                               <label class="container-color">
                                   <input type="checkbox">
                                   <span class="checkmark" style="background-color: #DEE9F2"></span>
                                   <p>White</p>
                               </label>
                                <label class="container-color">
                                    <input type="checkbox">
                                    <span class="checkmark" style="background-color: black"></span>
                                    <p>Black</p>
                                </label>
                                <label class="container-color">
                                    <input type="checkbox">
                                    <span class="checkmark" style="background-color: #95ABBD"></span>
                                    <p>Grey</p>
                                </label>
                                <label class="container-color">
                                    <input type="checkbox">
                                    <span class="checkmark" style="background-color: green"></span>
                                    <p>Green</p>
                                </label>
                                <label class="container-color">
                                    <input type="checkbox">
                                    <span class="checkmark" style="background-color: red"></span>
                                    <p>Red</p>
                                </label>
                                <label class="container-color">
                                    <input type="checkbox">
                                    <span class="checkmark" style="background-color: #F57B1B"></span>
                                    <p>Orange</p>
                                </label>
                            </div>
                        </div>
                    </div>
                    <!--sidebar widget end-->
                </div>
                <div class="col-lg-9 col-md-12">
                    <!--shop wrapper start-->
                    <!--shop toolbar start-->
                    <div class="shop_title">
                           <h1></h1>
                    </div>
                    <div class="shop_toolbar_wrapper">
                        <div class="shop_toolbar_btn">

                            <button data-role="grid_3" type="button" class="active btn-grid-3" data-toggle="tooltip" title="3"></button>

                            <button data-role="grid_list" type="button"  class="btn-list" data-toggle="tooltip" title="List"></button>

                        </div>

                        <select  class="select_option" id="select_id" onchange="filterAll()">
                            <option value="0" selected>Sắp xếp</option>
                            <option value="1">Sản phẩm bán chạy</option>
                            <option value="2">Giá từ cao đến thấp</option>
                            <option value="3">Giá từ thấp đến cao</option>
                            <option value="4">A->Z</option>
                            <option value="5">Z->A</option>
                        </select>

                    </div>
                    <!--shop toolbar end-->

                    <div class="row shop_wrapper list" id="product_content" >
                        <c:forEach var="product" items="${products}">
                            <div class="col-lg-4 col-md-4 col-12 item" >
                                <div class="single_product">
                                    <div class="product_thumb">
                                        <c:if test="${product.images.size()>0}">
                                            <a class="primary_img" href="/product/${product.id}"><img src="${product.images.get(0).img}" alt=""></a>
                                        </c:if>
                                        <c:if test="${product.images.size()>1}">
                                            <a class="secondary_img" href="/product/${product.id}"><img src="${product.images.get(1).img}" alt=""></a>
                                        </c:if>

                                        <div class="quick_button">
                                            <a href="/product/${product.id}" title="quick_view">Xem sản phẩm</a>
                                        </div>


                                        <div class="product_sale">
                                            <c:if test="${product.promotion>0}"><span>-${product.promotion}%</span></c:if>
                                        </div>

                                    </div>

                                    <div class="product_content grid_content" >
                                        <h3><a href="product-details.jsp">${product.name}</a></h3>
                                        <c:choose>
                                            <c:when test="${product.promotion>0}">
                                                <span class="current_price" >${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                <span class="old_price">${formatVND.format(product.price)}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="current_price">${formatVND.format(product.price)}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="product_content list_content">
                                        <h3><a href="product-details.html">${product.name}</a></h3>
                                        <div class="product_ratting">
                                            <ul>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                                <li><a href="#"><i class="fa fa-star"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="product_price">
                                            <c:choose>
                                                <c:when test="${product.promotion>0}">
                                                    <span class="current_price">${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                    <span class="old_price">${formatVND.format(product.price)}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="current_price">${formatVND.format(product.price)}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product_desc">
                                            <p>${product.description}</p>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <div class="shop_toolbar t_bottom">
                        <div class="pagination" >
                            <ul class="listPage">
                            </ul>
                        </div>
                    </div>
                    <!--shop toolbar end-->
                    <!--shop wrapper end-->
                </div>
            </div>
        </div>

    </div>
</div>
<!--shop  area end-->
<jsp:include page="footer.jsp"/>



<!-- JS
============================================ -->

<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/> "></script>
<script>
    function changeSize(element) {
        // Loại bỏ lớp "active" từ tất cả các hộp
        // var boxes = document.querySelectorAll(".box_size");
        // Thêm lớp "active" cho hộp được click và có active rồi thì xóa
        if(element.classList.contains("active"))
            element.classList.remove("active");
        else
            element.classList.add("active");
        filterAll();
    }
</script>
<script>

    // Xử lý phân trang
    let thisPage = 1;
    let limit = 6;
    let list = document.querySelectorAll('.list .item');
    let listIndex = document.querySelectorAll('.list .item');
    function reLoadItem(){
        list = document.querySelectorAll('.list .item');
        loadItem();
    }
    function loadItem(){
        let beginGet = limit * (thisPage - 1);
        let endGet = limit * thisPage - 1;
        list.forEach((item, key)=>{
            if(key >= beginGet && key <= endGet){
                item.style.display = 'block';
            }else{
                item.style.display = 'none';
            }
        })
        listPage();
    }
    loadItem();
    function listPage(){
        let count = Math.ceil(list.length / limit);
        document.querySelector('.listPage').innerHTML = '';

        if(thisPage != 1){
            let prev = document.createElement('li');
            let icon = document.createElement('i');
            icon.classList.add('fas','fa-angle-double-left');
            prev.appendChild(icon);
            prev.setAttribute('onclick', "changePage(" + (thisPage - 1) + ")");
            document.querySelector('.listPage').appendChild(prev);
        }

        for(i = 1; i <= count; i++){
            let newPage = document.createElement('li');
            newPage.innerText = i;
            if(i == thisPage){
                newPage.classList.add('active');
            }
            newPage.setAttribute('onclick', "changePage(" + i + ")");
            document.querySelector('.listPage').appendChild(newPage);
        }

        if(thisPage != count){
            let next = document.createElement('li');
            let icon = document.createElement('i');
            icon.classList.add('fas','fa-angle-double-right');
            next.appendChild(icon);
            next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
            document.querySelector('.listPage').appendChild(next);
        }
    }
    function changePage(i){
        thisPage = i;
        loadItem();
    }

    function resetProduct(){
        let content = document.getElementById("product_content");
        content.innerHTML='';
        listIndex.forEach((item)=>{
            content.appendChild(item);
        })
    }

</script>
<script type="text/javascript">

    function getText(list){
        var result = ""
        for(let i =0;i < list.length;i++){
            if(i==list.length-1)
                result+= list[i].textContent;
            else
                result+= list[i].textContent+",";
        }
        return result;
    }

    function filterAll(){
        var filter = document.querySelector('.filter');
        if(window.getComputedStyle(filter).display === "none")
            filter.style.display = "block";
        let min = $( "#slider-range" ).slider("values", 0);
        let max = $( "#slider-range" ).slider("values", 1 );
        var boxSizeClass = document.querySelectorAll('.box_size.active');
        var sizeQuery = getText(boxSizeClass);
        var colorClass = document.querySelectorAll('.container-color.active p');
        var colorQuery = getText(colorClass);
        var query="";
        var categoryDiv = document.querySelector('.brand-sidebar.active');
        if(categoryDiv!=null) {
            var categoryId = categoryDiv.querySelector('input').value;
            query += "categoryId=" + categoryId + "&";
        }
        query+="min="+min+"&";
        query+="max="+max+"&";
        if(document.getElementById("select_id").value!=0)
            query+="sort="+document.getElementById("select_id").value+"&";
        if(sizeQuery!="")
            query+="sizes="+sizeQuery+"&";
        if(colorQuery!="")
            query+="colors="+colorQuery;
        $.ajax({
            url: "/shop/filter",
            type: "Get",
            contentType: "application/json; charset=utf-8",
            data: query,
            success: function (data){
                displayProduct(data);
            }

        });
    }


    function displayProduct(products){
        let result = '';
        for(let i =0;i<products.length;i++){
            result += '<div class="col-lg-4 col-md-4 col-12 item">'
                + ' <div class="single_product">'
                + '<div class="product_thumb">';
            if(products[i].images.length>0)
                result += '<a class="primary_img" href="/product/' +
                    products.id +
                    '"><img src=' +
                    products[i].images[0].img +
                    ' alt=""></a>';
            if(products[i].images.length>1)
                result += '<a class="secondary_img" href="/product/' +
                    products.id +
                    '"><img src='
                    + products[i].images[1].img
                    + ' alt=""></a>';
            result+=' <div class="quick_button">'
                +'<a href="product-details.html"title="quick_view">Xem sản phẩm</a>'
                +'</div>'
                +'   <div class="product_sale">'
                +'       <span>';
            if(products[i].promotion>0)
                result+='-'+products[i].promotion +'%';
            result+= '</span></div>'
                +'</div>'
                +'<div class="product_content grid_content">'
                +'<h3><a href="product-details.html">'
                + products[i].name +'</a></h3>';
            + '<span class="current_price">'
            var old_price = products[i].price;
            old_price = old_price.toLocaleString('vi-VN', {style : 'currency', currency : 'VND'});
            if(products[i].promotion>0)
            {
                var price = products[i].price*(1-products[i].promotion/100);
                price = price.toLocaleString('vi-VN', {style : 'currency', currency : 'VND'});
                result+=price+'</span>'
                    +'<span class="old_price">'
                    +old_price
                    +'</span>' +' </div>';

            }
            else {
                result+=old_price+'</span>' +' </div>';
            }


            result+='   <div class="product_content list_content">'
                +'<h3><a href="product-details.html">'
                +products[i].name+'</a></h3>'
                +'   <div class="product_ratting">'
                +'       <ul>'
                +'           <li><a href="#"><i class="fa fa-star"></i></a></li>'
                +'           <li><a href="#"><i class="fa fa-star"></i></a></li>'
                +'          <li><a href="#"><i class="fa fa-star"></i></a></li>'
                +'        <li><a href="#"><i class="fa fa-star"></i></a></li>'
                +'        <li><a href="#"><i class="fa fa-star"></i></a></li>'
                +'   </ul>'
                +'</div>'
                +'<div class="product_price">'
                +'<span class="current_price">';
            if(products[i].promotion>0)
            {
                var price = products[i].price*(1-products[i].promotion/100);
                price = price.toLocaleString('en-US', {style : 'currency', currency : 'VND'});
                result+=price+'</span>'
                    +'<span class="old_price">'
                    +old_price
                    +'</span>' +' </div>';

            }
            else {
                result+=old_price+'</span>' +' </div>';
            }
            result+=' <div class="product_desc">' +'<p>'
                +products[i].description+'</p>'
                +'</div>'
                +'</div>'
                +'</div>'
                +'</div>';
        }
        document.getElementById("product_content").innerHTML = result;

        reLoadItem();
    }
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lắng nghe sự kiện click cho tất cả các phần tử có lớp "filter"
        var filterButtons = document.querySelectorAll(".container-color span");
        filterButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                if(button.parentElement.classList.contains('active'))
                    button.parentElement.classList.remove('active');
                else
                    button.parentElement.classList.add('active');
                filterAll();
            });
        });

        var brands = document.querySelectorAll('.brand-sidebar p')
        brands.forEach(function (button) {
            button.addEventListener("click", function () {
                var boxes = document.querySelectorAll('.brand-sidebar.active');
                boxes.forEach(function (box) {
                    box.classList.remove("active");
                });
                button.parentElement.classList.add('active');
                document.querySelector('.shop_title h1').textContent = button.title;
                filterAll();

            });
        });

        document.querySelector('.filter i').addEventListener("click", function () {
            var boxes = document.querySelectorAll('.sidebar_widget .active');
            console.log(boxes);
            boxes.forEach(function (box) {
                if(box.querySelector(".checkmark")) {
                    box.querySelector('span').click();
                }
                else
                box.classList.remove("active");

                document.querySelector('.shop_title h1').textContent = "";
            });
            const VND = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
            });
            $( "#slider-range" ).slider({
                range: true,
                min: 0,
                max: 10000000,
                step: 100000,
                values: [ 0, 10000000 ],
                slide: function( event, ui ) {
                    $( "#amount" ).val(VND.format(ui.values[ 0 ]) + " - " + VND.format(ui.values[ 1 ]) );
                }
            });
            $( "#amount" ).val(VND.format($( "#slider-range" ).slider( "values", 0 )) +
                " - " + VND.format($( "#slider-range" ).slider( "values", 1 ) ));

            filterAll();
            document.querySelector('.filter').style.display="none";
        });
    });
</script>
</body>

</html>