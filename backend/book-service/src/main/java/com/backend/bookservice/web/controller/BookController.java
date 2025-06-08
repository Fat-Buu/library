package com.backend.bookservice.web.controller;

import com.backend.bookservice.application.BookApplicationService;
import com.backend.bookservice.web.dto.BookDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/v1/book")
@RequiredArgsConstructor
public class BookController {

    private final BookApplicationService bookApplicationService;

    @GetMapping
    public ResponseEntity<List<BookDto>> getAllBook() {
        return ResponseEntity.ok(bookApplicationService.getAllBook());
    }
}
