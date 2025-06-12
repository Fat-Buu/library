package com.backend.userservice.interfaces.web.controller;

import com.backend.userservice.infrastructure.security.JwtUtil;
import com.backend.userservice.interfaces.web.dto.request.UserLoginRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/v1/auth")
@RequiredArgsConstructor
@Log4j2
public class AuthController {

    private final JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody UserLoginRequest userLogin) {
        String token = jwtUtil.generateToken(userLogin.getUserName());
        return ResponseEntity.ok(token);
    }

    @GetMapping("/current-user")
    public ResponseEntity<Object> getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return ResponseEntity.ok(auth);
    }
}
