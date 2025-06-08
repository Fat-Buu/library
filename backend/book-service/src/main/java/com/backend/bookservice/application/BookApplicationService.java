package com.backend.bookservice.application;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.domain.respository.BookRepository;
import com.backend.bookservice.web.dto.BookDto;
import com.backend.bookservice.web.mapper.BookMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookApplicationService {

    private final BookRepository bookRepository;

    public List<BookDto> getAllBook() {
        List<Book> books = bookRepository.findAll();
        return BookMapper.INSTANCE.toDtoList(books);
    }

}
