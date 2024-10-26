
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage(this.path, {
    super.key,
    this.hieght,
    this.width,
    this.fit = BoxFit.scaleDown,
    this.color });

  final String path;
  final BoxFit fit;
  final double? hieght;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if(path.contains("com.example.projects/cache")){
      return Image.file(File(path),
        errorBuilder: (context, error, stackTrace) => _errorWidgit(),
      color: color,
      fit: fit,
      width:  width,
      height: hieght,);
    }
    else if (path.startsWith("http")) {
      return Image.network(
          path,
          fit: fit,
          width: width,
          height: hieght,
          errorBuilder: (context, error, stackTrace) => _errorWidgit());
    } else if (path.endsWith("svg")) {
      return SvgPicture.asset(
        path,
        width: width,
        height: width,
        colorFilter: color!=null?ColorFilter.mode(
            color!, BlendMode.srcIn):null,);
    } else if (path.endsWith("png") || path.endsWith("jpg")){
      return Image.asset(
          path,
          height: hieght,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => _errorWidgit());
    }else{
      return _errorWidgit();
    }
  }


  Widget _errorWidgit(){
    return  AppImage(
      "assets/images/image_failed.png",
      hieght: hieght,
      width: width,
    );
  }
}
