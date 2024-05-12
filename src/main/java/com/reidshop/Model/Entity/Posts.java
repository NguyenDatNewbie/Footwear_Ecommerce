package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.PostType;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Entity
@Data
public class Posts {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "post_id")
    Long id;

    @ManyToOne
    @JoinColumn(name = "author_id")
    Account account;
    String title;
    @Lob
    @Column(columnDefinition="TEXT",name = "short_content")
    String shortContent;

    @Lob
    @Column(columnDefinition="TEXT",name = "full_content")
    String fullContent;

    String image;
    @Enumerated(EnumType.STRING)
    PostType postType;

    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    @Column
    Date createdAt;

    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    @Column
    Date updateAt;
}
