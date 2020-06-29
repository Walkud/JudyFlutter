import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;
  String loadingText;

  LoadingContainer(
      {@required this.child,
      @required this.isLoading,
      this.loadingText = "加载中",
      this.cover = false});

  Widget get _loadingView {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.only(top: 15)),
            Text(loadingText)
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : Container()],
          );
  }
}
