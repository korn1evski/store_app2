import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/presentation/widgets/rounded_cached_image.dart';

import '../common_text.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.image,
      required this.startCount,
      required this.message})
      : super(key: key);
  final String firstName;
  final String lastName;
  final String image;
  final int startCount;
  final String message;

  @override
  Widget build(BuildContext context) {
    List stars = [];
    for (int i = 0; i < startCount; i++) {
      stars.add(Padding(
        padding: EdgeInsets.only(left: 7),
        child: SvgPicture.asset('img/fstar.svg', width: 15, height: 14),
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        width: double.maxFinite,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedCachedImage(imgUrl: image, radius: 20),
              SizedBox(
                width: 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonText(
                          text: firstName + ' ' + lastName,
                          size: 14,
                          font: 'SFPRODISPLAYBOLD',
                        ),
                        Row(
                          children: [
                            ...stars.map((star) => star),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CommonText(
                      text: message,
                      size: 14,
                      lineHeight: 1.5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
