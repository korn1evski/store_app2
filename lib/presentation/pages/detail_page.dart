

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/presentation/manager/all_products/all_products_cubit.dart';
import 'package:store_app/presentation/manager/favorite_products/favorite_cubit.dart';
import 'package:store_app/presentation/widgets/detail_page/bottom_detail_page.dart';

import '../../data/remote/data_sources/swagger_remote_data_source_impl.dart';
import '../../data/repositories/swagger_repository_impl.dart';
import '../../domain/use_cases/get_categories_data_usecase.dart';
import '../../domain/use_cases/get_result_data_usecase.dart';
import '../widgets/detail_page/content_detail_page.dart';
import '../widgets/detail_page/top_detail_page.dart';

class DetailPage extends StatelessWidget {
  final ProductEntity product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return BlocProvider<FavoriteCubit>(
         create: (context) => FavoriteCubit(),
         child: BlocBuilder<AllProductsCubit, AllProductsState>(
           builder: (context, state) {
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
         ),
       );
  }
}
