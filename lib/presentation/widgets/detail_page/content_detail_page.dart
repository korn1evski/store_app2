import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/pages/feedback_page.dart';
import 'package:store_app/presentation/pages/feedback_x_page.dart';
import 'package:store_app/presentation/widgets/detail_page/review_widget.dart';

import '../../../data/remote/models/id_product_model.dart';
import '../common_text.dart';
import '../oval_info.dart';

class ContentDetailPage extends StatelessWidget {
  final int productId;
  final String productName;
  final String productSize;
  final String productColor;
  final String productDetails;
  final List<Review> reviews;
  final String image;

  const ContentDetailPage(
      {Key? key,
      required this.productId,
      required this.productName,
      required this.productSize,
      required this.productColor,
      required this.productDetails,
      required this.reviews,
      required this.image
      })
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
          ReadMoreText(
            productDetails,
            trimLines: 2,
            colorClickableText: AppColors.green1,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            moreStyle: TextStyle(
                fontSize: 14,
                height: 2,
                fontFamily: 'SFPRODISPLAYREGULAR',
                color: AppColors.green1),
            style: TextStyle(
                fontSize: 14,
                height: 2,
                fontFamily: 'SFPRODISPLAYREGULAR',
                color: Colors.black),
          ),
          SizedBox(
            height: 44,
          ),
          CommonText(
            text: 'Reviews',
            size: 18,
            font: 'SFPRODISPLAYBOLD',
          ),
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(productId: productId, image: image, name: productName, details: productDetails)));
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackXPage(productId: productId, image: image, name: productName, details: productDetails)));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 0),
              child: CommonText(
                text: 'Write your',
                size: 14,
                color: AppColors.green1,
              ),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.only(bottom: 32),
              itemCount: reviews.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return ReviewWidget(
                    firstName: reviews[index].firstName,
                    lastName: reviews[index].lastName,
                    image: reviews[index].image,
                    startCount: reviews[index].rating,
                    message: reviews[index].message);
              }),
        ],
      ),
    );
  }
}
