<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>

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
      <a class="nav-link collapsed" href="<c:url value="/admin/posts"/>">
        <i class="bi bi-file-earmark-word"></i>
        <span>Posts</span>
      </a>
    </li><!-- End Category Page Nav -->
  </ul>

</aside><!-- End Sidebar-->
