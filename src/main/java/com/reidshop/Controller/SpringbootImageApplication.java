package com.reidshop.Controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringbootImageApplication {
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
