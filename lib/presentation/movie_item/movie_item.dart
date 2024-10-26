import 'package:app/presentation/core/logic/helper_methods.dart';
import 'package:app/presentation/movies_details/view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/dtos/model.dart';
import '../core/design/app_image.dart';

class MovieItem extends StatelessWidget {
  final MovieModel model;

  const MovieItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(MoviesDetails(model: model,));
      },
      child: Container(
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
                imageUrl: "https://image.tmdb.org/t/p/original${model.posterPath}",
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
                    child: Text(model.originalTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.white)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
