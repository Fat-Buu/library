package com.backend.bookservice.web.controller;

import com.backend.bookservice.domain.model.Book;
import com.backend.bookservice.domain.respository.BookRepository;
import com.backend.bookservice.web.dto.BookDto;
import com.backend.bookservice.web.mapper.BookMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoSpyBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.mockito.ArgumentMatchers.any;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
class BookControllerTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    @Autowired
    BookRepository bookRepository;
    //    @MockitoBean
//    private BookApplicationService bookApplicationService;
    @MockitoSpyBean
    BookRepository bookRepositorySpyBean;
    @Autowired
    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        bookRepository.deleteAll(); // Ensure a clean database for each test
    }

    @Test
    void testFindAllBook() throws Exception {
        // Step 1: Save book in DB
        Book book = new Book();
        book.setName("Book Name 1");
        bookRepository.save(book);

        mockMvc.perform(get("/v1/book"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalElements").value(1));
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1)).findAll(PageRequest.of(0, 10));
    }

    @Test
    void testFindBook() throws Exception {
        // Step 1: Save book in DB
        Book book = new Book();
        book.setName("Book Name 1");
        bookRepository.save(book);
        // Step 2: Fetch book
        mockMvc.perform(get("/v1/book/" + book.getId()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("Book Name 1"));
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1)).findById(book.getId());
    }

    @Test
    void testCreateBook() throws Exception {
        // Step 1: Create Book
        BookDto bookDto = new BookDto();
        bookDto.setName("Book Name 1");
        MvcResult result = mockMvc.perform(post("/v1/book")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(bookDto)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Book Name 1"))
                .andReturn();
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1))
                .save(any());

        BookDto createdBook = objectMapper.readValue(result.getResponse().getContentAsString(), BookDto.class);
        String bookId = createdBook.getId();

        // Step 2: Check Book Exists in DB
        Assertions.assertTrue(bookRepository.findById(bookId).isPresent());

    }

    @Test
    void testUpdateBook() throws Exception {
        // Step 1: Save book in DB
        Book book = new Book();
        book.setName("Book Name 1");
        bookRepository.save(book);
        Mockito.clearInvocations(bookRepositorySpyBean);

        // Step 2: Update Book
        BookDto bookDto = BookMapper.INSTANCE.toDto(book);
        bookDto.setName("Updated Book Name 1");
        MvcResult result = mockMvc.perform(put("/v1/book")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(bookDto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("Updated Book Name 1"))
                .andReturn();
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1))
                .findById(bookDto.getId());
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1))
                .save(any());

        BookDto updatedBook = objectMapper.readValue(result.getResponse().getContentAsString(), BookDto.class);
        String bookId = updatedBook.getId();

        // Step 3: Check Book Exists in DB
        Assertions.assertTrue(bookRepository.findById(bookId).isPresent());
        Assertions.assertEquals("Updated Book Name 1", bookRepository.findById(bookId).get().getName());

    }

    @Test
    void testDeleteBook() throws Exception {
        // Step 1: Save book in DB
        Book book = new Book();
        book.setName("Book Name 1");
        bookRepository.save(book);

        // Step 2: Delete Book
        mockMvc.perform(delete("/v1/book/" + book.getId()))
                .andExpect(status().isNoContent());
        Mockito.verify(bookRepositorySpyBean, Mockito.times(1))
                .deleteById(book.getId());

        // Step 3: Check Book Exists in DB
        Assertions.assertFalse(bookRepository.findById(book.getId()).isPresent());
    }
}
