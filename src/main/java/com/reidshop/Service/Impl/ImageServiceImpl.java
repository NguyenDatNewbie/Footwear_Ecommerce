package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Image;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Service.IImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ImageServiceImpl implements IImageService {
    @Autowired
    ImageRepository imageRepository;
    @Override
    public List<Image> imageFirstOfColor(Long productId){
        List<Long> colorIds = imageRepository.findColorOther(productId);
        List<Image> images = new ArrayList<>();
        for (Long id: colorIds) {
            List<Image> imagesSearch = imageRepository.findAllByProductAndColor(id,productId);
            if(imagesSearch.size()>0)
                images.add(imagesSearch.get(0));
        }
        return images;
    }
}
