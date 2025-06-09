package com.backend.bookservice.web.mapper;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.web.dto.BookDto;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class BookMapperTests {

    private final BookMapper mapper = Mappers.getMapper(BookMapper.class);

    @Test
    void testToDto() {
        Book book = new Book();
        book.setName("One Piece");
        BookDto dto = mapper.toDto(book);
        assertEquals("One Piece", dto.getName());
    }
}
