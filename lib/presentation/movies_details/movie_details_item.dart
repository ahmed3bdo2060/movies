import 'package:app/presentation/all/view_config.dart';
import 'package:app/presentation/movies_list_widget/movies_list_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/dtos/model.dart';
import '../core/design/app_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class item extends StatefulWidget {
  const item({super.key, required this.model});
  final MovieModel model;
  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: "https://image.tmdb.org/t/p/original${widget.model.posterPath}",
                  fit: BoxFit.cover,
                  width: 150.w,
                  height: 200.h,
                  placeholder: (context, url) => Shimmer.fromColors(child: Container(
                    height: 200.h,
                    color: Color(0xffF5F5F5),
                    width: 150.w,
                  ), baseColor: Color(0xffE0DDDC),
                      highlightColor: Color(0xffF5F5F5))
                  ,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // AppImage( "https://image.tmdb.org/t/p/original${widget.model.posterPath==null?widget.model.backdropPath:widget.model.posterPath}",
                //   hieght: 200.h,width: 150.w,fit: BoxFit.cover,),
                SizedBox(width: 16.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 8.w,left: 8.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2.w),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.r),),
                      child: Text("Title",style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 8.h,),
                    Container(
                      width: 145.w,
                      child: Text(widget.model.title,maxLines: 2,style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                      ),),
                    ),
                  ],
                )
              ]),
            SizedBox(height: 16.h,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(.4),
                        width: 1.w),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text("popularity : ${widget.model.popularity}",
                      style:TextStyle(
                        color: Colors.black.withOpacity(.4),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ) ),
                ),
                SizedBox(width: 8.w,),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(.4),
                        width: 1.w),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text("releaseDate : ${widget.model.releaseDate}",
                      style:TextStyle(
                        color: Colors.black.withOpacity(.4),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ) ),
                ),
              ],
            ),
            SizedBox(height: 4.h,),
        Align(
          alignment: AlignmentDirectional.center,
          child: RatingBar.builder(
            initialRating:widget.model.voteAverage,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 1,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              rating =widget.model.voteCount.toDouble();
            },
          ),
        ),
            SizedBox(height: 4,),
            Align(alignment: AlignmentDirectional.center
            ,child: Text("${widget.model.voteAverage.toStringAsFixed(1)}",
                  style:TextStyle(
                    fontWeight: FontWeight.bold
                  ) ,)),
            SizedBox(height: 4,),
            Container(
              padding: EdgeInsets.only(left: 8.w,right: 8.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 2.w),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text("Film Over View",
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ) ),
            ),
            SizedBox(height: 8.h,),
            Text(widget.model.overview,
                style:TextStyle(
                    color: Colors.black
                ) ),
            SizedBox(height: 16.h,),
            SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8.w,left: 8.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2.w),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("Simillar Movies ",
                        style:TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ) ),
                  ),
                  SizedBox(height: 16.h,),
                  SizedBox(height: 250,child: MoviesListWidget(config: ViewConfig(action: "movie/${widget.model.id}/similar",orientation: Axis.horizontal,title: widget.model.title)))
                ],
              ),
            )
          ]),
    );
  }
}
