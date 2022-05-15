import 'package:flutter/material.dart';

class PositionedLoading extends StatefulWidget {
  bool isVisible;
  PositionedLoading({Key? key, required this.isVisible}) : super(key: key);

  @override
  State<PositionedLoading> createState() => _PositionedLoadingState();
}

class _PositionedLoadingState extends State<PositionedLoading> {
  @override
  Widget build(BuildContext context) {
          return Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                visible: widget.isVisible,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ));
  }
}
