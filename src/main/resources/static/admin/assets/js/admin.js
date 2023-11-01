var formatter = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
});
$(document).ready(function() {
    $('#today').click(function() {
        $.ajax({
            url: '/admin/getTotalOrderToday', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalOrder = response;
                $('#totalOrders').text(newTotalOrder);
                $('#orderText').text("| Today");
            }
        });
        $.ajax({
            url: '/admin/getOrderIncreaseLastDate', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var percent = parseFloat(response);

                var orderIncreaseText = $('#orderIncreaseText');
                var increaseText = $('#increaseOrderText');

                //Thực hiện logic
                if(percent < 0){
                    orderIncreaseText.removeClass('text-success').addClass('text-danger');
                    percent = Math.abs(percent);
                    increaseText.text('Decrease');
                } else
                {
                    increaseText.text('Increase');
                }

                orderIncreaseText.text(percent + "%");
            }
        });
    });
});
$(document).ready(function() {
    $('#thisMonth').click(function() {
        $.ajax({
            url: '/admin/getTotalOrderThisMonth', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalOrder = response;
                $('#totalOrders').text(newTotalOrder);
                $('#orderText').text("| This Month");
            }
        });
        $.ajax({
            url: '/admin/getOrderIncreaseLastMonth', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var percent = parseFloat(response);

                var orderIncreaseText = $('#orderIncreaseText');
                var increaseText = $('#increaseOrderText');

                //Thực hiện logic
                if(percent < 0){
                    orderIncreaseText.removeClass('text-success').addClass('text-danger');
                    percent = Math.abs(percent);
                    increaseText.text('Decrease');
                } else
                {
                    increaseText.text('Increase');
                }

                orderIncreaseText.text(percent + "%");
            }
        });
    });
});
$(document).ready(function() {
    $('#thisYear').click(function() {
        $.ajax({
            url: '/admin/getTotalOrderThisYear', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalOrder = response;
                var increaseText = $('#increaseOrderText');
                var orderIncreaseText = $('#orderIncreaseText');

                $('#totalOrders').text(newTotalOrder);
                $('#orderText').text("| This Year");
                increaseText.text('');
                orderIncreaseText.text('');

            }
        });
    });
});
$(document).ready(function() {
    $('#todaySales').click(function() {
        $.ajax({
            url: '/admin/getTotalSalesToday', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalSales = response;
                $('#totalSales').text(formatter.format(newTotalSales));
                $('#salesText').text("| Today");
            }
        });
    });
});
$(document).ready(function() {
    $('#monthSales').click(function() {
        $.ajax({
            url: '/admin/getTotalSalesThisMonth', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalSales = response;
                $('#totalSales').text(formatter.format(newTotalSales));
                $('#salesText').text("| This Month");
            }
        });
    });
});
$(document).ready(function() {
    $('#yearSales').click(function() {
        $.ajax({
            url: '/admin/getTotalSalesThisYear', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var newTotalSales = response;
                $('#totalSales').text(formatter.format(newTotalSales));
                $('#salesText').text("| This Year");
            }
        });
    });
});
//Revenue
$(document).ready(function() {
    $('#todayRevenue').click(function() {
        $.ajax({
            url: '/admin/getRevenueToday', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var revenue = response;
                $('#revenue').text(formatter.format(revenue));
                $('#revenueText').text("| Today");
            }
        });
    });
});
$(document).ready(function() {
    $('#thisWeekRevenue').click(function() {
        $.ajax({
            url: '/admin/getRevenueThisWeek', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var revenue = response;
                $('#revenue').text(formatter.format(revenue));
                $('#revenueText').text("| This Week");
            }
        });
    });
});
$(document).ready(function() {
    $('#thisMonthRevenue').click(function() {
        $.ajax({
            url: '/admin/getRevenueThisMonth', // Địa chỉ máy chủ để gửi yêu cầu
            method: 'GET',
            success: function(response) {
                var revenue = response;
                $('#revenue').text(formatter.format(revenue));
                $('#revenueText').text("| This Month");
            }
        });
    });
});
$(document).ready(function() {
    // Sử dụng jQuery hoặc JavaScript để gọi API endpoint
    $.get('/admin/getRevenueToday', function(response) {
        // Xử lý kết quả từ API và cập nhật lên trang web
        $('#revenue').text(formatter.format(response));
    });
});

