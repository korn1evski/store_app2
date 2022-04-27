

import 'package:flutter/material.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/presentation/widgets/detail_page/bottom_detail_page.dart';
import '../widgets/detail_page/content_detail_page.dart';
import '../widgets/detail_page/top_detail_page.dart';

class DetailPage extends StatelessWidget {
  final ProductEntity product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
             return Scaffold(
               body: Column(
                 children: [
                   Expanded(
                     child: SingleChildScrollView(
                       scrollDirection: Axis.vertical,
                       child: Column(
                         children: [
                           TopDetailPage(productImg: ProductEntity.properImage(
                               product.category.name), productId: product.id),
                           ContentDetailPage(productName: product.name,
                               productSize: product.size,
                               productColor: product.colour,
                               productDetails: product.details)
                         ],
                       ),
                     ),
                   ),
                   BottomDetailPage(productPrice: product.price,)
                 ],
               ),
             );
  }
}
