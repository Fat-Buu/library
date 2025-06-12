package com.backend.userservice.application.mapper;

import com.backend.userservice.domain.model.User;
import com.backend.userservice.interfaces.web.dto.UserDto;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    UserDto toDto(User user);
}
