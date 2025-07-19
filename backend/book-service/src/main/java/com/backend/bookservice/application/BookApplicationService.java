package com.backend.bookservice.application;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.domain.respository.BookRepository;
import com.backend.bookservice.web.dto.BookDto;
import com.backend.bookservice.web.mapper.BookMapper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookApplicationService {

    private final BookRepository bookRepository;

    public Page<BookDto> findAllBook(Pageable pageable) {
        Page<Book> books = bookRepository.findAll(pageable);
        return books.map(BookMapper.INSTANCE::toDto);
    }

    public BookDto findBook(String bookId) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Cannot find book with id " + bookId));
        return BookMapper.INSTANCE.toDto(book);
    }

    public BookDto createBook(@Valid BookDto bookDto) {
        Book book = BookMapper.INSTANCE.toEntity(bookDto);
        Book savedBook = bookRepository.save(book);
        return BookMapper.INSTANCE.toDto(savedBook);
    }

    public BookDto updateBook(@Valid BookDto bookDto) {
        String bookId = bookDto.getId();
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new IllegalArgumentException("Cannot find book with id " + bookId));
        book.setName(bookDto.getName());
        book.setAuthor(bookDto.getAuthor());
        book.setUpdateBy(bookDto.getUpdateBy());
        book.setUpdateDate(bookDto.getUpdateDate());
        Book updated = bookRepository.save(book);
        return BookMapper.INSTANCE.toDto(updated);
    }

    public void deleteBook(String bookId) {
        bookRepository.deleteById(bookId);
    }
}
