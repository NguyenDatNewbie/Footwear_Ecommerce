package com.reidshop.Service;

import com.reidshop.Model.Entity.Image;

import java.util.List;

public interface IImageService {
    List<Image> imageFirstOfColor(Long productId);

    List<Long> findColorOther(Long id);

    List<Image> findAllByProductAndColor(Long color_id, Long product_id);
}
