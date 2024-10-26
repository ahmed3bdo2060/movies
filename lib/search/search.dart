

import 'package:app/data/dtos/model.dart';
import 'package:app/presentation/core/logic/dio_helper.dart';
import 'package:app/search/bloc.dart';
import 'package:app/search/events.dart';
import 'package:app/search/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../presentation/movie_item/movie_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = GetIt.instance<SearchBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search For Amovie",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is SuccessSearchState) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: bloc.controller,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (value) {
                        bloc.add(SearchEventUpdate(word: bloc.controller.text));
                      },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            bloc.add(DeleteSearchEvent(word: bloc.controller.text, list: bloc.list));
                          }, icon: Icon(Icons.close)),
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 16.h),
                      itemBuilder: (context, index) => MovieItem(
                        model: bloc.list.isEmpty?state.movies[index]:bloc.list[index],
                      ),
                      itemCount: bloc.list.length==0?state.movies.length:bloc.list.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    ),
                  )
                ],
              ),
            );
          } else if (state is FailedSearchState) {
            return Text("failed");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
