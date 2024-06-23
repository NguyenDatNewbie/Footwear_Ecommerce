<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
		 isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
	<meta charset="UTF-8">
	<meta name="description" content="Male_Fashion Template">
	<meta name="keywords" content="Male_Fashion, unica, creative, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Thông tin cá nhân</title>
	<link rel="shortcut icon" type="image/x-icon"
		  href="/assets/img/logo/logo.png" style="width: 20px;">
	<!-- Google Font -->
	<link
			href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
			rel="stylesheet">
	<!-- Plugins CSS -->
	<link rel="stylesheet" href="/assets/css/plugins.css">

	<!-- Main Style CSS -->
	<link rel="stylesheet" href="/assets/css/style.css">

	<link rel="shortcut icon" type="image/x-icon"
		  href="assets/img/favicon.ico">

	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

	<%--<link rel="stylesheet" href="/assets/css/bootstrap.min.css"--%>
	<%--	type="text/css">--%>


	<style>
		.user-profile h4{
			font-size: 14px;
			line-height: 24px;
		}

		.btn-info {
			font-family: emoji;
			border: none;
		}

	</style>

</head>

<body>
<!-- Header Section Begin-->
<jsp:include page="header.jsp" />
<!-- Header Section End -->



<!-- Contact Section Begin -->
<div class="container" style="padding: 50px 50px">
	<div class="spad">
		<div class="row">

			<div class="card col-md-12">
				<div class="user-profile">
					<div style="padding: 15px">
						<form method="post" action="/profile/update">
							<div class="mb-3">
								<h4>Họ và tên</h4>
								<input type="text"
									   class="form-control" id="name" placeholder="Họ và tên"
									   name="name"
									   value="${info.accountDetail.name}" required>
							</div>
							<div class="mb-3">
									<h4>Số điện thoại</h4>
										<input type="text" class="form-control" id="phone" name="phone"
											   placeholder="Số điện thoại" value="${info.accountDetail.phone}" required >
							</div>

							<div class="mb-3">
								<h4>Email</h4> <input type="email" class="form-control"  id="email" name="email" readonly
													  placeholder="you@example.com" value="${info.email}" >
							</div>
							<div class="mb-3">
								<h4>Địa chỉ</h4> <input type="text" class="form-control" id="address" name="address" placeholder="Địa chỉ" required value="${info.accountDetail.address}" >
							</div>
							<div>
							<button type="submit" class="btn btn-info" style="width: 30%" >
								Lưu thông tin</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
<!-- Footer Section Begin -->
<jsp:include page="footer.jsp" />
<!-- Footer Section End -->




<!-- Js Plugins -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value="/assets/js/plugins.js"/>"></script>
<script src="<c:url value="/assets/js/plugins.js"/>"></script>
</body>

</html>



