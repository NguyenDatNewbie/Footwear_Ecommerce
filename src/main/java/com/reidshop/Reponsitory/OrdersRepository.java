package com.reidshop.Reponsitory;

import com.reidshop.Entity.Orders;
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
    double totalRevenueOfToday();
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE FUNCTION('DATE_FORMAT', o.createdAt, '%Y-%m') = FUNCTION('DATE_FORMAT', CURRENT_DATE, '%Y-%m')")
    double totalRevenueOfThisMonth();
    @Query("SELECT SUM(o.totalPrice) FROM Orders o WHERE YEAR(o.createdAt) = YEAR(CURRENT_DATE)")
    double totalRevenueOfThisYear();

}
