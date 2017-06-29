package com.kantiana.skb.validator;

import com.kantiana.skb.model.User;
import com.kantiana.skb.service.SecurityService;
import com.kantiana.skb.service.UserService;
import org.hibernate.validator.internal.constraintvalidators.hv.EmailValidator;
import org.hibernate.validator.internal.constraintvalidators.hv.URLValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class UserValidatorImpl implements UserValidator {
    @Autowired
    private UserService userService;
    @Autowired
    private SecurityService securityService;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void validateRegistration(User user, Errors errors) {
        validateFullName(errors);
        validateUsername(user, errors);
        validatePassword(user, errors);
        validateEmail(user, errors);
        // Проверка организации
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "organization", "NotEmpty");
    }

    @Override
    public void validateChange(User user, Errors errors) {
        validateFullName(errors);
        if (!securityService.findLoggedInUsername().equals(user.getUsername())) {
            validateUsername(user, errors);
        }
        validateEmail(user, errors);
        if (user.getDateOfBirth() != null) {
            validateDateOfBirth(user, errors);
        }
        validateGithub(user, errors);
        // Проверка организации
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "organization", "NotEmpty");
    }

    @Override
    public void validatePasswordChange(String currentPassword, String newPassword, String newPasswordConfirm, Map<String, String> errors) {
        String correctCurrentPassword = securityService.findLoggedUser().getPassword();
        if (!bCryptPasswordEncoder.matches(currentPassword, correctCurrentPassword)) {
            errors.put("uncorrectPassword", "Password.uncorrect");
        }
        if (newPassword.length() < 2 || newPassword.length() > 32) {
            errors.put("uncorrectNewPasswordSize", "Size.user.password");
        }
        if (!newPasswordConfirm.equals(newPassword)) {
            errors.put("uncorrectNewPasswordConfirm", "Diff.user.passwordConfirm");
        }
    }

    private void validateFullName(Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "middleName", "NotEmpty");
    }

    private void validateUsername(User user, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "NotEmpty");
        if (user.getUsername().length() < 2 || user.getUsername().length() > 32) {
            errors.rejectValue("username", "Size.user.username");
        }
        if (userService.findByUsername(user.getUsername()) != null) {
            errors.rejectValue("username", "Duplicate.user.username");
        }
    }

    private void validatePassword(User user, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
        if (user.getPassword().length() < 2 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.user.password");
        }
        if (!user.getPasswordConfirm().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirm", "Diff.user.passwordConfirm");
        }
    }

    private void validateEmail(User user, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");
        EmailValidator emailValidator = new EmailValidator();
        if (!emailValidator.isValid(user.getEmail(), null)) {
            errors.rejectValue("email", "NotValid.email");
        }
    }

    private void validateDateOfBirth(User user, Errors errors) {
        Date today = new Date(System.currentTimeMillis());
        if (user.getDateOfBirth().compareTo(today) > 0) {
            errors.rejectValue("dateOfBirth", "NotValid.date.greaterThanToday");
        }
    }

    private void validateGithub(User user, Errors errors) {
        URLValidator urlValidator = new URLValidator();
        if (!urlValidator.isValid(user.getGithub(), null)) {
            errors.rejectValue("github", "NotValid.link");
        }
    }
}
