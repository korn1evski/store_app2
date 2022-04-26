
import 'package:flutter/cupertino.dart';

import '../common_text.dart';
import '../oval_info.dart';

class ContentDetailPage extends StatelessWidget {
  final String productName;
  final String productSize;
  final String productColor;
  final String productDetails;

  const ContentDetailPage(
      {Key? key,
      required this.productName,
      required this.productSize,
      required this.productColor,
      required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 17, bottom: 29),
            child: CommonText(
              text: productName,
              size: 26,
              font: 'SFPRODISPLAYBOLD',
              lineHeight: 1.5,
              center: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OvalInfo(leftText: 'Size', rightText: productSize),
              OvalInfo(leftText: 'Colour', rightText: productColor)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 19),
            child: CommonText(
              text: 'Details',
              size: 18,
              font: 'SFPRODISPLAYBOLD',
            ),
          ),
          CommonText(
            text: productDetails,
            size: 14,
            lineHeight: 2,
          )
        ],
      ),
    );
  }
}
