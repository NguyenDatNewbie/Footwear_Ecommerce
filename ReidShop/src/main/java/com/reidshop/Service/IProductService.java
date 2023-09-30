package com.reidshop.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Sort;

import com.reidshop.Entity.Product;

public interface IProductService {


	List<Product> findAllByProductSoldTop();
	List<Product> findAllByProductCategorySoldTop(Long category);


	List<Product> sortByPriceDESC(List<Product> products);

	List<Product> sortByPriceASC(List<Product> products);

	List<Product> sortByProductSold(List<Product> products);

	List<Product> sortByNameAToZ(List<Product> products);

	List<Product> sortByNameZtoA(List<Product> products);

	List<Product> selectTop(List<Product> products, int from, int to);

	List<Integer> sizeProduct(List<Product> products);
}
