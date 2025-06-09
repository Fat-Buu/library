package com.backend.bookservice.web.controller;

import com.backend.bookservice.application.BookApplicationService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(BookController.class)
class BookControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private BookApplicationService bookApplicationService;


    @Test
    void testFindBook() throws Exception {
        Pageable pageable = PageRequest.of(0, 10);
        when(bookApplicationService.findAllBook(pageable)).thenReturn(Page.empty());
        mockMvc.perform(get("/v1/book")).andExpect(status().isOk());
    }
}
