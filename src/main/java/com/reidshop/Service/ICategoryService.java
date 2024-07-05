package com.reidshop.Service;

import com.reidshop.Model.Entity.Category;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {
    List<Category> familyCategoryByChildren(Category category);

    List<Category> familyByParent(Long parent);

    List<Category> findAll();

    Optional<Category> findById(Long id);
}
