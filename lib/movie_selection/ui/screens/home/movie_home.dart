import 'package:flutter/material.dart';
import 'package:movie_selection/movie_selection/constants/constants.dart';
import 'package:movie_selection/movie_selection/models/billboard.dart';
import 'widgets/billboard_list.dart';
import 'widgets/header_option.dart';

class MovieHome extends StatelessWidget {
  MovieHome({super.key});

  final resizeNotifier = ValueNotifier<double>(0);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    final heightAppBar = size.height * .2;
    final resizeValue = heightAppBar * .6 - topPadding;
    final billboardList = Billboard.billboardList;

    resizeNotifier.value = heightAppBar;
    _scrollController.addListener(() {
      if (_scrollController.offset < resizeValue) {
        resizeNotifier.value = heightAppBar - _scrollController.offset;
      }
    });
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: Stack(
        children: [
          //-------------------------
          // Movie lists
          //-------------------------
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: billboardList.length,
            padding: EdgeInsets.only(top: heightAppBar + 10, bottom: 20),
            itemBuilder: (context, index) {
              final billboard = billboardList[index];
              return BillboardList(billboard: billboard);
            },
          ),
          //-----------------------------
          // Custom bouncing app bar
          //-----------------------------
          ValueListenableBuilder<double>(
            valueListenable: resizeNotifier,
            builder: (context, value, child) {
              return SizedBox(
                height: value,
                width: double.infinity,
                child: child,
              );
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: kPrimaryColorHeavy,
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColorDark.withOpacity(.4),
                    blurRadius: 15,
                  )
                ],
              ),
              child: Row(
                children: const [
                  HeaderOption(
                    title: 'Cinema',
                    isSelected: false,
                  ),
                  HeaderOption(
                    title: 'Movie',
                    isSelected: true,
                  ),
                  HeaderOption(
                    title: 'Time',
                    isSelected: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
