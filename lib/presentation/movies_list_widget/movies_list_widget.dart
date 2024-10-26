import 'package:app/presentation/all/view_config.dart';
import 'package:app/presentation/core/logic/dio_helper.dart';
import 'package:app/presentation/movie_item/movie_item.dart';
import 'package:app/presentation/movies_list_widget/events.dart';
import 'package:app/presentation/movies_list_widget/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'bloc.dart';

class MoviesListWidget extends StatefulWidget {
  const MoviesListWidget({super.key, required this.config});
  final ViewConfig config;
  @override
  State<MoviesListWidget> createState() => _MoviesListWidgetState();
}

class _MoviesListWidgetState extends State<MoviesListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesListBloc>(
      create: (context) =>
          MoviesListBloc(GetIt.instance<DioHelper>(), widget.config),
      child: BlocConsumer<MoviesListBloc, MoviesListState>(
        listener: (BuildContext context, MoviesListState state) {},
        builder: (BuildContext context, MoviesListState state) {
          if (state is SuccessState) {
            return widget.config.orientation==Axis.horizontal?ListView.builder(
              itemBuilder: (context, index) => MovieItem(
                model: state.movies.elementAt(index),
              ),
              itemCount: state.movies.length,
              scrollDirection: widget.config.orientation,
            ):Container(
              color: widget.config.backGround,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                    MoviesListBloc bloc = BlocProvider.of(context);
                    if(widget.config.hasLoadMore==true) {
                      bloc.add(FetchDataLoadMore());
                    }
                  }
                  return true;
                },
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 8.w,mainAxisSpacing: 16.h),
                    itemBuilder: (context, index) => MovieItem(
                      model: state.movies.elementAt(index),
                    ),itemCount: state.movies.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),),
              ),
            );
          } else if (state is LoadingState) {
            return VisibilityDetector(
                onVisibilityChanged: (info) {
                  var visiblePercentage = info.visibleFraction * 100;
                  if (visiblePercentage > 0) {
                    context.read<MoviesListBloc>().add(FetchData());
                  }
                },
                key: GlobalKey(),
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
