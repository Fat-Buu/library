package com.backend.userservice.interfaces.web.controller;

import com.backend.userservice.application.service.AuthApplicationService;
import com.backend.userservice.infrastructure.security.JwtUtil;
import com.backend.userservice.interfaces.web.dto.request.AuthRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/v1/auth")
@RequiredArgsConstructor
@Log4j2
public class AuthController {

    private final JwtUtil jwtUtil;
    private final AuthApplicationService authApplicationService;
    private final AuthenticationManager authenticationManager;

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody AuthRequest authRequest) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authRequest.getUserName(), authRequest.getPassword()));
        } catch (BadCredentialsException e) {
            throw new Exception("Incorrect username or password", e);
        }
        UserDetails userDetails = authApplicationService.loadUserByUsername(authRequest.getUserName());
        String token = jwtUtil.generateToken(userDetails);
        return ResponseEntity.ok(token);
    }

    @GetMapping("/current-user")
    public ResponseEntity<Object> getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return ResponseEntity.ok(auth);
    }
}
