import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../presentation/movie_item/movie_item.dart';
import 'aa.dart';

class SearchPage1 extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage1> {
  TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMovies();
                  },
                ),
              ),
              onSubmitted: (query) {
                _searchMovies();
              },
            ),
            Expanded(
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 16.h),
                itemBuilder: (context, index) {
                  final movie = _searchResults[index];
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
                            imageUrl: "https://image.tmdb.org/t/p/original${movie['poster_path']}",
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
                                child: Text(movie["title"],
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
                },
                itemCount:_searchResults.length,
                padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              ),
              // ListView.builder(
              //   itemCount: _searchResults.length,
              //   itemBuilder: (context, index) {
              //     final movie = _searchResults[index];
              //     return ListTile(
              //       title: Text(movie['title']),
              //       subtitle: Text(movie['overview'] ?? ''),
              //       leading: movie['poster_path'] != null
              //           ? Image.network(
              //         'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
              //         width: 50,
              //       )
              //           : SizedBox(
              //         width: 50,
              //         child: Icon(Icons.movie),
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchMovies() async {
    try {
      final results = await searchMovies(_controller.text);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Error searching movies: $e');
      // Handle error
    }
  }
}