package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Size;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
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
    @Query("SELECT COALESCE(SUM(p.totalPrice), 0) FROM Orders p WHERE p.status = 'COMPLETE'")
    double revenueAll();
    //Tổng doanh thu theo ngày
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE AND o.status = 'COMPLETE'")
    double totalSalesOfToday();
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE (FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')) AND o.status = 'COMPLETE'")
    double totalSalesOfThisMonth();
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE YEAR(o.createdAt) = YEAR(CURRENT_DATE) AND o.status = 'COMPLETE'")
    double totalSalesOfThisYear();

    //Lấy tất cả order_id trong ngày
    @Query("SELECT o.id FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE AND o.status = 'COMPLETE'")
    List<Integer> findAllOrderToday();

    //lấy order_id trong 1 tuần
    @Query("SELECT o.id FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE'")
    List<Integer> findAllOrderOfThisWeek();
    //tổng doanh số trong tuần hiện tại
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE'")
    double totalPriceOfThisWeek();

    //Lấy order_id trong 1 tháng
    @Query("SELECT o.id FROM Orders o WHERE (FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')) AND o.status = 'COMPLETE'")
    List<Integer> findAllOrderOfThisMonth();

    @Query("SELECT o.id FROM Orders o WHERE MONTH(o.createdAt) = ?1 AND o.status = 'COMPLETE'")
    List<Integer> findOrdersByMonth(int month);

//    @Query("SELECT COALESCE(COUNT(o), 0) FROM Orders o WHERE o.paymentType=?1 AND (FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m'))")
    @Query("SELECT COALESCE(COUNT(o), 0) FROM Orders o WHERE o.paymentType=?1")
    Long countOrdersByPaymentType(PaymentType paymentType);

    @Query("SELECT COALESCE(COUNT(o), 0) FROM Orders o WHERE o.status=?1")
    Long countOrdersByStatus(OrderStatus orderStatus);

    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE MONTH(o.createdAt) = ?1 AND o.status = 'COMPLETE'")
    double totalSalesOfMonth(int month);

    //List total_price của các order trong tuần
    @Query("SELECT SUM(o.totalPrice) AS dailyTotal " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) and o.status = 'COMPLETE'" +
            "GROUP BY DATE(o.createdAt) ")
    List<Double> listTotalPriceOfThisWeek();


    //List order id của mỗi ngày trong tuần
    @Query("SELECT DATE(o.createdAt) AS orderDate, GROUP_CONCAT(o.id) AS orderIds " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) and o.status = 'COMPLETE'" +
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


    //Order by Store_id
    @Query("select o from Orders o where o.store.id = :storeId")
    List<Orders> findAllByStoreID(@Param("storeId") Long storeId);

    //List Order by Store_ID with Recv_type and Status
    @Query("SELECT o FROM Orders o WHERE o.status = :status AND o.receiveType = :recv_type AND o.store.id = :storeId")
    List<Orders> findAllOrdersByRecvAndStoreId(@Param("status") OrderStatus status, @Param("recv_type") ReceiveType recv_type, @Param("storeId") Long storeId);

    //List order by store_id for status
    @Query("SELECT o FROM Orders o WHERE o.status = :status AND o.store.id = :storeId")
    List<Orders> findAllOrdersByStatusAndStoreId(@Param("status") OrderStatus status, @Param("storeId") Long storeId);

    //Vendor
    //Order
    @Query("SELECT count(*) from Orders p where p.store.id = :storeId")
    int countAllOrdersForStore(@Param("storeId") Long storeId);

    @Query("SELECT count(*) from Orders p where p.store.id = :storeId and DATE(p.createdAt) = CURRENT_DATE")
    int countTodayOrdersForStore(@Param("storeId") Long storeId);

    @Query("SELECT count(*) from Orders p where p.store.id = :storeId and FUNCTION('DATE_FORMAT', p.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')")
    int countMonthOrdersForStore(@Param("storeId") Long storeId);

    //Sale
    @Query("SELECT COALESCE(SUM(p.totalPrice), 0) FROM Orders p where p.store.id = :storeId AND p.status = 'COMPLETE'")
    double saleAllByStoreId(@Param("storeId") Long storeId);

    @Query("SELECT COALESCE(SUM(p.totalPrice), 0) FROM Orders p WHERE DATE(p.createdAt) = CURRENT_DATE AND p.status = 'COMPLETE' and  p.store.id = :storeId")
    double totalSalesOfTodayStore(@Param("storeId") Long storeId);

    @Query("SELECT COALESCE(SUM(p.totalPrice), 0) FROM Orders p WHERE (FUNCTION('DATE_FORMAT', p.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')) AND p.status = 'COMPLETE' and  p.store.id = :storeId")
    double totalSalesOfMonthStore(@Param("storeId") Long storeId);

    //revenue
    @Query("SELECT o.id FROM Orders o WHERE DATE(o.createdAt) = CURRENT_DATE AND o.status = 'COMPLETE' AND o.store.id = :storeId")
    List<Integer> findAllOrderTodayStore(@Param("storeId") Long storeId);

    @Query("SELECT o.id FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE' AND o.store.id = :storeId")
    List<Integer> findAllOrderWeekStore(@Param("storeId") Long storeId);

    @Query("SELECT p.id FROM Orders p WHERE (FUNCTION('DATE_FORMAT', p.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')) AND p.status = 'COMPLETE' AND p.store.id = :storeId")
    List<Integer> findAllOrderMonthStore(@Param("storeId") Long storeId);

    @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Orders o WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) AND o.status = 'COMPLETE' AND o.store.id = :storeId")
    double totalPriceOfThisWeekStore(@Param("storeId") Long storeId);

    //List total_price của các order trong tuần
    @Query("SELECT SUM(o.totalPrice) AS dailyTotal " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) and o.status = 'COMPLETE' AND o.store.id = :storeId " +
            "GROUP BY DATE(o.createdAt) ")
    List<Double> listTotalPriceOfThisWeekStore(@Param("storeId") Long storeId);

    @Query("select o from Orders o where o.account.id=?1 ORDER BY o.id DESC")
    List<Orders> findOrdersByAccount(Long id);
    @Query("select o from Orders o where o.account.id=?1 and o.status= ?2 ORDER BY o.id DESC")
    List<Orders> findOrdersByAccountAndStatus(Long id, OrderStatus status);

    @Query("select o from Orders o where o.account.id=?1 and o.receiveType='STORE' ORDER BY o.id DESC")
    List<Orders> findOrdersByAccountReceive(Long id);

    @Query("select o from Orders o inner join OrderItem item on o.id = item.order.id where o.account.id=?2 " +
            "and o.store.department LIKE CONCAT('%', ?1, '%')")
    List<Orders> findBySearchQuery(String query,Long accountId);



    //find order id this week of storeID
    @Query("SELECT DATE(o.createdAt) AS orderDate, GROUP_CONCAT(o.id) AS orderIds " +
            "FROM Orders o " +
            "WHERE YEARWEEK(o.createdAt, 1) = YEARWEEK(CURDATE(), 1) and o.status = 'COMPLETE' and o.store.id = :storeId " +
            "GROUP BY DATE(o.createdAt)")
    List<Object[]> findOrderIdsByWeekOfStore(@Param("storeId") Long storeId);
}
