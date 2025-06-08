package com.backend.bookservice.web.mapper;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.web.dto.BookDto;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring")
public interface BookMapper {
    BookMapper INSTANCE = Mappers.getMapper(BookMapper.class);

    BookDto toDto(Book book);

    Book toEntity(BookDto bookdto);

    List<BookDto> toDtoList(List<Book> books);
}
