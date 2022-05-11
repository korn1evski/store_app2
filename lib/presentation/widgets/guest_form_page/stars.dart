import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';
import 'package:store_app/presentation/manager/review_page/review_page_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key, required this.selectedStar, required this.textLength}) : super(key: key);
  final int selectedStar;
  final int textLength;

  @override
  Widget build(BuildContext context) {
    List stars = [];
    List<String> marks = ['Horrible', 'Bad', 'Average', 'Good', 'Excellent'];
    if (selectedStar == -1) {
      for (int i = 0; i < 5; i++) {
        stars.add(_buildStar(false, i, marks));
      }
    } else {
      for (int i = 0; i <= selectedStar; i++) {
        stars.add(_buildStar(true, i, marks));
      }
      for (int i = selectedStar + 1; i < 5; i++) {
        stars.add(_buildStar(false, i, marks));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...stars.map((e) =>
            GestureDetector(child: e, onTap: () {
              // BlocProvider.of<GuestReviewCubit>(context).setReview(stars.indexOf(e));
              BlocProvider.of<ReviewPageCubit>(context).setReview(stars.indexOf(e), textLength);
            },)).toList()
      ],
    );
  }
}

Widget _buildStar(bool isFull, int index, List<String> marks){
  return Padding(
    padding: EdgeInsets.only(right: 7),
    child: Column(
      children: [
        SvgPicture.asset('img/fstar.svg', color: isFull? AppColors.yellow1 : AppColors.grey3, width: 33, height: 31,),
        SizedBox(height: 9,),
        CommonText(text: marks[index], size: 10, color: AppColors.grey2,)
      ],
    ),
  );
}
