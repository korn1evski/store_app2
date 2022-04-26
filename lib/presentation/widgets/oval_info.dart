
import 'package:flutter/material.dart';

import '../../core/colors.dart';
import 'common_text.dart';

class OvalInfo extends StatelessWidget {
  final String leftText;
  final String rightText;

  const OvalInfo({Key? key, required this.leftText, required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: 160,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: AppColors.grey3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 35),
            child: CommonText(
              text: leftText,
              size: 14,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                child: Text(rightText, textAlign: TextAlign.right,),
          )),
        ],
      ),
    );
  }
}
