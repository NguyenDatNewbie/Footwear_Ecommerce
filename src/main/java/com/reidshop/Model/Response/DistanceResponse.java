package com.reidshop.Model.Response;

import lombok.Data;

import java.util.ArrayList;
import java.util.Objects;

@Data
public class DistanceResponse {
    ArrayList origin_addresses;
    ArrayList destination_addresses;
    String status;
    ArrayList rows;
}
