package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Color;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Reponsitory.ColorRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@Service
public class CartServiceImpl implements ICartService {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    ImageRepository imageRepository;
    @Autowired
    ColorRepository colorRepository;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @Override
    public String getItemCart(List<CartRequest> requestList)
    {
        String result ="";
        int totalQuantity=0;
        double totalPrice=0;
        for(int i=0;i<requestList.size();i++)
        {
            CartRequest item = requestList.get(i);
            totalQuantity+=item.getQuantity();
            Product product = productRepository.findById(item.getId()).orElse(null);
            Color color = colorRepository.findById(item.getColor()).orElse(null);
            if(product!=null){
                totalPrice+= product.getPrice()*(1-product.getPromotion()/100.0)* item.getQuantity();
                List<Image> images = imageRepository.findAllByProductAndColor(item.getColor(), product.getId());

                result+=
                        "<tr>\n" +
                        "                                        <td class=\"product_remove\"\n" +
                        "                                            onclick=\"deleteItem(this)\"><a><i\n" +
                        "                                                class=\"fa fa-trash-o\"></i></a></td>\n" +
                        "                                        <td class=\"product_thumb\"><a href=\"#\"><img\n" +
                        "                                                style=\"width: 120px\"\n" +
                        "                                                src=\"" +
                        images.get(0).getImg().toString()+
                        "\" alt=\"\"></a></td>\n" +
                        "                                        <td class=\"product_name\"><p href=\"#\">" +
                        product.getName()+"<br><p>Phân loại: "+color.getColor_name()+" ," + item.getSize()+"</p>"+
                        "</p></td>\n" +
                        "                                        <td class=\"product-price-column\">" +
                        formatVND.format(product.getPrice()*(1-product.getPromotion()/100.0))  +
                        "</td>\n" +
                        "                                        <td class=\"product_quantity row_quantity\"><input min=\"1\" max=\"100\"\n" +
                        "                                                                            value=\"" +
                                item.getQuantity() +
                                "\" type=\"number\" name=\"quantity\"\n" +
                        "                                          onchange=\"changeQuantity(this)\" </td>\n" +
                        "                                        <td class=\"product-price product_total\">" +
                                formatVND.format(product.getPrice()*(1-product.getPromotion()/100.0)* item.getQuantity())  +
                                "                                                </td>\n" +
                                "                                    </tr>";
            }
        }
        if(result!="")
            result+= "<tr>\n"+
                    "<td style=\"border: none\"></td>\n"+
                    "<td style=\"border: none\"></td>\n"+
                    "                                    <td style=\"border: none; border-right: 1px solid #ddd\"></td>"+
                    "<td style=\"border-bottom: none\">Tổng:</td>\n"+
                    "<td style=\"border-bottom: none\">" +
                    totalQuantity+
                    "</td >\n"+
                    "                                        <td style=\"border-bottom: none\" class=\"product-price product_total\">" +
                    formatVND.format(totalPrice)  +
                    "                                                </td>\n" +
                    "                                    </tr>";

//        return result!=null ? result : "";
        return result;
    }
}
