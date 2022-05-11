

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/colors.dart';

import '../../pages/search_page.dart';

class TopMainPage extends StatelessWidget {
  const TopMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 290,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.grey1,
                borderRadius: BorderRadius.circular(45),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.only(left: 20, top: 11, bottom: 14),
                      child: SvgPicture.asset('img/search.svg', width: 18, height: 18,),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.green1,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Center(
                child: SvgPicture.asset('img/camera.svg', width: 18, height: 16,),
              ),
            )
          ],
        ));
  }
}
