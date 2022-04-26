
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

class CategoryWidget extends StatelessWidget {

  final String text;
  final String iconImg;

  const CategoryWidget({Key? key, required this.text, required this.iconImg}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 20,
                  offset: Offset(0.0, 5),
                )
              ]
            ),
            child: CachedNetworkImage(
              imageUrl: iconImg,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset('img/question.png'),
            ),
          ),
          const SizedBox(height: 13,),
          CommonText(text: text, size: 12, color: Colors.black, numberOfLines: 2, center: true)
        ],
      ),
    );
  }
}

