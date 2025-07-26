package com.backend.bookservice.application;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.domain.respository.BookRepository;
import com.backend.bookservice.web.dto.BookDto;
import com.backend.bookservice.web.mapper.BookMapper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookApplicationService {

    public static final String BOOK_CACHE = "books";
    private final BookRepository bookRepository;

    public Page<BookDto> findAllBook(Pageable pageable) {
        log.info("Controller findAllBook");
        Page<Book> books = bookRepository.findAll(pageable);
        return books.map(BookMapper.INSTANCE::toDto);
    }

    @Cacheable(value = BOOK_CACHE, key = "#bookId")
    public BookDto findBook(String bookId) {
        log.info("Service findBook with id {}", bookId);
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Cannot find book with id " + bookId));
        return BookMapper.INSTANCE.toDto(book);
    }

    @Cacheable(value = BOOK_CACHE, key = "#bookDto.id()")
    public BookDto createBook(@Valid BookDto bookDto) {
        log.info("Service createBook with {}", bookDto);
        Book book = BookMapper.INSTANCE.toEntity(bookDto);
        Book savedBook = bookRepository.save(book);
        return BookMapper.INSTANCE.toDto(savedBook);
    }

    @CachePut(value = BOOK_CACHE, key = "#bookDto.id()")
    public BookDto updateBook(@Valid BookDto bookDto) {
        log.info("Service updateBook with {}", bookDto);
        String bookId = bookDto.getId();
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Cannot find book with id " + bookId));
        book.setName(bookDto.getName());
        book.setAuthor(bookDto.getAuthor());
        book.setUpdateBy(bookDto.getUpdateBy());
        book.setUpdateDate(bookDto.getUpdateDate());
        Book updated = bookRepository.save(book);
        return BookMapper.INSTANCE.toDto(updated);
    }

    @CacheEvict(value = BOOK_CACHE, key = "#bookId")
    public void deleteBook(String bookId) {
        log.info("Service delete with {}", bookId);
        bookRepository.deleteById(bookId);
    }
}
