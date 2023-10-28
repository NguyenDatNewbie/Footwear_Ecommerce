package com.reidshop.Service;

import com.reidshop.Model.Entity.Category;

import java.util.List;

public interface ICategoryService {
    List<Category> familyCategoryByChildren(Category category);
}
