package com.backend.userservice.Interfaces.web.controller;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

@RestController
@RequestMapping("/v1/users")
public class UserController {
    @GetMapping()
    public ResponseEntity<Page<Objects>> getAllUsers() {
        return ResponseEntity.ok(Page.empty());
    }
}
