package com.backend.userservice.application.service;

import com.backend.userservice.application.mapper.UserMapper;
import com.backend.userservice.domain.model.User;
import com.backend.userservice.domain.repository.UserRepository;
import com.backend.userservice.interfaces.web.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserApplicationService {

    private final UserRepository userRepository;

    public Page<UserDto> getAllUsers(Pageable pageable) {
        Page<User> pages = userRepository.findAll(pageable);
        return pages.map(UserMapper.INSTANCE::toDto);
    }
}
