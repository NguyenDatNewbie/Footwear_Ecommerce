<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false"%>

<aside id="sidebar" class="sidebar">

  <ul class="sidebar-nav" id="sidebar-nav">

    <li class="nav-item">
      <a class="nav-link " href="<c:url value="/vendor/home"/>">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link " href="<c:url value="/vendor/order"/>">
        <i class="bi bi-journal-text"></i>
        <span>Orders</span>
      </a>
    </li><!-- End Order Page Nav -->

    <li class="nav-item">
      <a class="nav-link " href="<c:url value="/vendor/listStock"/>">
        <i class="bi bi-grid"></i>
        <span>Inventory</span>
      </a>
    </li><!-- End Dashboard Nav -->
    <li class="nav-item">
      <a class="nav-link " href="<c:url value="/vendor/stock/list"/>" data-bs-target="#forms-nav" data-bs-toggle="collapse" >
        <i class="bi bi-journal-text"></i><span>Stock</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="forms-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="<c:url value="/vendor/stock/list"/>">
            <i class="bi bi-circle"></i><span>List</span>
          </a>
        </li>
        <li>
          <a href="<c:url value="/vendor/stock"/>">
            <i class="bi bi-circle"></i><span>Import Inventory</span>
          </a>
        </li>
      </ul>
    </li><!-- End Forms Nav -->
  </ul>

</aside><!-- End Sidebar-->
<script>
  window.onload = function (){
    // Lấy URL hiện tại của trang web
    const currentUrl = window.location.href;

    // Định nghĩa baseUrl cần loại bỏ
    const baseUrl = '/vendor/';

    // Tìm vị trí của baseUrl trong currentUrl
    const baseUrlIndex = currentUrl.indexOf(baseUrl);

    if (baseUrlIndex !== -1) {
      // Lấy phần còn lại của URL sau baseUrl
      const relativeUrl = currentUrl.substring(baseUrlIndex + baseUrl.length);

      // Lấy phần đầu tiên của relativeUrl
      const firstPart = relativeUrl.split('/')[0];
      deleteCollapsed(firstPart);
    } else {
      console.log('Base URL not found in the current URL');
    }
  }
  function deleteCollapsed(url){
    console.log(url);
    var nav = document.querySelectorAll("#sidebar-nav .nav-link");
    nav.forEach((n)=> {
      n.classList.add("collapsed");
    })
    if(url === 'home')
      nav[0].classList.remove("collapsed");
    else if(url === 'order')
      nav[1].classList.remove("collapsed");
    else if(url === 'listStock')
      nav[2].classList.remove("collapsed");
    else if(url === 'stock')
      nav[3].classList.remove("collapsed");
  }
</script>
