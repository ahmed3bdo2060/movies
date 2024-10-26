import 'package:app/data/dtos/model.dart';
import 'package:app/presentation/all/view.dart';
import 'package:app/presentation/all/view_config.dart';
import 'package:app/presentation/core/design/app_image.dart';
import 'package:app/presentation/core/logic/dio_helper.dart';
import 'package:app/presentation/core/logic/helper_methods.dart';
import 'package:app/presentation/movies_list_widget/bloc.dart';
import 'package:app/presentation/movies_list_widget/movies_list_widget.dart';
import 'package:app/search/bloc.dart';
import 'package:app/search/search.dart';
import 'package:app/search/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'data/dtos/gener_model.dart';
import 'presentation/all/bloc.dart';
import 'presentation/movie_item/movie_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(

        appBar: AppBar(
          title: Text("Movies App"),
          centerTitle: true,
          actions: [

        IconButton(onPressed: () {
          navigateTo(SearchPage());
    }, icon: Icon(Icons.search))],
        ),
        body: SafeArea(
          child: Column(children: [
            TabBar(
              tabs: [
                Tab(
                  child: Text("All",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text("Now Playing",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text("Popular",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text("Top Rated",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text("Upcoming",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                )
              ],
              dividerColor: Colors.transparent,
              dividerHeight: 0,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.black.withOpacity(.8),
                  shape: BoxShape.rectangle),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: TabBarView(children: [
                AllView(),
                MoviesListWidget(
                    config: ViewConfig(action: 'movie/now_playing',orientation: Axis.vertical,hasLoadMore: false,backGround: Colors.white)),
                MoviesListWidget(config: ViewConfig(action: "movie/popular",orientation: Axis.vertical,backGround: Colors.white)),
                MoviesListWidget(config: ViewConfig(action: 'movie/top_rated',orientation: Axis.vertical,backGround: Colors.white)),
                MoviesListWidget(config: ViewConfig(action: "movie/upcoming",orientation: Axis.vertical,backGround: Colors.white)),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.model});

  final MovieModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 400,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: AppImage(
                    "https://image.tmdb.org/t/p/original${model.posterPath}",
                    fit: BoxFit.cover,
                    width: double.infinity)),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.9),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(model.originalTitle,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade,
                      ),
                      textAlign: TextAlign.center),
                ),
                width: double.infinity,
                padding: EdgeInsets.only(top: 8, bottom: 8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
 

