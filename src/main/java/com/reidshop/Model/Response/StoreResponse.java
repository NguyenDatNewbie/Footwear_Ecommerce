package com.reidshop.Model.Response;

import com.reidshop.Model.Entity.Account;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreResponse {
    Long id;
    String department;
    Long accountId;
}
