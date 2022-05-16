import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/feed_back/feedback_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({Key? key, required this.selectedStar}) : super(key: key);
  final int selectedStar;

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
              BlocProvider.of<FeedbackCubit>(context).setStars(stars.indexOf(e));
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
