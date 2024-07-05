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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">


    <!-- Template Main CSS File -->
    <link href="/admin/assets/css/style.css" rel="stylesheet">
    <style>
        p{
            margin-block-start: 10px;
            margin-block-end: 10px;
        }
        #full .ck-blurred{
            min-height: 500px!important;
        }
        #full .ck-content{
            min-height: 500px!important;

        }
        #short .ck-blurred{
            min-height: 100px!important;
        }
        #short .ck-content{
            min-height: 100px!important;
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/home"/>">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/products"/>">
                <i class="bi bi-shop"></i>
                <span>Products</span>
            </a>
        </li><!-- End Order Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/order"/>">
                <i class="bi bi-journal-text"></i>
                <span>Orders</span>
            </a>
        </li><!-- End Order Page Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/voucher"/>">
                <i class="bi bi-gift"></i>
                <span>Voucher</span>
            </a>
        </li><!-- End Category Page Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/stores"/>">
                <i class="bi bi-diagram-3"></i>
                <span>Stores</span>
            </a>
        </li><!-- End Category Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/account"/>">
                <i class="bi bi-person"></i>
                <span>Accounts</span>
            </a>
        </li><!-- End Account Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="<c:url value="/admin/categories"/>">
                <i class="bi bi-card-list"></i>
                <span>Categories</span>
            </a>
        </li><!-- End Category Page Nav -->

        <li class="nav-item">
            <a class="nav-link" href="<c:url value="/admin/posts"/>">
                <i class="bi bi-file-earmark-word"></i>
                <span>Posts</span>
            </a>
        </li><!-- End Category Page Nav -->
    </ul>

</aside><!-- End Sidebar-->

<main id="main" class="main">
    <div class="pagetitle">
        <h1>Manager Posts</h1>
    </div><!-- End Page Title -->
    <section class="section dashboard">
        <div class="row">
            <!-- Left side columns -->
            <div class="col-lg-12">
                <div class="row">
                    <!-- Recent Sales -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="card-body">
                                <!-- Vertical Form -->
                                <!-- No Labels Form -->
                                <form class="row g-3" action="/admin/posts/save" method="post" enctype="multipart/form-data">
                                    <div class="col-md-12">
                                        <input hidden="hidden" type="text" class="form-control" placeholder="ID"  id="id" name="id">
                                    </div>
                                    <div class="col-md-12">
                                        <span class="card-title" style="font-size: 1em; margin-left: 5px;">Title</span>
                                        <input type="text" class="form-control" placeholder="Enter title" name="title" value="${post.title}">
                                    </div>
                                    <div class="col-md-12" >
                                        <span class="card-title" style="font-size: 1em; margin-left: 5px;">Type</span>
                                        <div>
                                            <select class="form-select" name="postType" value="${post.postType}">
                                                <option value="SIZE">Tư vấn chọn size</option>
                                                <option value="TREND">Xu hướng thời trang</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <span class="card-title" style="font-size: 1em; margin-left: 5px;">Topic photo</span>
                                        <input type="file" id="image-file" name="image-file" multiple/>
                                    </div>
                                    <div class="col-md-12" id="short">
                                        <span class="card-title" style="font-size: 1em; margin-left: 5px;">Short Content</span>
                                        <textarea id="shortContent" name="shortContent"></textarea>
                                    </div>
                                    <div class="col-md-12" id="full">
                                        <span class="card-title" style="font-size: 1em; margin-left: 5px;">Full Content Page</span>
                                        <textarea id="fullContent" name="fullContent"></textarea>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-success">Save</button>
                                        <button type="reset" class="btn btn-secondary" id="listCateBtn">Cancel</button>
                                    </div>
                                </form><!-- End No Labels Form -->
                            </div>
                        </div>
                    </div><!-- End Recent Sales -->
                </div><!-- End Right side columns -->
            </div>
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
<script src="/admin/assets/js/ckeditor.js"></script>

<script src="https://cdn.ckbox.io/CKBox/2.4.0/ckbox.js"></script>


<script>
    ClassicEditor
        .create(document.getElementById('shortContent'), {
            licenseKey: 'd2tpMWtPSGN0d0xoQkFZYy9qdmo5dHduR0kvY1FnOURxVWNCZEI2ZWV6a3ozdytSNkM0MnRNRXgwWlBnMUE9PS1NakF5TkRBNE1ETT0=',
            ckbox: {
                tokenUrl: 'https://112702.cke-cs.com/token/dev/32869dfd2e7c511e456f84c2339d6d92f9340bd1bdb37f2c7a9630489a3b?limit=10'
            },
            toolbar: {
                items: [
                    'undo',
                    'redo',
                    'heading',
                    '|',
                    'fontFamily',
                    'fontSize',
                    'fontColor',
                    'fontBackgroundColor',
                    '|',
                    'bold',
                    'italic',
                    'underline',
                    'strikethrough',
                    'highlight',
                    'link',
                    '|',
                    'alignment',
                    '|',
                    'bulletedList',
                    'numberedList',
                    'todoList',
                    '|',
                    'indent',
                    'outdent',
                    '|',
                    'uploadImage',
                    'insertTable',
                    '|',
                    "importWord",
                    'exportWord',
                    'exportPdf',
                    'ckboxImageEdit'

                ],
                shouldNotGroupWhenFull: true
            },
            image: {
                toolbar: [
                    'imageStyle:inline',
                    'imageStyle:block',
                    'imageStyle:side',
                    '|',
                    'toggleImageCaption',
                    'imageTextAlternative',
                    'ckboxImageEdit'
                ]
            },
            language: 'en'
        })
        .then(editor => {
            if(${post.shortContent!=null})
                editor.setData('${post.shortContent}');
            console.error(editor);
        })
        .catch(error => {
            console.error(error);
        });

    ClassicEditor
        .create(document.getElementById('fullContent'), {
            licenseKey: 'd2tpMWtPSGN0d0xoQkFZYy9qdmo5dHduR0kvY1FnOURxVWNCZEI2ZWV6a3ozdytSNkM0MnRNRXgwWlBnMUE9PS1NakF5TkRBNE1ETT0=',
            ckbox: {
                tokenUrl: 'https://112702.cke-cs.com/token/dev/32869dfd2e7c511e456f84c2339d6d92f9340bd1bdb37f2c7a9630489a3b?limit=10'
            },
            toolbar: {
                items: [
                    'undo',
                    'redo',
                    'heading',
                    '|',
                    'fontFamily',
                    'fontSize',
                    'fontColor',
                    'fontBackgroundColor',
                    '|',
                    'bold',
                    'italic',
                    'underline',
                    'strikethrough',
                    'highlight',
                    'link',
                    '|',
                    'alignment',
                    '|',
                    'bulletedList',
                    'numberedList',
                    'todoList',
                    '|',
                    'indent',
                    'outdent',
                    '|',
                    'uploadImage',
                    'insertTable',
                    '|',
                    "importWord",
                    'exportWord',
                    'exportPdf',

                ],
                shouldNotGroupWhenFull: true
            },
            image: {
                toolbar: [
                    'imageStyle:inline',
                    'imageStyle:block',
                    'imageStyle:side',
                    '|',
                    'toggleImageCaption',
                    'imageTextAlternative'
                ]
            },
            language: 'en'
        })
        .then(editor => {
            console.error(editor);
            if(${post.fullContent!=null})
                editor.setData('${post.shortContent}');
        })
        .catch(error => {
            console.error(error);
        });

</script>

</body>

</html>