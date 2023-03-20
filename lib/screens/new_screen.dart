import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_event.dart';
import 'package:picture_app/bloc/bloc/picture_state.dart';
import 'package:picture_app/consts/endpoints.dart';
import 'package:picture_app/screens/details_screen.dart';
import 'package:picture_app/screens/error_screen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final ScrollController _scrollController = ScrollController();
  Completer _refreshCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PictureBloc>().add(PictureFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = size.height / 6.5;
    final double itemWidth = size.width / 2;
    return BlocListener<PictureBloc, PictureState>(
      listener: (context, state) {
        if (state is PictureSuccess || state is PictureError) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<PictureBloc, PictureState>(
          builder: (context, state) {
            if (state is PictureError) {
              return const ErrorScreen();
            }
            if (state is PictureSuccess) {
              return CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      context.read<PictureBloc>().add(PictureRefreshed());
                      return _refreshCompleter.future;
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 30),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: index % 2 == 0
                                ? const EdgeInsets.only(right: 10, bottom: 10)
                                : const EdgeInsets.only(bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        picture: state.pictures[index],
                                      ),
                                    ),
                                  );
                                },
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                    Endpoint.placeholderImage,
                                  ),
                                  image: NetworkImage(
                                    state.pictures[index].image.getUrl(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: state.pictures.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                    ),
                  ),
                  if (!state.hasReachedMax)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
