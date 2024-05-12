package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Posts;
import com.reidshop.Model.Enum.PostType;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostsRepository extends JpaRepository<Posts,Long> {
    @Query("select p from Posts p where p.postType=?1 order by p.updateAt desc ")
    List<Posts> findAllByPostType(PostType postType);

    @Query("select p from Posts p order by p.updateAt desc")
    List<Posts> findNews(Pageable pageable);
    @Override
    @Query("select p from Posts p order by p.updateAt desc")
    List<Posts> findAll();

}
