import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/injection_container.dart' as di;

import '../../core/count.dart';
import 'favorite_circle.dart';

// class Product extends StatefulWidget {
//   final String imgPath;
//   final String name;
//   final String brand;
//   final String price;
//   final int productId;
//
//   Product(
//       {Key? key,
//       required this.price,
//       required this.name,
//       required this.brand,
//       required this.imgPath,
//       required this.productId})
//       : super(key: key);
//
//   @override
//   State<Product> createState() => _ProductState();
// }
//
// class _ProductState extends State<Product> {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: Count.count,
//       builder: (context, subCount, child) {
//         final prefs = di.sl<SharedPreferences>();
//         var check =  prefs.getStringList('favorites')!.contains(widget.productId.toString())
//             ? true
//             : false;
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 240,
//                   width: 164,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     image: DecorationImage(
//                       image: AssetImage(widget.imgPath),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 0,
//                     right: 0,
//                     child: FavoriteCircle(
//                       icon: check ? Icons.star : Icons.star_outline,
//                       iconColor: check ? Colors.amber : Colors.black,
//                     )),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             CommonText(
//                 text: widget.name,
//                 size: 16,
//                 font: 'SFPRODISPLAYMEDIUM',
//                 numberOfLines: 1),
//             SizedBox(
//               height: 6,
//             ),
//             CommonText(
//               text: widget.brand,
//               size: 12,
//               color: AppColors.grey2,
//               numberOfLines: 1,
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             CommonText(
//                 text: '\$' + widget.price,
//                 size: 16,
//                 color: AppColors.green1,
//                 font: 'SFPRODISPLAYMEDIUM'),
//           ],
//         );
//       }
//     );
//   }
// }

class Product extends StatelessWidget {
  final String imgPath;
  final String name;
  final String brand;
  final String price;
  final int productId;
  const Product({Key? key,
    required this.price,
    required this.name,
    required this.brand,
    required this.imgPath,
    required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Count.count,
        builder: (context, subCount, child) {
          final prefs = di.sl<SharedPreferences>();
          var check =  prefs.getStringList('favorites')!.contains(productId.toString())
              ? true
              : false;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: 164,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: FavoriteCircle(
                        icon: check ? Icons.star : Icons.star_outline,
                        iconColor: check ? Colors.amber : Colors.black,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CommonText(
                  text: name,
                  size: 16,
                  font: 'SFPRODISPLAYMEDIUM',
                  numberOfLines: 1),
              SizedBox(
                height: 6,
              ),
              CommonText(
                text: brand,
                size: 12,
                color: AppColors.grey2,
                numberOfLines: 1,
              ),
              SizedBox(
                height: 6,
              ),
              CommonText(
                  text: '\$' + price,
                  size: 16,
                  color: AppColors.green1,
                  font: 'SFPRODISPLAYMEDIUM'),
            ],
          );
        }
    );
  }
}

