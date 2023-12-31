package com.reidshop.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GoogleUserInfo {
        @JsonProperty("id")
        private String id;

        @JsonProperty("email")
        private String email;

        @JsonProperty("verified_email")
        private Boolean verified_email;

        @JsonProperty("name")
        private String name;

        @JsonProperty("given_name")
        private String given_name;

        @JsonProperty("family_name")
        private String family_name;

        @JsonProperty("picture")
        private String picture;

        @JsonProperty("locale")
        private String locale;

}
