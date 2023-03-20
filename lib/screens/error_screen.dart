import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_bloc.dart';
import 'package:picture_app/bloc/bloc/picture_event.dart';
import 'package:picture_app/bloc/bloc/picture_state.dart';
import 'package:picture_app/consts/app_text_style.dart';
import 'package:picture_app/consts/endpoints.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _PlugState();
}

class _PlugState extends State<ErrorScreen> {
  Completer _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PictureBloc, PictureState>(
      listener: (context, state) {
        if (state is PictureSuccess || state is PictureError) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              context.read<PictureBloc>().add(PictureRefreshed());
              return _refreshCompleter.future;
            },
          ),
          SliverFillRemaining(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      Endpoint.connectionErrorImage,
                      width: 160.0,
                      height: 160.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      Endpoint.connectionErrorTitle,
                      textAlign: TextAlign.center,
                      style: AppStyles.errorTitleTextStyle,
                    ),
                  ),
                  const Text(
                    Endpoint.connectionErrorMessage,
                    textAlign: TextAlign.center,
                    style: AppStyles.errorMessageTextStyle,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
