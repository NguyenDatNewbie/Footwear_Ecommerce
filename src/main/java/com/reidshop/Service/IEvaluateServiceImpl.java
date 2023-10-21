package com.reidshop.Service;

import com.reidshop.Entity.Evaluate;

import java.util.ArrayList;
import java.util.List;

public interface IEvaluateServiceImpl {
    double rateAvg(List<Evaluate> evaluateList);

    double avg(List<Evaluate> evaluateList);

    ArrayList<Double> rateStar(double rateAvg);

    ArrayList<Integer> createListInt(int length);
}
