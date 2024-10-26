import 'package:flutter/material.dart';

abstract class UserProfileBuilder {
  void setName(String name);
  void setAge(int age);
  void setEmail(String email);
  void setImage(String image);
  Widget build();
}