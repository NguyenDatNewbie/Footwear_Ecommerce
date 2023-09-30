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
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="http://localhost:8081/user/assets/img/favicon.ico">

    <!-- CSS 
    ========================= -->


    <!-- Plugins CSS -->
    <link rel="stylesheet" href="http://localhost:8081/user/assets/css/plugins.css">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="http://localhost:8081/user/assets/css/style.css">

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

        function refeshPage(sizes){
           let size = sizes/6
            console.log(size);
            let tmp = parseInt(size);
           if(tmp<size)
               tmp+=1;
           let refresh='';
           for(i =1;i<=tmp;i++){
               if(i==1)
                   refresh += '<li id="page'+ i
                    +   '" class="current"><a onclick="productPage('
                    +i
                    +')">'
                    +i+'</a></li>';
               else{
                   refresh += '<li id="page'+ i
                       +   '"><a onclick="productPage('
                       +i
                       +')">'
                       +i+'</a></li>';
               }

            }
           document.getElementById("page").innerHTML = refresh;
        }
        function productPage(productPage){
            $.ajax({
                url: location.href+"/page/"+productPage,
                type: "get",
                success: function (data){
                    displayProduct(data);
                }
            });
            var pagePrevious =  document.getElementById("page"+pageCurrent);
            pagePrevious.classList.remove("current");
            var page = document.getElementById("page"+productPage);
            page.className = "current";
            pageCurrent = productPage;
        }

        function displayProduct(products){
            let result = '';
            for(i =0;i<products.length;i++){
                result += '<div class="col-lg-4 col-md-4 col-12 item">'
                + ' <div class="single_product">'
                + '<div class="product_thumb">';
                    if(products[i].images.length>0)
                        result += '<a class="primary_img" href="product-details.html"><img src=' +
                            products[i].images[0].img +
                            ' alt=""></a>';
                    if(products[i].images.length>1)
                    result += '<a class="secondary_img" href="product-details.html"><img src='
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

    <!-- Main Wrapper Start -->
    <!--Offcanvas menu area start-->
    <div class="off_canvars_overlay"></div>
    <div class="offcanvas_menu">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="canvas_open">
                        <a href="javascript:void(0)"><i class="ion-navicon"></i></a>
                    </div>
                    <div class="offcanvas_menu_wrapper">
                        <div class="canvas_close">
                              <a href="javascript:void(0)"><i class="ion-android-close"></i></a>  
                        </div>
                        <div class="welcome_text">
                           <ul>
                               <li><span>Free Delivery:</span> Take advantage of our time to save event</li>
                               <li><span>Free Returns *</span> Satisfaction guaranteed</li>
                           </ul>
                        </div>
                        
                        <div class="top_right">
                            <ul>
                               <li class="top_links"><a href="#">My Account <i class="ion-chevron-down"></i></a>
                                    <ul class="dropdown_links">
                                        <li><a href="wishlist.html">My Wish List </a></li>
                                        <li><a href="my-account.html">My Account </a></li>
                                        <li><a href="#">Sign In</a></li>
                                        <li><a href="compare.html">Compare Products  </a></li>
                                    </ul>
                                </li> 
                                <li class="language"><a href="#"><img src="http://localhost:8081/user/assets/img/logo/language.png" alt=""> English <i class="ion-chevron-down"></i></a>
                                    <ul class="dropdown_language">
                                        <li><a href="#"><img src="http://localhost:8081/user/assets/img/logo/cigar.jpg" alt=""> French</a></li>
                                        <li><a href="#"><img src="http://localhost:8081/user/assets/img/logo/language2.png" alt="">German</a></li>
                                    </ul>
                                </li>
                                <li class="currency"><a href="#">USD <i class="ion-chevron-down"></i></a>
                                    <ul class="dropdown_currency">
                                        <li><a href="#">EUR</a></li>
                                        <li><a href="#">BRL</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div> 
                        <div class="search_bar">
                            <form action="#">
                                <select class="select_option" name="select" id="categori">
                                    <option selected value="1">All Categories</option>
                                    <option  value="2">Accessories</option>
                                    <option  value="3">Bridge</option>
                                    <option  value="4">Hub</option>
                                    <option  value="5">Repeater</option>
                                    <option  value="6">Switch</option>
                                    <option  value="7">Video Games</option>
                                    <option  value="8">PlayStation 3</option>
                                    <option  value="9">PlayStation 4</option>
                                    <option  value="10">Xbox 360</option>
                                    <option  value="11">Xbox One</option>
                                </select>
                                <input placeholder="Search entire store here..." type="text">
                                <button type="submit"><i class="ion-ios-search-strong"></i></button>
                            </form>
                        </div>
                        <div class="cart_area">
                            <div class="middel_links">
                               <ul>
                                   <li><a href="login.jsp">Login</a></li>
                                   <li>/</li>
                                   <li><a href="login.jsp">Register</a></li>
                               </ul>

                            </div>
                            <div class="cart_link">
                                <a href="#"><i class="fa fa-shopping-basket"></i>2 item(s)</a>
                                <!--mini cart-->
                                 <div class="mini_cart">
                                    <div class="cart_item top">
                                       <div class="cart_img">
                                           <a href="#"><img src="http://localhost:8081/user/assets/img/s-product/product.jpg" alt=""></a>
                                       </div>
                                        <div class="cart_info">
                                            <a href="#">Apple iPhone SE 16GB</a>

                                            <span>1x $60.00</span>
    
                                        </div>
                                        <div class="cart_remove">
                                            <a href="#"><i class="ion-android-close"></i></a>
                                        </div>
                                    </div>
                                    <div class="cart_item bottom">
                                       <div class="cart_img">
                                           <a href="#"><img src="http://localhost:8081/user/assets/img/s-product/product2.jpg" alt=""></a>
                                       </div>
                                        <div class="cart_info">
                                            <a href="#">Marshall Portable  Bluetooth</a>
                                                <span> 1x $160.00</span>
                                        </div>
                                        <div class="cart_remove">
                                            <a href="#"><i class="ion-android-close"></i></a>
                                        </div>
                                    </div>
                                    <div class="cart__table">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="text-left">Sub-Total :</td>
                                                    <td class="text-right">$150.00</td>
                                                </tr>
                                             
                                                <tr>
                                                    <td class="text-left">Total :</td>
                                                    <td class="text-right">$184.00</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <div class="cart_button view_cart">
                                        <a href="cart.jsp">View Cart</a>
                                    </div>
                                    <div class="cart_button checkout">
                                        <a href="checkout.html">Checkout</a>
                                    </div>
                                </div>
                                <!--mini cart end-->
                            </div>
                        </div>
                        <div class="contact_phone">
                            <p>Call Free Support: <a href="tel:+(012)800456789">(+012) 800 456 789 </a></p>
                        </div>
                        <div id="menu" class="text-left ">
                            <ul class="offcanvas_main_menu">
                                <li class="menu-item-has-children active">
                                    <a href="#">Home</a>
                                    <ul class="sub-menu">
                                        <li><a href="index.jsp">Home 1</a></li>
                                        <li><a href="index-2.html">Home 2</a></li>
                                        <li><a href="index-3.html">Home 3</a></li>
                                        <li><a href="index-4.html">Home 4</a></li>
                                        <li><a href="index-5.html">Home 5</a></li>
                                        <li><a href="index-6.html">Home 6</a></li>
                                        <li><a href="index-7.html">Home 7</a></li>
                                        <li><a href="index-8.html">Home 8</a></li>
                                        <li><a href="index-9.html">Home 9</a></li>
                                    </ul>
                                </li>
                                <li class="menu-item-has-children">
                                    <a href="#">Shop</a>
                                    <ul class="sub-menu">
                                        <li class="menu-item-has-children">
                                            <a href="#">Shop Layouts</a>
                                            <ul class="sub-menu">
                                                <li><a href="shop.html">shop</a></li>
                                                <li><a href="shop-fullwidth.html">Full Width</a></li>
                                                <li><a href="shop-fullwidth-list.html">Full Width list</a></li>
                                                <li><a href="shop-right-sidebar.html">Right Sidebar </a></li>
                                                <li><a href="shop-right-sidebar-list.html"> Right Sidebar list</a></li>
                                                <li><a href="shop-list.html">List View</a></li>
                                            </ul>
                                        </li>
                                        <li class="menu-item-has-children">
                                            <a href="#">other Pages</a>
                                            <ul class="sub-menu">
                                                <li><a href="portfolio.html">portfolio</a></li>
                                                <li><a href="portfolio-details.html">portfolio details</a></li>
                                                <li><a href="cart.jsp">cart</a></li>
                                                <li><a href="checkout.html">Checkout</a></li>
                                                <li><a href="my-account.html">my account</a></li>
                                            </ul>
                                        </li>
                                        <li class="menu-item-has-children">
                                            <a href="#">Product Types</a>
                                            <ul class="sub-menu">
                                                <li><a href="product-details.jsp">product details</a></li>
                                                <li><a href="product-sidebar.html">product sidebar</a></li>
                                                <li><a href="product-grouped.html">product grouped</a></li>
                                                <li><a href="variable-product.html">product variable</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="menu-item-has-children">
                                    <a href="#">blog</a>
                                    <ul class="sub-menu">
                                        <li><a href="blog.jsp">blog</a></li>
                                        <li><a href="blog-details.jsp">blog details</a></li>
                                        <li><a href="blog-sidebar.html">blog  Sidebar</a></li>
                                        <li><a href="blog-fullwidth.html">blog fullwidth</a></li>
                                    </ul>

                                </li>
                                <li class="menu-item-has-children">
                                    <a href="#">pages </a>
                                    <ul class="sub-menu">
                                        <li><a href="about.jsp">About Us</a></li>
                                        <li><a href="services.html">services</a></li>
                                        <li><a href="faq.html">Frequently Questions</a></li>
                                        <li><a href="contact.jsp">contact</a></li>
                                        <li><a href="login.jsp">login</a></li>
                                        <li><a href="wishlist.html">Wishlist</a></li>
                                        <li><a href="404.html">Error 404</a></li>
                                        <li><a href="compare.html">compare</a></li>
                                        <li><a href="privacy-policy.html">privacy policy</a></li>
                                        <li><a href="coming-soon.html">coming soon</a></li>
                                    </ul>
                                </li>
                                <li class="menu-item-has-children">
                                    <a href="my-account.html">my account</a>
                                </li>
                                <li class="menu-item-has-children">
                                    <a href="about.jsp">About Us</a>
                                </li>
                                <li class="menu-item-has-children">
                                    <a href="contact.jsp"> Contact Us</a>
                                </li>
                            </ul>
                        </div>
                        <div class="offcanvas_footer">
                            <span><a href="#"><i class="fa fa-envelope-o"></i> info@yourdomain.com</a></span>
                            <ul>
                                <li class="facebook"><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li class="twitter"><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li class="pinterest"><a href="#"><i class="fa fa-pinterest-p"></i></a></li>
                                <li class="google-plus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Offcanvas menu area end-->
     
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
                                <a href="./shop/${category.id}">- ${category.name}</a>
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
                                <form action="javascript:filterPrice()">
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

                            <select  class="select_option" onchange="Sort(this)">
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
                                            <a class="primary_img" href="product-details.jsp"><img src="${product.images.get(0).img}" alt=""></a>
                                        </c:if>
                                        <c:if test="${product.images.size()>1}">
                                            <a class="secondary_img" href="product-details.jsp"><img src="${product.images.get(1).img}" alt=""></a>
                                        </c:if>

                                        <div class="quick_button">
                                            <a href="product-details.jsp" title="quick_view">Xem sản phẩm</a>
                                        </div>


                                        <div class="product_sale">
                                            <c:if test="${product.promotion>0}"><span>-${product.promotion}%</span></c:if>
                                        </div>

                                    </div>

                                    <div class="product_content grid_content" >
                                        <h3><a href="product-details.jsp">${product.name}</a></h3>
                                        <c:choose>
                                            <c:when test="${product.promotion>0}">
                                                <input class="productPrice" style="display: none" value="${product.price*(1-product.promotion/100)}"/>
                                                <span class="current_price" >${formatVND.format(product.price*(1-product.promotion/100))}</span>
                                                <span class="old_price">${formatVND.format(product.price)}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <input class="productPrice" style="display: none" value="${product.price*(1-product.promotion/100)}"/>
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
    
    <jsp:include page="footer.jsp"></jsp:include>
    
    <!-- modal area start-->
    <div class="modal fade" id="modal_box" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
                <div class="modal_body">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-5 col-md-5 col-sm-12">
                                <div class="modal_tab">  
                                    <div class="tab-content product-details-large">
                                        <div class="tab-pane fade show active" id="tab1" role="tabpanel" >
                                            <div class="modal_tab_img">
                                                <a href="#"><img src="http://localhost:8081/user/assets/img/product/product4.jpg" alt=""></a>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="tab2" role="tabpanel">
                                            <div class="modal_tab_img">
                                                <a href="#"><img src="http://localhost:8081/user/assets/img/product/product6.jpg" alt=""></a>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="tab3" role="tabpanel">
                                            <div class="modal_tab_img">
                                                <a href="#"><img src="http://localhost:8081/user/assets/img/product/product8.jpg" alt=""></a>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="tab4" role="tabpanel">
                                            <div class="modal_tab_img">
                                                <a href="#"><img src="http://localhost:8081/user/assets/img/product/product2.jpg" alt=""></a>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="tab5" role="tabpanel">
                                            <div class="modal_tab_img">
                                                <a href="#"><img src="http://localhost:8081/user/assets/img/product/product12.jpg" alt=""></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal_tab_button">    
                                        <ul class="nav product_navactive owl-carousel" role="tablist">
                                            <li >
                                                <a class="nav-link active" data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="false"><img src="http://localhost:8081/user/assets/img/s-product/product3.jpg" alt=""></a>
                                            </li>
                                            <li>
                                                 <a class="nav-link" data-toggle="tab" href="#tab2" role="tab" aria-controls="tab2" aria-selected="false"><img src="http://localhost:8081/user/assets/img/s-product/product.jpg" alt=""></a>
                                            </li>
                                            <li>
                                               <a class="nav-link button_three" data-toggle="tab" href="#tab3" role="tab" aria-controls="tab3" aria-selected="false"><img src="http://localhost:8081/user/assets/img/s-product/product2.jpg" alt=""></a>
                                            </li>
                                            <li>
                                               <a class="nav-link" data-toggle="tab" href="#tab4" role="tab" aria-controls="tab4" aria-selected="false"><img src="http://localhost:8081/user/assets/img/s-product/product4.jpg" alt=""></a>
                                            </li>
                                            <li>
                                               <a class="nav-link" data-toggle="tab" href="#tab5" role="tab" aria-controls="tab5" aria-selected="false"><img src="http://localhost:8081/user/assets/img/s-product/product5.jpg" alt=""></a>
                                            </li>

                                        </ul>
                                    </div>    
                                </div>  
                            </div> 
                            <div class="col-lg-7 col-md-7 col-sm-12">
                                <div class="modal_right">
                                    <div class="modal_title mb-10">
                                        <h2>Handbag feugiat</h2> 
                                    </div>
                                    <div class="modal_price mb-10">
                                        <span class="new_price">$64.99</span>    
                                        <span class="old_price" >$78.99</span>    
                                    </div>
                                    <div class="modal_description mb-15">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia iste laborum ad impedit pariatur esse optio tempora sint ullam autem deleniti nam in quos qui nemo ipsum numquam, reiciendis maiores quidem aperiam, rerum vel recusandae </p>    
                                    </div> 
                                    <div class="variants_selects">
                                        <div class="variants_size">
                                           <h2>size</h2>
                                           <select class="select_option">
                                               <option selected value="1">s</option>
                                               <option value="1">m</option>
                                               <option value="1">l</option>
                                               <option value="1">xl</option>
                                               <option value="1">xxl</option>
                                           </select>
                                        </div>
                                        <div class="variants_color">
                                           <h2>color</h2>
                                           <select class="select_option">
                                               <option selected value="1">purple</option>
                                               <option value="1">violet</option>
                                               <option value="1">black</option>
                                               <option value="1">pink</option>
                                               <option value="1">orange</option>
                                           </select>
                                        </div>
                                        <div class="modal_add_to_cart">
                                            <form action="#">
                                                <input min="0" max="100" step="2" value="1" type="number">
                                                <button type="submit">add to cart</button>
                                            </form>
                                        </div>   
                                    </div>
                                    <div class="modal_social">
                                        <h2>Share this product</h2>
                                        <ul>
                                            <li class="facebook"><a href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li class="twitter"><a href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li class="pinterest"><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                            <li class="google-plus"><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                            <li class="linkedin"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                        </ul>    
                                    </div>      
                                </div>    
                            </div>    
                        </div>     
                    </div>
                </div>    
            </div>
        </div>
    </div> 
    <!-- modal area start-->
    

<!-- JS
============================================ -->

<!-- Plugins JS -->
<script src="http://localhost:8081/user/assets/js/plugins.js"></script>

<!-- Main JS -->
<script src="http://localhost:8081/user/assets/js/main.js"></script>
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
            prev.innerText = '<<';
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
            next.innerText = '>>';
            next.setAttribute('onclick', "changePage(" + (thisPage + 1) + ")");
            document.querySelector('.listPage').appendChild(next);
        }
    }
    function changePage(i){
        thisPage = i;
        loadItem();
    }


    const VND = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
    });

    $( "#slider-range" ).slider({
        range: true,
        min: 100000,
        max: 10000000,
        step: 100000,
        values: [ 100000, 10000000 ],
        slide: function( event, ui ) {
            $( "#amount" ).val(VND.format(ui.values[ 0 ]) + " - " + VND.format(ui.values[ 1 ]) );
        }
    });
    $( "#amount" ).val(VND.format($( "#slider-range" ).slider( "values", 0 )) +
        " - " + VND.format($( "#slider-range" ).slider( "values", 1 ) ));

    function resetProduct(){
        let content = document.getElementById("product_content");
        content.innerHTML='';
        listIndex.forEach((item)=>{
            content.appendChild(item);
        })
    }

    function filterPrice(){
        resetProduct();
        list = listIndex;
        sortListDes();
        let min = $( "#slider-range" ).slider("values", 0)
        let max = $( "#slider-range" ).slider("values", 1 );
        let price;
        list.forEach((item,key)=>{
            price = item.getElementsByClassName("productPrice")[0].value;
            if(price<min || price>max) {
                item.remove();
            }
        })

        reLoadItem();
    }
    function sortListDes(){
        let elementBefore;
        let elementAfter;
        for(let i=list.length-1;i>=0;i--){
            for(let j=1;j<=i;j++){
                elementBefore = list.item(j-1).getElementsByClassName("productPrice")[0].value;
                elementAfter = list.item(j).getElementsByClassName("productPrice")[0].value;
                if(elementAfter<elementBefore) {
                    const temp = document.createComment('')
                    list.item(j-1).replaceWith(temp)
                    list.item(j).replaceWith(list.item(j-1));
                    temp.replaceWith(list.item(j-1));
                    console.log(temp);
                }}
        }
        list.forEach((item)=>{
            console.log(item.getElementsByClassName("productPrice")[0].value)
        })
    }

    // Note: Cloned copy of element1 will be returned to get a new reference back
    function exchangeElements(element1, element2)
    {
        let clonedElement1 = element1.cloneNode(true);
        let clonedElement2 = element2.cloneNode(true);

        element2.parentNode.replaceChild(clonedElement1, element2);
        element1.parentNode.replaceChild(clonedElement2, element1);

        return clonedElement1;
    }
</script>



</body>

</html>