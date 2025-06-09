package com.backend.bookservice.web.controller;

import com.backend.bookservice.application.BookApplicationService;
import com.backend.bookservice.web.dto.BookDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/book")
@RequiredArgsConstructor
public class BookController {

    private final BookApplicationService bookApplicationService;

    @GetMapping
    public Page<BookDto> findAllBook(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page > 0 ? page - 1 : 0, size);
        return bookApplicationService.findAllBook(pageable);
    }
}
