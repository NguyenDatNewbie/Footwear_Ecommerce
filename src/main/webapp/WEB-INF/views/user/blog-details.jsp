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
        .page{
            color: #242424;
            margin: 30px 0px;
            font-family: 'futura-REGULAR', sans-serif;
            color: #242424;
        }
        .page p{
            margin-block-start: 10px;
            margin-block-end: 10px;
            margin: 0;
        }
        .page h4 {
            font-size: 28px;
        }
        .page h3{
            font-size: 18px;
        }
        .blogs{
            display: flex;
        }
        .heading-title{
            margin-bottom: 20px;
        }
        .heading-title span{
            color: #757575;
        }

    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="page">
    <div class="heading-title">
        <h4>${post.title}</h4>
        <span>${post.account.accountDetail.name}</span>
        <span>-</span>
        <span>${post.updateAt}</span>
    </div>
    <div class="content">
        ${post.fullContent}
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
