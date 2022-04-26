
import 'package:flutter/cupertino.dart';

import '../../../core/colors.dart';
import '../add_button.dart';
import '../common_text.dart';

class BottomDetailPage extends StatelessWidget {
  final double productPrice;
  const BottomDetailPage({Key? key, required this.productPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30, top: 17, bottom: 17),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        border:
        Border(top: BorderSide(width: 2, color: AppColors.shadow)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                    text: 'PRICE', size: 12, color: AppColors.grey2),
                SizedBox(
                  height: 5,
                ),
                CommonText(
                  text: '\$${productPrice.toInt()}',
                  size: 18,
                  color: AppColors.green1,
                  font: 'SFPRODISPLAYBOLD',
                ),
              ],
            ),
          ),
          AddButton(text: 'ADD'),
        ],
      ),
    );
  }
}
