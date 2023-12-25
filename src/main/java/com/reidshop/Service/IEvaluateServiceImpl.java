package com.reidshop.Service;

import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Orders;

import java.util.ArrayList;
import java.util.List;

public interface IEvaluateServiceImpl {
    double rateAvg(List<Evaluate> evaluateList);

    double avg(List<Evaluate> evaluateList);

    ArrayList<Double> rateStar(double rateAvg);

    ArrayList<Integer> createListInt(int length);

//    boolean checkExist(Orders orders);
}
