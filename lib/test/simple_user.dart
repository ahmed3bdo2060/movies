import 'package:app/presentation/core/design/app_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'profile_builder.dart';

class SimpleUserProfileBuilder implements UserProfileBuilder {
  String _name = '';
  int _age = 0;
  String _email = '';
  String _image = '';

  @override
  void setName(String name) {
    _name = name;
  }

  @override
  void setAge(int age) {
    _age = age;
  }

  @override
  void setEmail(String email) {
    _email = email;
  }
  @override
  void setImage(String image) {
    _image = image;
  }

  @override
  Widget build() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 250,
      width: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "https://th.bing.com/th/id/R.f48ceff9ab3322d4e84ed12a44c484d1?rik=0KQ6OgL4T%2b9uCA&riu=http%3a%2f%2fwww.photo-paysage.com%2falbums%2fuserpics%2f10001%2fCascade_-15.JPG&ehk=kx1JjE9ugj%2bZvUIrjzSmcnslPc7NE1cOnZdra%2f3pJEM%3d&risl=1&pid=ImgRaw&r=0",
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(child: Container(
                height: 250.h,
                color: Color(0xffF5F5F5),
                width: 200.w,
              ), baseColor: Color(0xffE0DDDC),
                  highlightColor: Color(0xffF5F5F5))
              ,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // AppImage(
            //   "https://image.tmdb.org/t/p/original${model.posterPath}",
            //   fit: BoxFit.cover,
            // ),
          ),
          Positioned(
              height: 60,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r))),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.white)),
                ),
              ))
        ],
      ),
    );
  }

 
}