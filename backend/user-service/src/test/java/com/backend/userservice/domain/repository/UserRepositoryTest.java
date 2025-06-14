package com.backend.userservice.domain.repository;

import com.backend.userservice.domain.model.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class UserRepositoryTest {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TestEntityManager entityManager;

    @Test
    void whenFindByFirstName_thenReturnUser() {
        // given
        User user = new User();
        user.setId("1");
        user.setFirstName("John");
        entityManager.persistFlushFind(user);

        // when
        Optional<User> found = userRepository.findByFirstName("John");

        //then
        assertThat(found).isPresent();
        assertThat(found.get().getUserName()).isEqualTo(user.getUserName());
        assertThat(found.get().getId()).isEqualTo(user.getId());
    }
}
