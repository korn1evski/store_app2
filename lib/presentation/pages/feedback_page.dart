import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/presentation/manager/feed_back/feedback_cubit.dart';
import 'package:store_app/presentation/widgets/feedback_page/stars_widget.dart';

import '../../core/colors.dart';
import '../manager/detail_page/detail_page_cubit.dart';
import '../widgets/add_button.dart';
import '../widgets/common_text.dart';
import '../widgets/positioned_loading.dart';
import '../widgets/show_my_dialog.dart';
import '../widgets/text_area.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage(
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

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController textArea = TextEditingController();

  @override
  void dispose() {
    textArea.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    BlocProvider.of<FeedbackCubit>(context).loading(false);
  }

  @override
  Widget build(BuildContext context) {
    int starsReview = -1;
    int maxCharacters = 30;
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
                          imageUrl: widget.image,
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
                    BlocBuilder<FeedbackCubit, FeedbackState>(
                        builder: (context, state) {
                      if (state is FeedBackRefreshState) {
                        starsReview = state.starsCount;
                        return StarsWidget(selectedStar: starsReview, foo: (value){ BlocProvider.of<FeedbackCubit>(context).setStars(value);});
                      } else {
                        return StarsWidget(selectedStar: -1, foo: (value){ BlocProvider.of<FeedbackCubit>(context).setStars(value);});
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
                      maxCharacters: maxCharacters,
                      textarea: textArea,
                      onChanged: (String value) {
                        BlocProvider.of<FeedbackCubit>(context)
                            .setTextLength(value.length);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 44),
                      child: BlocBuilder<FeedbackCubit, FeedbackState>(
                          builder: (context, state) {
                        int used = 0;
                        if (state is FeedBackRefreshState) {
                          used = state.textLength;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonText(
                              text:
                                  '${maxCharacters - used} characters remaining',
                              size: 12,
                              color: AppColors.grey2,
                            )
                          ],
                        );
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
                        } else if (textArea.text.trim() == '') {
                          showMyDialog(context, 'Alert', 'Write a review',
                              'ok', AppColors.green1);
                        } else {
                          BlocProvider.of<FeedbackCubit>(context).loading(true);
                          BlocProvider.of<DetailPageCubit>(context)
                              .prepareReview(
                              context: context,
                              productId: widget.productId,
                              message: textArea.text,
                              starsReview: starsReview);
                        }
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
          BlocBuilder<FeedbackCubit, FeedbackState>(builder: (context, state){
            if(state is FeedBackIsLoadingState){
              return PositionedLoading(isVisible: state.isLoading);
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
