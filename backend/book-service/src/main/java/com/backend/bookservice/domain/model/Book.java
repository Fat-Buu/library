package com.backend.bookservice.domain.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    private String name;
    private String author;
    @Column(name = "create_date")
    private LocalDateTime createDate;
    @Column(name = "create_by")
    private String createBy;
    @Column(name = "update_date")
    private LocalDateTime updateDate;
    @Column(name = "update_by")
    private String updateBy;

}
