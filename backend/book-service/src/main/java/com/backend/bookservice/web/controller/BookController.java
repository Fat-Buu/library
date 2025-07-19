package com.backend.bookservice.web.controller;

import com.backend.bookservice.application.BookApplicationService;
import com.backend.bookservice.web.dto.BookDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/v1/book")
@RequiredArgsConstructor
public class BookController {

    private final BookApplicationService bookApplicationService;

    @GetMapping
    @ResponseStatus(value = HttpStatus.OK)
    public Page<BookDto> findAllBook(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page > 0 ? page - 1 : 0, size);
        return bookApplicationService.findAllBook(pageable);
    }

    @GetMapping("/{bookId}")
    @ResponseStatus(value = HttpStatus.OK)
    public BookDto findBook(@PathVariable String bookId) {
        return bookApplicationService.findBook(bookId);
    }

    @PostMapping()
    @ResponseStatus(value = HttpStatus.CREATED)
    public BookDto createBook(@RequestBody @Valid BookDto bookDto) {
        return bookApplicationService.createBook(bookDto);
    }

    @PutMapping()
    @ResponseStatus(value = HttpStatus.OK)
    public BookDto updateBook(@RequestBody @Valid BookDto bookDto) {
        return bookApplicationService.updateBook(bookDto);
    }

    @DeleteMapping("/{bookId}")
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void deleteBook(@PathVariable String bookId) {
        bookApplicationService.deleteBook(bookId);
    }


}
