<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Chia sẻ</title>
    <link rel="shortcut icon" type="image/x-icon"
          href="../../assets/img/logo/logo.png" style="width: 20px;">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon"
          href="<c:url value="/assets/img/favicon.ico"/>">

    <!-- Plugins CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/plugins.css"/>">

    <!-- Main Style CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/style.css"/>">
    <style>

        .content {
            font-family: 'futura-REGULAR', sans-serif;
            color: #242424;
        }

        .container h4 {
            font-size: 24px;
        }
        .blogs{
            display: flex;
        }

        .blogs .blog-content{
            width: 65%;
            margin-right: 10%;
        }
        .blogs .slider{
            width: 25%;
            position: sticky;
        }

        .blog-item {
            display: flex;
            width: 100%;
            padding-bottom: 20px;
            border-bottom: 1px solid #ebecf0;
            margin-top: 20px;
        }

        .blog-item img {
            width: 30%;
            margin-right: 20px;
        }

        .blog-item a {
            font-size: 18px;
            font-weight: bold;
        }

        .blog-item p {
            font-size: 14px;
            text-align: justify;
        }

        .blog-item div {
        }
        p {
            margin: 0;
        }
        .blog-item span {
            color: #757575;
            font-size: 13px;
        }
        .slider .blog-item a{
            font-size: 13px;
        }
        .slider .blog-item{
            margin-top: 5px;
            padding-bottom: 5px;
        }
        .slider h3{
            font-size: 18px;
            font-weight: bold;
            padding-bottom: 5px;
            border-bottom: 1px solid #ebecf0;
        }
        .slider .blog-item img{
            width: 25%;
        }
        .group-sidebox{
            margin: 0 0 30px;
            position: relative;
            padding: 20px 15px;
            border: 1px solid
        }
        .blog-item div p{
            display: -webkit-box;
            -webkit-line-clamp: 3; /* Số dòng tối đa */
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .slider .blog-item a{
            display: -webkit-box;
            -webkit-line-clamp: 2; /* Số dòng tối đa */
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .list-blogs-latest .blog-item  div div{
            display: flex;
        }
        .list-blogs-latest .blog-item div div a{
            margin-right: 3px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="content">
        <c:if test="${posts.get(0).postType=='SIZE'}">
            <h4>Tư vấn chọn size</h4>
        </c:if>
        <c:if test="${posts.get(0).postType=='TREND'}">
            <h4>Xu hướng thời trang</h4>
        </c:if>
        <div class="blogs">
            <div class="blog-content">
                <c:forEach items="${posts}" var="post">
                    <div class="blog-item">
                        <img src="${post.image}"/>
                        <div>
                            <a class="title" href="/blogs/detail/${post.id}">${post.title}</a>
                            <p>${post.shortContent}</p>
                            <span>Tác giả: ${post.account.accountDetail.name} . 07 Tháng 04, 2024</span>
                        </div>
                    </div>
                </c:forEach>
                <div class="blog-item">
                    <img src="https://i.pinimg.com/originals/74/fd/36/74fd362080881e597c345529cc8ec13a.jpg"/>
                    <div>
                        <a class="title">[Giải đáp] có nên mang giày rộng hơn 1 size như lời đồn</a>
                        <p>Cửa hàng chúng tôi luôn là một địa chỉ đáng tin cậy cung cấp sản phẩm giày dép thời trang
                            chất lượng. Trong quá trình bán hàng, chúng tôi luôn giải đáp những thắc mắc cho khách
                            hàng...</p>
                        <span>Tác giả: NHD . 07 Tháng 04, 2024</span>
                    </div>
                </div>
                <div class="blog-item">
                    <img src="https://i.pinimg.com/736x/c7/e4/a0/c7e4a0324341ace53ba89493382e011b.jpg"/>
                    <div>
                        <a class="title">[Giải đáp] có nên mang giày rộng hơn 1 size như lời đồn</a>
                        <p>Cửa hàng chúng tôi luôn là một địa chỉ đáng tin cậy cung cấp sản phẩm giày dép thời trang
                            chất lượng. Trong quá trình bán hàng, chúng tôi luôn giải đáp những thắc mắc cho khách
                            hàng...</p>
                        <span>Tác giả: NHD . 07 Tháng 04, 2024</span>
                    </div>
                </div>
                <div class="blog-item">
                    <img src="https://i.pinimg.com/564x/d6/20/e5/d620e5b83003e326836120e256dce6f8.jpg"/>
                    <div>
                        <a class="title">[Giải đáp] có nên mang giày rộng hơn 1 size như lời đồn</a>
                        <p>Cửa hàng chúng tôi luôn là một địa chỉ đáng tin cậy cung cấp sản phẩm giày dép thời trang
                            chất lượng. Trong quá trình bán hàng, chúng tôi luôn giải đáp những thắc mắc cho khách
                            hàng...</p>
                        <span>Tác giả: NHD . 07 Tháng 04, 2024</span>
                    </div>
                </div>
                <div class="blog-item">
                    <img src="https://i.pinimg.com/564x/69/6c/86/696c862ab233a86412b31cda51168501.jpg"/>
                    <div>
                        <a class="title">[Giải đáp] có nên mang giày rộng hơn 1 size như lời đồn</a>
                        <p>Cửa hàng chúng tôi luôn là một địa chỉ đáng tin cậy cung cấp sản phẩm giày dép thời trang
                            chất lượng. Trong quá trình bán hàng, chúng tôi luôn giải đáp những thắc mắc cho khách
                            hàng...</p>
                        <span>Tác giả: NHD . 07 Tháng 04, 2024</span>
                    </div>
                </div>
            </div>
            <div class="slider">
                <div class="group-sidebox">
                    <div class="sidebox-title">
                        <h3>Bài viết mới nhất</h3>
                    </div>
                    <div class="sidebox-content">
                        <div class="list-blogs-latest">
                            <c:forEach var="postNew" items="${news}">
                            <div class="blog-item">
                                <img src="${postNew.image}">
                                <div>
                                    <a href="/blogs/detail/${postNew.id}">${postNew.title}</a>
                                    <div>
                                        <c:if test="${postNew.postType=='SIZE'}"><a style="color: #757575; font-weight: unset" href="/blogs?type=SIZE">Chia sẻ</a></c:if>
                                            <c:if test="${postNew.postType=='TREND'}"><a style="color: #757575; font-weight: unset" href="/blogs?type=TREND">Tin tức</a></c:if>
                                        <span> - ${postNew.updateAt}</span>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            <div class="blog-item">
                                <img src="https://i.pinimg.com/564x/40/f2/f9/40f2f963f82807d82f9d356a33c8bb3a.jpg">
                                <div>
                                    <a>Pace trung bình chạy bộ là gì? Cách tính toán chính xác</a>
                                    <div>
                                        <a style="color: #757575; font-weight: unset">Tin tức</a>
                                        <span> - 07.04.2024</span>
                                    </div>
                                </div>
                            </div>
                            <div class="blog-item">
                                <img src="https://i.pinimg.com/736x/7c/11/9f/7c119f2e86b0b0c9fc1f02bfe5de49dd.jpg">
                                <div>
                                    <a>Pace trung bình chạy bộ là gì? Cách tính toán chính xác</a>
                                    <div>
                                        <a style="color: #757575; font-weight: unset">Tin tức</a>
                                        <span> - 07.04.2024</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<jsp:include page="footer.jsp"/>
<!-- Plugins JS -->
<script src="<c:url value="/assets/js/plugins.js"/>"></script>
<!-- Main JS -->
<script src="<c:url value="/assets/js/main.js"/>"></script>
</body>
</html>
