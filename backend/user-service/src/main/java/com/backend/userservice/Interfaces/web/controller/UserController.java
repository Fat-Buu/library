package com.backend.userservice.interfaces.web.controller;

import com.backend.userservice.application.service.UserApplicationService;
import com.backend.userservice.interfaces.web.dto.UserDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/users")
@Log4j2
@RequiredArgsConstructor
public class UserController {
    private final UserApplicationService userApplicationService;

    @GetMapping()
    public ResponseEntity<Page<UserDto>> getAllUsers() {
        Pageable pageable = PageRequest.of(0, 5);
        Page<UserDto> user = userApplicationService.getAllUsers(pageable);
        user.forEach(userDto -> log.info(userDto.toString()));
        return ResponseEntity.ok(user);
    }
}
