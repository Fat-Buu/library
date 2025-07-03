package com.backend.userservice.infrastructure.security;

import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class TokenBackListService {
    private final Set<String> backList = ConcurrentHashMap.newKeySet();

    public void backListToken(String token) {
        backList.add(token);
    }

    public boolean isBackListed(String token) {
        return backList.contains(token);
    }
}
