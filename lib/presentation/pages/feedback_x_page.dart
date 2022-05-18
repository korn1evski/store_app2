import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:store_app/presentation/manager/controllers/feedback_controller.dart';

import '../../core/colors.dart';
import '../widgets/add_button.dart';
import '../widgets/common_text.dart';
import '../widgets/feedback_page/stars_widget.dart';
import '../widgets/positioned_loading.dart';
import '../widgets/text_area.dart';

class FeedBackXPage extends StatelessWidget {
  FeedBackXPage(
      {Key? key,
      required this.image,
      required this.details,
      required this.name,
      required this.productId})
      : super(key: key);
  final String image;
  final String details;
  final String name;
  final int productId;
  final feedBackController = Get.find<FeedBackController>();

  @override
  Widget build(BuildContext context) {
    feedBackController.setIsLoading(false);
    feedBackController.setStarsReview(-1);
    feedBackController.changeUsedCharacters(0);
    feedBackController.textArea.clear();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, top: 19, right: 16),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: 'Write a Review',
                        size: 16,
                        font: 'SFPRODISPLAYBOLD',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: image,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          );
                        },
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: name,
                              size: 16,
                              font: 'SFPRODISPLAYBOLD',
                              numberOfLines: 1,
                              center: false,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            CommonText(
                              text: details,
                              size: 12,
                              color: AppColors.grey2,
                              numberOfLines: 3,
                              lineHeight: 1.5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  CommonText(
                    text: 'How\'s your item?',
                    size: 18,
                    font: 'SFPRODISPLAYBOLD',
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Obx(() => StarsWidget(
                        selectedStar: feedBackController.starsReview.value,
                    foo: (value){ feedBackController.starsReview.value = value;}
                      )),
                  SizedBox(
                    height: 44,
                  ),
                  CommonText(
                    text: 'Write your Review',
                    size: 18,
                    font: 'SFPRODISPLAYBOLD',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextArea(
                    maxCharacters: feedBackController.maxCharacters,
                    textarea: feedBackController.textArea,
                    onChanged: (String value) {
                      feedBackController.changeUsedCharacters(value.length);
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 44),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => CommonText(
                              text:
                                  '${feedBackController.maxCharacters - feedBackController.usedCharacters.value} characters remaining',
                              size: 12,
                              color: AppColors.grey2,
                            ),
                          )
                        ],
                      )),
                  AddButton(
                    text: 'SUBMIT REVIEW',
                    width: double.maxFinite,
                    height: 52,
                    onTap: () {
                      feedBackController.submitReview(context, productId);
                    },
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 25,
          top: 66,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('img/arrow.svg'),
          ),
          width: 6,
          height: 12,
        ),
        Obx(
            () => PositionedLoading(isVisible: feedBackController.isLoading.value)
        )
      ],
    ));
  }
}
