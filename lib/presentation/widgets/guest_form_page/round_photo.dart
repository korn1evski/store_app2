import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';

class RoundPhoto extends StatelessWidget {
  const RoundPhoto({Key? key, required this.isFlutter, this.image})
      : super(key: key);

  final File? image;
  final bool isFlutter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        clipRect(isFlutter, image, context),
        Positioned(
            bottom: 0,
            right: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightBlueAccent,
              ),
              width: 15,
              height: 15,
              child: Icon(
                Icons.edit,
                size: 10,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}

Widget clipRect(bool isFlutter, File? image, BuildContext context) {

  void camera(){
    BlocProvider.of<RegisterCubit>(context).takePhoto();
  }

  void pickImage(){
    BlocProvider.of<RegisterCubit>(context).pickImage();
  }
  Future<dynamic> onTap() {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Center(
                child: CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      child: Text('Camera'),
                      onPressed: () {
                        camera();
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Gallery'),
                      onPressed: () {
                        pickImage();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        camera();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: () {
                        pickImage();
                        Navigator.of(context).pop();
                      })
                ],
              ));
    }
  }

  if (isFlutter) {
    return Ink(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: InkWell(
          child: ClipOval(
            child: FlutterLogo(
              size: 60,
            ),
          ),
          onTap: () {
            onTap();
          },
          customBorder: CircleBorder(),
        ));
  } else {
    return Ink(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: InkWell(
          child: ClipOval(
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            onTap();
          },
          customBorder: CircleBorder(),
        ));
  }
}
