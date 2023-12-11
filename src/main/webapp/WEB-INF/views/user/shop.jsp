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

    <script type="text/javascript">
        function Sort(type){
            var option = type.value;
            $.ajax({
                url: location.href+"/sort/"+option,
                type: "get",
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

    </style>
</head>

<body>


<jsp:include page="header.jsp"/>

<!--breadcrumbs area start-->
<div class="breadcrumbs_area">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb_content">
                    <ul>
                        <li><a href="./index">home</a></li>
                        <c:forEach items="${categories}" var="category">
                         <li>  <a href="./${category.id}">- ${category.name}</a></li>
                        </c:forEach>
                        <li>- ${currentCategory.name}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!--breadcrumbs area end-->

<!--shop  area start-->
<div class="shop_area shop_reverse">
    <div class="container">
        <div class="shop_inner_area">
            <div class="row">
                <div class="col-lg-3 col-md-12">
                    <!--sidebar widget start-->
                    <div class="sidebar_widget">
                        <div class="widget_list widget_filter">
                            <h2>Lọc theo giá</h2>
                            <form action="javascript:Filter()">
                                <div id="slider-range"></div>
                                <button type="submit">Lọc</button>
                                <input type="text" name="productValue" id="amount" />
                            </form>
                        </div>
                        <div class="widget_list widget_categories">
                            <h2>Brand</h2>
                            <ul style="font-size: 14px" class="ul_menu">
                                <c:forEach var="category" items="${categoryRepository.findAll()}">
                                    <li><a href="./${category.id}">${category.name}<span>${productRepository.findAllByCategory(category.id).size()}</span></a>
                                        <c:if test="${categoryRepository.familyByParent(category.id).size()>0}">
                                            <ul  class="ul_menu_children">
                                                <c:forEach var="categoryChildren" items="${categoryRepository.familyByParent(category.id)}">
                                                <li><a href="./${categoryChildren.id}"><span>${categoryChildren.name}</span></a>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                    </div>
                    <!--sidebar widget end-->
                </div>
                <div class="col-lg-9 col-md-12">
                    <!--shop wrapper start-->
                    <!--shop toolbar start-->
                    <div class="shop_title">
                        <h1>${currentCategory.name}</h1>
                    </div>
                    <div class="shop_toolbar_wrapper">
                        <div class="shop_toolbar_btn">

                            <button data-role="grid_3" type="button" class="active btn-grid-3" data-toggle="tooltip" title="3"></button>

                            <button data-role="grid_list" type="button"  class="btn-list" data-toggle="tooltip" title="List"></button>

                        </div>

                        <select  class="select_option" id="select_id" onchange="Sort(this)">
                            <option selected>Sắp xếp</option>
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
<script src="<c:url value="/user/assets/js/plugins.js"/>"></script>

<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/> "></script>

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

    function Filter(){
        let min = $( "#slider-range" ).slider("values", 0);
        let max = $( "#slider-range" ).slider("values", 1 );

        $.ajax({
            url: location.href+"/filterPrice/"+min+"/"+max,
            type: "get",
            success: function (data){
                displayProduct(data);
            }
        });
    }


</script>

</body>

</html>