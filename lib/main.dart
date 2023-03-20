import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_event.dart';
import 'package:picture_app/consts/app_colors.dart';
import 'package:picture_app/consts/app_text_style.dart';
import 'package:picture_app/screens/new_screen.dart';
import 'package:picture_app/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
        ),
      ),
      home: const PictureApp(),
    );
  }
}

class PictureApp extends StatefulWidget {
  const PictureApp({super.key});

  @override
  State<PictureApp> createState() => _PictureAppState();
}

class _PictureAppState extends State<PictureApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                primary: false,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  indicatorColor: AppColor.indicatorColor,
                  labelColor: AppColor.black,
                  unselectedLabelColor: AppColor.greyColor,
                  tabs: [
                    Tab(
                      child: Text(
                        'New',
                        style: AppStyles.tabBarTextStyle,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Popular',
                        style: AppStyles.tabBarTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider(
                key: UniqueKey(),
                create: (context) =>
                    PictureBloc(isNew: true)..add(PictureFetched()),
                child: const NewScreen(),
              ),
              BlocProvider(
                key: UniqueKey(),
                create: (context) =>
                    PictureBloc(isPopular: true)..add(PictureFetched()),
                child: const NewScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
