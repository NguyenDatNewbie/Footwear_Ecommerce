package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository

public interface OrdersRepository extends JpaRepository<Orders,Long> {
    @Query("SELECT count(*) from Orders p")
    int countAllOrders();

    //Đếm số đơn hàng theo ngày
    @Query("SELECT COUNT(o) FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE")
    Long countOrdersCreatedToday();
    //Đếm số đơn hàng trong tháng
    @Query("SELECT COUNT(o) FROM Orders o WHERE FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')")
    Long countOrdersInCurrentMonth();
    //Đếm số lượng của 1 ngày được truyền vào
    @Query("SELECT COUNT(o) FROM Orders o WHERE DATE(o.createdAt) = :date")
    Long countOrderByDate(@Param("date") Date date);
    //Đếm số lượng đơn hàng của 1 tháng
    @Query("SELECT COUNT(o) FROM Orders o WHERE FUNCTION('YEAR', o.createdAt) = :year AND FUNCTION('MONTH', o.createdAt) = :month")
    Long countOrdersOfMonth(@Param("year") int year, @Param("month") int month);
    //Đếm số lượng đơn hàng theo năm
    @Query("SELECT COUNT(o) FROM Orders o WHERE YEAR(o.createdAt) = YEAR(CURRENT_DATE)")
    Long countOrdersInCurrenYear();
    //Tổng doanh thu toàn bộ của hàng
    @Query("SELECT SUM(p.totalPrice) FROM Orders p\n")
    double revenueAll();
    //Tổng doanh thu theo ngày
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE")
    double totalSalesOfToday();
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')")
    double totalSalesOfThisMonth();
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE YEAR(o.createdAt) = YEAR(CURRENT_DATE)")
    double totalSalesOfThisYear();

    //Lấy tất cả order_id trong ngày
    @Query("SELECT o.id FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE AND o.status = 'COMPLETE'")
    List<Integer> findAllOrderToday();

    //lấy order_id trong 1 tuần
    @Query("SELECT o.id FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE'")
    List<Integer> findAllOrderOfThisWeek();
    //tổng doanh số trong tuần hiện tại
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE'")
    double totalPriceOfThisWeek();

    //Lấy order_id trong 1 tháng
    @Query("SELECT o.id FROM Orders o WHERE FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')")
    List<Integer> findAllOrderOfThisMonth();

    //List total_price của các order trong tuần
    @Query("SELECT SUM(o.totalPrice) AS dailyTotal " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) " +
            "GROUP BY DATE(o.createdAt) ")
    List<Double> listTotalPriceOfThisWeek();


    //List order id của mỗi ngày trong tuần
    @Query("SELECT DATE(o.createdAt) AS orderDate, GROUP_CONCAT(o.id) AS orderIds " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) " +
            "GROUP BY DATE(o.createdAt)")
    List<Object[]> findOrderIdsByWeek();


    // User
    //List order theo account_id
    @Query("SELECT o FROM Orders o WHERE o.account.id = :accountId")
    List<Orders> findAllOrderByAccountId(@Param("accountId") Long accountId);

    //List order WAIT
    @Query("SELECT o FROM Orders o WHERE o.status = 'WAIT'")
    List<Orders> findAllOrderWait();
    //List order PREPARE
    @Query("SELECT o FROM Orders o WHERE o.status = 'PREPARE'")
    List<Orders> findAllOrderPrepare();
    //List order ALREADY
    @Query("SELECT o FROM Orders o WHERE o.status = 'ALREADY'")
    List<Orders> findAllOrderAlready();
    //List order DELIVERY
    @Query("SELECT o FROM Orders o WHERE o.status = 'DELIVERY'")
    List<Orders> findAllOrderDelivery();
    //List order COMPLETE
    @Query("SELECT o FROM Orders o WHERE o.status = 'COMPLETE'")
    List<Orders> findAllOrderComplete();
    //List order CANCEL
    @Query("SELECT o FROM Orders o WHERE o.status = 'CANCEL'")
    List<Orders> findAllOrderCancel();
}
