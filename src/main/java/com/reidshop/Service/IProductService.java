package com.reidshop.Service;

import java.util.List;

import com.reidshop.Model.Entity.Product;

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

    List<Product> filterRange(Long categoryId, double min, double max);

    List<Product> findNewProduct(int quantityProduct);

    List<Product> addAll(List<Product> products1, List<Product> products2);
}