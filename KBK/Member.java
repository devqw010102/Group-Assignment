package com.example.demo;

import lombok.*;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class Member {
    private Long id;
    private String name;
    private String email;
    private Integer age;
}