package com.backend.bookservice.application;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.domain.respository.BookRepository;
import com.backend.bookservice.web.dto.BookDto;
import com.backend.bookservice.web.mapper.BookMapper;
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

}
