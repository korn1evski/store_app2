import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/review_page/review_page_cubit.dart';
import 'package:store_app/presentation/widgets/add_button.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/presentation/widgets/positioned_loading.dart';
import 'package:store_app/presentation/widgets/review_page/text_area.dart';
import 'package:store_app/presentation/widgets/show_my_dialog.dart';
import '../widgets/guest_form_page/stars.dart';
import 'package:store_app/injection_container.dart' as di;

class ReviewPage extends StatefulWidget {
  final String image;
  final String details;
  final String name;
  final int productId;

  const ReviewPage(
      {Key? key,
      required this.productId,
      required this.name,
      required this.details,
      required this.image})
      : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController textarea = TextEditingController();

  @override
  void dispose() {
    textarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int starsReview = -1;
    int maxCharacters = 30;
    bool isLoading = false;
    return BlocProvider<ReviewPageCubit>(
        create: (context) => ReviewPageCubit(),
        child: Scaffold(
          body: Stack(children: [
            Container(
                padding: EdgeInsets.only(left: 16, top: 19, right: 16),
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
                              imageUrl: widget.image,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
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
                                    text: widget.name,
                                    size: 16,
                                    font: 'SFPRODISPLAYBOLD',
                                    numberOfLines: 1,
                                    center: false,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CommonText(
                                    text: widget.details,
                                    size: 12,
                                    color: AppColors.grey2,
                                    numberOfLines: 3,
                                    lineHeight: 1.5,
                                  )
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
                        BlocBuilder<ReviewPageCubit, ReviewPageState>(
                            builder: (context, state) {
                          if (state is UpdateReviewPageState) {
                            starsReview = state.review;
                            return Stars(
                              selectedStar: starsReview,
                              textLength: textarea.text.length,
                            );
                          } else {
                            return Stars(
                              selectedStar: -1,
                              textLength: textarea.text.length,
                            );
                          }
                        }),
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
                            starsReview: starsReview,
                            maxCharacters: maxCharacters,
                            textarea: textarea),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 44),
                          child: BlocBuilder<ReviewPageCubit, ReviewPageState>(
                              builder: (context, state) {
                            if (state is UpdateReviewPageState) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonText(
                                    text:
                                        '${maxCharacters - state.textLength} characters remaining',
                                    size: 12,
                                    color: AppColors.grey2,
                                  )
                                ],
                              );
                            } else {
                              return Row();
                            }
                          }),
                        ),
                        AddButton(
                          text: 'SUBMIT REVIEW',
                          width: double.maxFinite,
                          height: 52,
                          onTap: () {
                            if (starsReview == -1) {
                              showMyDialog(context, 'Alert', 'Rate a product',
                                  'ok', AppColors.green1);
                            } else if (textarea.text.trim() == '') {
                              showMyDialog(context, 'Alert', 'Write a review',
                                  'ok', AppColors.green1);
                            } else {
                              BlocProvider.of<DetailPageCubit>(context)
                                  .prepareReview(
                                      context: context,
                                      productId: widget.productId,
                                      message: textarea.text,
                                      starsReview: starsReview);
                            }
                          },
                        )
                      ],
                    )
                  ],
                )),
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
            PositionedLoading(isVisible: isLoading)
          ]),
        ));
  }
}
