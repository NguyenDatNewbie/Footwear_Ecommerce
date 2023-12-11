package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Reponsitory.EvaluateRepository;
import com.reidshop.Service.IEvaluateServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EvaluateServiceImpl implements IEvaluateServiceImpl {
    @Autowired
    EvaluateRepository evaluateRepository;

    @Override
    public double rateAvg(List<Evaluate> evaluateList){
        int sum = 0;
        int size = evaluateList.size();
        for(int i =0;i<size;i++){
            sum += evaluateList.get(i).getRate();
        }
        double avg = (double) sum/size;

        double impair = avg - (int)avg;
        if(impair>0.5){
            avg = avg - impair + 1;
        }
        else if(impair>0.3){
            avg = avg - impair + 0.5;
        }
        else {
            avg = 0;
        }
        return avg;
    }


    @Override
    public double avg(List<Evaluate> evaluateList){
        int sum = 0;
        int size = evaluateList.size();
        for(int i =0;i<size;i++){
            sum += evaluateList.get(i).getRate();
        }

        return (double) sum/size;
    }

    @Override
    public ArrayList<Double> rateStar(double rateAvg){
        ArrayList<Double> results = new ArrayList<>();
        for(int i = 0;i<5;i++){
            double addValue = 1.0;
            if(rateAvg>=1.0){
                rateAvg -=1;
            }
            else if(rateAvg>0){
                addValue = rateAvg;
                rateAvg = 0;
            }
            else {
                addValue = 0;
            }
            results.add(addValue);
        }
        return results;
    }

    @Override
    public ArrayList<Integer> createListInt(int length){
        ArrayList<Integer> arrayList = new ArrayList<>();
        for(int i=length;i>0;i--)
            arrayList.add(i);
        return arrayList;
    }

}
