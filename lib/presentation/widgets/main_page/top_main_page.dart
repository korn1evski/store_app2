

import 'package:flutter/material.dart';
import 'package:store_app/core/colors.dart';

class TopMainPage extends StatelessWidget {
  const TopMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          top: 74,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20, top: 11, bottom: 14),
                    child: Icon(
                      Icons.search,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.green1,
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
        ));
  }
}
