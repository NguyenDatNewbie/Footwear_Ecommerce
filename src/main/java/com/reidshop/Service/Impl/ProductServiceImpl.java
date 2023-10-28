package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IProductService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    ProductRepository productRepository;
	@Autowired
	ImageRepository imageRepository;

	@Override
	public List<Product> findAllByProductSoldTop(){
		List<Product> result = new ArrayList<>();
		List<Product> products = productRepository.findAllByProductSold();
		for(int i=0;i<products.size();i++){
			if(i==12)
				break;
			result.add(products.get(i));
		}
		return result;
	}


	@Override
	public List<Product> findAllByProductCategorySoldTop(Long category){
		List<Product> result = new ArrayList<>();
		List<Product> products = productRepository.findAllByCategory(category);
		for(int i=0;i<products.size();i++){
			if(i==12)
				break;
			result.add(products.get(i));
		}
		return result;
	}


	@Override
	public List<Product> sortByPriceDESC(List<Product> products){
		Product p = new Product();
		for(int i =0;i<products.size();i++) {
			for(int j = i+1;j<products.size();j++) {
				p = products.get(i);
				double tmp =p.getPrice() * (1- (p.getPromotion()/100.0));
				double val =  products.get(j).getPrice()*(1-products.get(j).getPromotion()/100.0);
				if(tmp<val) {
					products.set(i, products.get(j));
					products.set(j,p);
				}
			}
		}
		return products;
   }

	@Override
	public List<Product> sortByPriceASC(List<Product> products){
		Product p = new Product();
		for(int i =0;i<products.size();i++) {
			for(int j = i;j<products.size();j++) {
				p = products.get(i);
				double tmp =p.getPrice() * (1- (p.getPromotion()/100.0));
				double val =  products.get(j).getPrice()*(1-products.get(j).getPromotion()/100.0);
				if(tmp>val) {
					products.set(i, products.get(j));
					products.set(j,p);
				}
			}
		}
		return products;
	}

	@Override
	public List<Product> sortByProductSold(List<Product> products){
		for(int i =0;i<products.size()-1;i++) {
			for(int j = i+1;j<products.size();j++) {
				if(products.get(i).getSold()<products.get(j).getSold()) {
					Product p = products.get(i);
					products.set(i, products.get(j));
					products.set(j,p);
				}
			}
		}
		return products;
	}

	@Override
	public  List<Product> sortByNameAToZ(List<Product> products){
		for(int i =0;i<products.size()-1;i++) {
			for(int j = i+1;j<products.size();j++) {
				if(products.get(i).getName().compareTo(products.get(j).getName())>0) {
					Product p = products.get(i);
					products.set(i, products.get(j));
					products.set(j,p);
				}
			}
		}
		return products;
	}

	@Override
	public  List<Product> sortByNameZtoA(List<Product> products){
		for(int i =0;i<products.size()-1;i++) {
			for(int j = i+1;j<products.size();j++) {
				if(products.get(i).getName().compareTo(products.get(j).getName())<0) {
					Product p = products.get(i);
					products.set(i, products.get(j));
					products.set(j,p);
				}
			}
		}
		return products;
	}

	@Override
	public List<Product> selectTop(List<Product> products, int from, int to){
		List<Product> result = new ArrayList<>();
		if(from>to)
			return new ArrayList<>();
		if(to>products.size())
			to = products.size();
		for(int i = from;i<to;i++) {
			result.add(products.get(i));
		}
		return result;
	}

	@Override
	public List<Integer> sizeProduct(List<Product> products){
		List<Integer> sizes = new ArrayList<>();
		double sz = products.size()/6.0;
		int size = (int) sz;
		if(sz>size)
			size+=1;
		for(int i=1;i<= size;i++){
			sizes.add(i);
		}
		return sizes;
	}

	@Override
	public List<Product> filterRange(Long categoryId, double min, double max){
		List<Product> products = productRepository.findAllByCategory(categoryId);
		List<Product> result = new ArrayList<>();
		double price;
		for(int i =0;i<products.size();i++){
			price =products.get(i).getPrice()*(1-products.get(i).getPromotion()/100.0);

			if(price>=min && price<=max)
				result.add(products.get(i));
		}

		return sortByPriceDESC(result);
	}

	@Override
	public List<Product> findNewProduct(int quantityProduct){
		List<Product> products = productRepository.findAll();
		List<Product> result = new ArrayList<>();
		int size = products.size()-1;
		if(quantityProduct>size)
			quantityProduct=size;
		for(int i =0;i<quantityProduct;i++){
			result.add(products.get(size-i));
		}
		return result;
	}

	@Override
	public List<Product> addAll(List<Product> products1, List<Product> products2){
		products1.addAll(products2);
		return products1;
	}
}
