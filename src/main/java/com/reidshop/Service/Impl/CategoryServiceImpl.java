package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements ICategoryService {
    @Autowired
    CategoryRepository categoryRepository;

    @Override
    public List<Category> familyCategoryByChildren(Category children)
    {
        List<Category> categories = new ArrayList<>();
        Category currentCategory = children;
        int index = 1;
        for (int i =0;i<index;i++)
        {
            if(currentCategory.getParent()!=null) {
                index = index + 1;
                currentCategory = categoryRepository.findCategoriesById(currentCategory.getParent());
            }
            else break;
            categories.add(currentCategory);
        }
        return categories;
    }

    @Override
    public List<Category> familyByParent(Long parent){
        return categoryRepository.familyByParent(parent);
    }

    @Override
    public List<Category> findAll(){return categoryRepository.findAll();}
    @Override
    public Optional<Category> findById(Long id){return categoryRepository.findById(id);}
}
