<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Import File</title>
    <!-- Vendor CSS Files -->
    <link href="/admin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <style>
        .btn-info{
            font-weight: 500 !important;
            color: #fff;
            background-color: #5bc0de;
            display: inline-block;
            padding: 6px 12px;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            margin: 0 6px;
        }
        .alert{
            margin: 0;
        }
        .hidden{
            display: none;
        }
    </style>
</head>
<body>
<div class="alert alert-success hidden" role="alert">
    <strong>Thành Công!</strong> Đơn hàng của bạn sẽ được nhập
</div>

<div class="alert alert-danger hidden" role="alert">
    <strong>Thất bại!</strong> Kiểm tra lại file của bạn đúng định dạng chưa
</div>
    <div>
        <div class="row bg-info" style="background-color: #d9edf7!important;">
            <div style="text-align: center">
                <label class="form-title large bold" style="font-size: 16px;
        font-weight: bold;">IMPORT FILE</label>
            </div>
        </div>
        <form action="/excel/import/stock" method="post" enctype="multipart/form-data">
            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex; justify-content: center; margin: 50px 0;">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="file" name="file" class="form-control" >
                </div>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center">
                <button type="button" class="btn btn-info"><i class="bi bi-download"></i> Tải tập tin mẫu</button>
                <button type="submit" class="btn btn-info"><i class="bi bi-upload"></i> Import</button>
            </div>
        </form>

    </div>

    <script src="/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/admin/assets/js/main.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var btn = document.querySelectorAll('.btn-info');
            btn[0].addEventListener("click",function (){
                downloadSample()
            })


            var messageFromURL = getParameterByName('message');
            if (messageFromURL === "success") {
                var messageBox = document.querySelector(".alert-success");
                messageBox.classList.remove("hidden");
                setTimeout(function () {
                    messageBox.classList.add("hidden");
                }, 2000);
            }
            else if(messageFromURL!=null) {
                var messageBox = document.querySelector(".alert-danger");
                messageBox.classList.remove("hidden");
            }


        });

        // Hàm để lấy giá trị của tham số từ URL
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }
        function downloadSample(){
            $.ajax({
                url: '/excel/download/sample',
                type: "get",
                xhrFields: {
                    responseType: 'blob' // Xác định kiểu dữ liệu phản hồi là blob (binary data)
                },
                success: function(response, status, xhr) {
                    // Xử lý phản hồi thành công
                    var contentType = xhr.getResponseHeader('Content-Type');
                    var contentDisposition = xhr.getResponseHeader('Content-Disposition');


                    // Tạo một đường dẫn URL tạm thời cho file Excel
                    var blob = new Blob([response], { type: contentType });
                    var url = window.URL.createObjectURL(blob);

                    // Tạo một thẻ <a> ẩn để tải xuống file
                    var a = document.createElement('a');
                    a.href = url;
                    a.download = getFileName(contentDisposition); // Lấy tên file từ Content-Disposition header
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);

                    // Giải phóng đường dẫn URL
                    window.URL.revokeObjectURL(url);

                },
                error: function(xhr, status, error) {

                    // Xử lý lỗi
                    console.error('Lỗi khi gọi API: ' + error);
                }
            });
        }

        function getFileName(contentDisposition) {
            var filename = '';
            var startIndex = contentDisposition.indexOf('filename=');
            if (startIndex !== -1) {
                filename = contentDisposition.substring(startIndex + 9);
                filename = filename.replace(/"/g, ''); // Loại bỏ dấu ngoặc kép (nếu có)
            }
            return filename;
        }
    </script>
</body>
</html>
