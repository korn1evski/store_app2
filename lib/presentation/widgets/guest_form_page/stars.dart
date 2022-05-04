import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';

class Stars extends StatelessWidget {
  const Stars({Key? key, required this.selectedStar}) : super(key: key);
  final int selectedStar;

  @override
  Widget build(BuildContext context) {
    List stars = [];
    if (selectedStar == -1) {
      for (int i = 0; i < 5; i++) {
        stars.add(Icon(Icons.star_outline, color: Colors.yellow, size: 40,));
      }
    } else {
      for (int i = 0; i <= selectedStar; i++) {
        stars.add(Icon(Icons.star, color: Colors.yellow, size: 40,));
      }
      for (int i = selectedStar + 1; i < 5; i++) {
        stars.add(Icon(Icons.star_outline, color: Colors.yellow, size: 40,));
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...stars.map((e) =>
              GestureDetector(child: e, onTap: () {
                BlocProvider.of<GuestReviewCubit>(context).setReview(stars.indexOf(e));
              },)).toList()
        ],
      ),
    );
  }
}
