package com.backend.userservice.interfaces.web.controller;

import com.backend.userservice.application.service.AuthApplicationService;
import com.backend.userservice.infrastructure.security.JwtUtil;
import com.backend.userservice.interfaces.web.dto.request.AuthRequest;
import com.backend.userservice.interfaces.web.dto.request.RefreshTokenRequest;
import com.backend.userservice.interfaces.web.dto.response.RefreshTokenResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.HttpStatus;
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
    public ResponseEntity<String> login(@RequestBody AuthRequest authRequest) throws BadCredentialsException {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authRequest.getUserName(), authRequest.getPassword()));
        } catch (BadCredentialsException e) {
            throw new BadCredentialsException("Incorrect username or password", e);
        }
        log.info("login username: " + authRequest.getUserName());
        UserDetails userDetails = authApplicationService.loadUserByUsername(authRequest.getUserName());
        String token = jwtUtil.generateToken(userDetails);
        return ResponseEntity.ok(token);
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String authHeader) {
        if (authHeader != null && authHeader.contains("Bearer ")) {
            String token = authHeader.substring(7);
            jwtUtil.backListToken(token);
            return ResponseEntity.ok("Logged out successfully.");
        }
        return ResponseEntity.badRequest().body("No token provided.");
    }

    @PostMapping("/refresh")
    public ResponseEntity<?> refresh(@RequestBody RefreshTokenRequest refreshTokenRequest) throws Exception {
        String refreshToken = refreshTokenRequest.getRefreshToken();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (Strings.isBlank(auth.getName())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid refresh token.");
        }
        log.info("refresh username: " + auth.getName());
        log.info("refresh refreshToken: " + refreshToken);
        String newAccessToken = jwtUtil.refreshToken(refreshToken, auth.getName());
        return ResponseEntity.ok().body(new RefreshTokenResponse(newAccessToken, refreshToken));
    }

    @GetMapping("/current-user")
    public ResponseEntity<Object> getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return ResponseEntity.ok(auth);
    }
}
