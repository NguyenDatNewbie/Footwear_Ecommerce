package com.reidshop.Model.Request;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.ReceiveType;

import java.util.PrimitiveIterator;

public class OrderRequest {
    private Long id;
    private String phone;
    private String name;
    private String address;
    private double totalPrice;
    private ReceiveType receiveType;
    private Store store;
    private Account account;

    public OrderRequest(Long id, String phone, String name, String address, double totalPrice, ReceiveType receiveType, Store store, Account account) {
        this.id = id;
        this.phone = phone;
        this.name = name;
        this.address = address;
        this.totalPrice = totalPrice;
        this.receiveType = receiveType;
        this.store = store;
        this.account = account;
    }

    public Long getId() {
        return id;
    }

    public String getPhone() {
        return phone;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public ReceiveType getReceiveType() {
        return receiveType;
    }

    public void setReceiveType(ReceiveType receiveType) {
        this.receiveType = receiveType;
    }

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }
}
