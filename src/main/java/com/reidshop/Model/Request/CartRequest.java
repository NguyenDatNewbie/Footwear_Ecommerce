package com.reidshop.Model.Request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.List;

@Getter
@Setter
public class CartRequest {
    Long id;
    String size;
    Long color;
    int quantity;
}
