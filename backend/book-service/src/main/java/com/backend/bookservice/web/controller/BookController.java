package com.backend.bookservice.web.controller;

import com.backend.bookservice.application.BookApplicationService;
import com.backend.bookservice.web.dto.BookDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/v1/book")
@RequiredArgsConstructor
@Log4j2
public class BookController {

    private final BookApplicationService bookApplicationService;

    @GetMapping
    @ResponseStatus(value = HttpStatus.OK)
    public Page<BookDto> findAllBook(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size) {
        log.info("Controller findAllBook");
        Pageable pageable = PageRequest.of(page > 0 ? page - 1 : 0, size);
        return bookApplicationService.findAllBook(pageable);
    }

    @GetMapping("/{bookId}")
    @ResponseStatus(value = HttpStatus.OK)
    public BookDto findBook(@PathVariable String bookId) {
        log.info("Controller findBook with id {}", bookId);
        return bookApplicationService.findBook(bookId);
    }

    @PostMapping()
    @ResponseStatus(value = HttpStatus.CREATED)
    public BookDto createBook(@RequestBody @Valid BookDto bookDto) {
        log.info("create book with {}", bookDto);
        return bookApplicationService.createBook(bookDto);
    }

    @PutMapping()
    @ResponseStatus(value = HttpStatus.OK)
    public BookDto updateBook(@RequestBody @Valid BookDto bookDto) {
        log.info("Controller update book with {}", bookDto);
        return bookApplicationService.updateBook(bookDto);
    }

    @DeleteMapping("/{bookId}")
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void deleteBook(@PathVariable String bookId) {
        log.info("Controller delete book with id {}", bookId);
        bookApplicationService.deleteBook(bookId);
    }


}
