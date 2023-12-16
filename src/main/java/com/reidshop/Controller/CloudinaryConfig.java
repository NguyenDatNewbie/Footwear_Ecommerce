package com.reidshop.Controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {
    @Bean
    public Cloudinary cloudinary(){
        Cloudinary c = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dhmeeqkgr",
                "api_key", "977724747998332",
                "api_secret", "kcVp18vncm_JVuFcwcNaUyz9dQ8",
                "secure",true
        ));
        return c;
    }
}
