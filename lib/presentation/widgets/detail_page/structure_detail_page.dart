import 'package:flutter/material.dart';
import 'package:store_app/presentation/widgets/detail_page/top_detail_page.dart';

import '../../../data/remote/models/id_product_model.dart';
import 'bottom_detail_page.dart';
import 'content_detail_page.dart';

class StructureDetailPage extends StatelessWidget {
  const StructureDetailPage(
      {Key? key,
      required this.mainImage,
      required this.id,
      required this.images,
      required this.productName,
      required this.productSize,
      required this.productDetails,
      required this.reviews,
      required this.price,
      required this.productColor})
      : super(key: key);
  final String mainImage;
  final int id;
  final List<ImageWrapper> images;
  final String productName;
  final String productSize;
  final String productColor;
  final String productDetails;
  final List<Review> reviews;
  final double price;

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
                  TopDetailPage(
                    productImg: mainImage,
                    productId: id,
                    images: images,
                    price: price,
                    details: productDetails,
                    name: productName,
                  ),
                  ContentDetailPage(
                    productId: id,
                    productName: productName,
                    productSize: productSize,
                    productColor: productColor,
                    productDetails: productDetails,
                    reviews: reviews,
                    image: mainImage,
                  )
                ],
              ),
            ),
          ),
          BottomDetailPage(
            productPrice: price,
          )
        ],
      ),
    );
  }
}
