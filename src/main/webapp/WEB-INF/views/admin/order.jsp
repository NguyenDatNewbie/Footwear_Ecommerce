<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
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

  <!-- Template Main CSS File -->
  <link href="/admin/assets/css/style.css" rel="stylesheet">
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" />
<!-- ======= Sidebar ======= -->
<jsp:include page="sidebar.jsp" />

<main id="main" class="main">

  <section class="section dashboard">
    <div class="row">

      <!-- Left side columns -->
      <div class="col-lg-12">
        <div class="row">
          <!-- Recent Sales -->
          <div class="col-12">
            <div class="card recent-sales overflow-auto">

              <div class="card-body">
                <h5 class="card-title">Management Orders <span>| Admin</span></h5>
                <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100 active" id="all-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-all" type="button" role="tab" aria-controls="home" aria-selected="true">All Order</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="wait-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-wait" type="button" role="tab" aria-controls="profile" aria-selected="false">WAIT</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="prepare-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-prepare" type="button" role="tab" aria-controls="contact" aria-selected="false">PREPARE</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="already-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-already" type="button" role="tab" aria-controls="contact" aria-selected="false">ALREADY</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="delivery-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-delivery" type="button" role="tab" aria-controls="contact" aria-selected="false">DELIVERY</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="complete-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-complete" type="button" role="tab" aria-controls="contact" aria-selected="false">COMPLETE</button>
                  </li>
                  <li class="nav-item flex-fill" role="presentation">
                    <button class="nav-link w-100" id="cancel-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-cancel" type="button" role="tab" aria-controls="contact" aria-selected="false">CANCEL</button>
                  </li>
                </ul>
                <div class="tab-content pt-2" id="borderedTabJustifiedContent">
                  <div class="tab-pane fade show active" id="bordered-justified-all" role="tabpanel" aria-labelledby="all-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${orders}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-wait" role="tabpanel" aria-labelledby="wait-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderWait()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-prepare" role="tabpanel" aria-labelledby="prepare-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderPrepare()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-already" role="tabpanel" aria-labelledby="already-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderAlready()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-delivery" role="tabpanel" aria-labelledby="delivery-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderDelivery()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-complete" role="tabpanel" aria-labelledby="complete-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderComplete()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="bordered-justified-cancel" role="tabpanel" aria-labelledby="cancel-tab">
                    <table class="table table-borderless datatable">
                      <thead>
                      <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Total Price</th>
                        <th scope="col">Store</th>
                        <th scope="col">Creation Time</th>
                        <th scope="col">Receive Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Action</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${ordersRepository.findAllOrderCancel()}" var="order">
                        <tr>
                          <th scope="row">${order.id}</th>
                          <td>${order.phone}</td>
                          <td>${order.name}</td>
                          <td>${order.address}</td>
                          <td>${formatVND.format(order.totalPrice)}</td>
                          <td>${order.store.department}</td>
                          <td>${order.createdAt}</td>
                          <td>
                            <c:choose>
                              <c:when test="${order.receiveType == 'DELIVERY'}">
                                <span class="badge bg-info">${order.receiveType}</span>
                              </c:when>
                              <c:when test="${order.receiveType == 'STORE'}">
                                <span class="badge bg-light text-dark">${order.receiveType}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'WAIT'}">
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'PREPARE'}">
                                <span class="badge bg-warning">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'ALREADY'}">
                                <span class="badge bg-primary">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERY'}">
                                <span class="badge bg-info">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'COMPLETE'}">
                                <span class="badge bg-success">${order.status}</span>
                              </c:when>
                              <c:when test="${order.status == 'CANCEL'}">
                                <span class="badge bg-danger">${order.status}</span>
                              </c:when>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${order.status == 'CANCEL'}">
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" disabled class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" disabled class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:when>
                              <c:otherwise>
                                <button type="button" onclick="window.location.href='/admin/account/${order.account.id}/${order.id}'" class="btn btn-info" style="font-size: 15px">Detail</button>
                                <button type="button" onclick="window.location.href='/admin/order/updateStatus/${order.id}'" class="btn btn-success" style="font-size: 15px">Update Status</button>
                                <button type="button" onclick="window.location.href='/admin/order/cancelOrder/${order.id}'" class="btn btn-danger" style="font-size: 15px">Cancel</button>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div><!-- End Recent Sales -->
      </div><!-- End Right side columns -->

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

</body>

</html>