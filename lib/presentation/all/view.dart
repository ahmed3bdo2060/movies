import 'package:app/data/dtos/gener_model.dart';
import 'package:app/presentation/all/view_config.dart';
import 'package:app/presentation/core/logic/helper_methods.dart';
import 'package:app/presentation/movies_list_widget/bloc.dart';
import 'package:app/presentation/movies_list_widget/events.dart';
import 'package:app/presentation/movies_list_widget/movies_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../data/dtos/model.dart';
import '../core/design/app_image.dart';
import '../movies_details/view.dart';
import 'bloc.dart';

class AllView extends StatefulWidget {
  const AllView({super.key});

  @override
  State<AllView> createState() => _AllViewState();
}

class _AllViewState extends State<AllView> {
  final bloc = GetIt.I<GenerBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is FailState) {
                return Text(state.msg);
              } else if (state is SuccessState) {
                return SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          state.model.length,
                          (index) => GenerItem(
                                gener: state.model[index],
                              ))),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}

class GenerItem extends StatelessWidget {
  final GenerModel gener;

  const GenerItem({
    super.key,
    required this.gener,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(children: [
              Text(gener.name,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton.icon(
                onPressed: () {
                  navigateTo(SafeArea(
                      child: Scaffold(
                    appBar: AppBar(
                        title: Text(
                          gener.name,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true),
                    body: MoviesListWidget(
                        config: GenerViewConfig(
                            action: "discover/movie",
                            orientation: Axis.vertical,
                            title: gener.name,
                            initialPage: 1,
                            hasLoadMore: true,
                            generId: gener.id.toString())),
                  )));
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(.4)),
                label: Text(
                  "Show More",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                icon: Icon(Icons.arrow_forward, color: Colors.black),
              )
            ]),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: MoviesListWidget(
                config: GenerViewConfig(
                    generId: gener.id.toString(), title: gener.name),
              ),
            )
          ],
        ),
      ),
    );
  }
}
