package com.reidshop.Service;

import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Orders;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public interface IEvaluateServiceImpl {
    double rateAvg(List<Evaluate> evaluateList);

    double avg(List<Evaluate> evaluateList);

    ArrayList<Double> rateStar(double rateAvg);

    ArrayList<Integer> createListInt(int length);

    List<Evaluate> findAllByProductId(Long id);

    List<Evaluate> findAll();

    Optional<Evaluate> findById(Long id);

//    boolean checkExist(Orders orders);
}
