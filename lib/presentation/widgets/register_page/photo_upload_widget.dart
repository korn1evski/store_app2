import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

import '../../../core/colors.dart';
import '../guest_form_page/round_photo.dart';

class PhotoUploadWidget extends StatelessWidget {
  PhotoUploadWidget({Key? key}) : super(key: key);

  late String imgLink;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is ProvideRegisterImageState) {
                imgLink = state.link;
                image = state.image;
                return RoundPhoto(
                  isFlutter: false,
                  image: image!,
                );
              } else {
                return image != null
                    ? RoundPhoto(
                  isFlutter: false,
                  image: image!,
                )
                    : RoundPhoto(isFlutter: true);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
