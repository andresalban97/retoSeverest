package com.severestApp.utils;

import java.security.SecureRandom;

import net.datafaker.Faker;

public class DataGenerate {
    
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final SecureRandom random = new SecureRandom();
    
    public static String generateEmail(){
        Faker faker = new Faker();
        String email = generateName() + generateLastName() + faker.random().nextInt(0, 100) + "@tester.com";
        return email;
    }

    public static String generatePassword(){
        Faker faker = new Faker();
        String password =  faker.internet().password(8, 16, true, true, true);
        return password;
    }

    public static String generateName(){
        Faker faker = new Faker();
        String name = faker.name().firstName();
        return name;
    }

    public static String generateLastName(){
        Faker faker = new Faker();
        String lastname = faker.name().lastName();
        return lastname;
    }  
    
    public static int generateRandomNumberInt(int lenthArray){
        Faker faker = new Faker();
        if(lenthArray>2){
            int numberRandom = faker.number().numberBetween(0, lenthArray - 1);
            return numberRandom;
        } else if (lenthArray==1){
            return 0;

        } else {
            return -1;
        }
        
    }
    public static String getRandomisAdministrator(){
        Faker faker = new Faker();
        boolean randomBool = faker.bool().bool();
        String adminAsString = String.valueOf(randomBool);
        return adminAsString;

    }
    

    public static String generateRandomId(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }

    
}
