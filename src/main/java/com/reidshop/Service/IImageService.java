package com.reidshop.Service;

import com.reidshop.Model.Entity.Image;

import java.util.List;

public interface IImageService {
    List<Image> imageFirstOfColor(Long productId);
}
