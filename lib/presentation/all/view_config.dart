import 'package:flutter/material.dart';

class ViewConfig {
  final String language;
  final String sort;
  final bool includeVideo;
  final int initialPage;
  final bool hasLoadMore;
  final String? title;
  final String action;
  final Axis orientation;
  final Color backGround;

  ViewConfig({
    this.title,
    required this.action,
    this.language = 'en',
    this.sort = 'popularity.desc',
    this.includeVideo = false,
    this.initialPage = 1,
    this.hasLoadMore = false,
    this.orientation = Axis.horizontal,
    this.backGround=Colors.white,
  });
}

class GenerViewConfig extends ViewConfig {
  final String generId;

  GenerViewConfig({
    required this.generId,
    required String title,
    String action = 'discover/movie',
    String language = 'en',
    String sort = 'popularity.desc',
    bool includeVideo = false,
    int initialPage = 1,
    bool hasLoadMore = false,
    Axis orientation = Axis.horizontal,
  }) : super(
            title: title,
            action: action,
            language: language,
            sort: sort,
            includeVideo: includeVideo,
            initialPage: initialPage,
            hasLoadMore: hasLoadMore,
            orientation: orientation);
}
