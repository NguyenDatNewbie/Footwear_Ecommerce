package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface CategoryRepository extends JpaRepository<Category,Long> {
    @Query("select c from Category c where c.id=?1")
    Category findCategoriesById(Long id);

    @Query("select c from Category c where c.parent=null ")
    List<Category> findAll();
    @Query("select c from Category c where c.parent=?1")
    List<Category> familyByParent(Long parent);
}
