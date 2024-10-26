import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_builder.dart';

class UserProfileScreen extends StatelessWidget {
  final UserProfileBuilder builder;

  UserProfileScreen({required this.builder});

  @override
  Widget build(BuildContext context) {
    builder.setName('John Doe');
    builder.setAge(30);
    builder.setEmail('john.doe@example.com');

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 250,
          child: ListView.separated(itemBuilder:(context, index) => builder.build() ,
              separatorBuilder: (context, index) => SizedBox(width: 8.w), itemCount: 8,scrollDirection: Axis.horizontal),
        ),
      ),
    );
  }
}