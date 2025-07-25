package com.backend.userservice.infrastructure.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtUtil {
    private final String TOKEN_HEADER = "Authorization";
    private final String TOKEN_PREFIX = "Bearer ";
    private final SecretKey secretKey = Keys.hmacShaKeyFor("my-secret-key-12345-678910-1112131415".getBytes(StandardCharsets.UTF_8));

    @Autowired
    private TokenBackListService tokenBackListService;

    public String generateToken(UserDetails userDetails) {
        return Jwts.builder().subject(userDetails.getUsername()).issuedAt(new Date()).expiration(new Date(System.currentTimeMillis() + 1000 * 60 * 5)).signWith(secretKey).compact();
    }

    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader(TOKEN_HEADER);
        if (null != bearerToken && bearerToken.startsWith(TOKEN_PREFIX)) {
            return bearerToken.substring(TOKEN_PREFIX.length());
        }
        return null;
    }

    public Claims resolveClaims(HttpServletRequest request) {
        try {
            String token = resolveToken(request);
            if (null != token) {
                return parseJwtClaims(token);
            }
            return null;
        } catch (ExpiredJwtException ex) {
            request.setAttribute("expired", ex.getMessage());
            throw ex;
        } catch (Exception ex) {
            request.setAttribute("invalid", ex.getMessage());
            throw ex;
        }
    }

    private Claims parseJwtClaims(String token) {
        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload();
    }

    public String refreshToken(String refreshToken, String username) {
        String token = Jwts.builder().subject(username).issuedAt(new Date()).expiration(new Date(System.currentTimeMillis() + 1000 * 60 * 5)).signWith(secretKey).compact();
        backListToken(refreshToken);
        return token;
    }

    public void backListToken(String token) {
        tokenBackListService.backListToken(token);
    }

    public boolean isBackListed(String token) {
        return tokenBackListService.isBackListed(token);
    }
}
