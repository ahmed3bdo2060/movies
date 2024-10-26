import 'package:app/presentation/all/view_config.dart';
import 'package:app/presentation/movies_list_widget/movies_list_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/dtos/model.dart';
import '../core/design/app_image.dart';
import 'movie_details_item.dart';

class MoviesDetails extends StatefulWidget {
  final MovieModel model;

  const MoviesDetails({super.key, required this.model});

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Container(
            child: Text(widget.model.originalTitle,
                style: TextStyle(color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                )),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [ Expanded(
              child: Stack(fit: StackFit.expand,
                children: [ Stack(fit: StackFit.loose,children: [
                  CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: "https://image.tmdb.org/t/p/original${widget.model.posterPath}",
                    fit: BoxFit.cover,
                    width: double.infinity.w,
                    height: 300.h,
                    placeholder: (context, url) => Shimmer.fromColors(child: Container(
                      height: 300.h,
                      color: Color(0xffF5F5F5),
                      width: double.infinity.w,
                    ), baseColor: Color(0xffE0DDDC),
                        highlightColor: Color(0xffF5F5F5))
                    ,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // AppImage(
                  //   "https://image.tmdb.org/t/p/original${widget.model.backdropPath}",
                  //   hieght: 300.h,width: double.infinity.w,fit: BoxFit.cover,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                    top: 207.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 0.h),
                    child: item(model: widget.model)
                  ),
                ]),
              ]),
            ),
        ]),
        )

        );
  }
}


