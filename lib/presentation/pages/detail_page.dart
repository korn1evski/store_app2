import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/widgets/detail_page/bottom_detail_page.dart';
import '../widgets/detail_page/content_detail_page.dart';
import '../widgets/detail_page/top_detail_page.dart';

class DetailPage extends StatefulWidget {
  final productId;

  const DetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<DetailPageCubit>(context).loading();
      BlocProvider.of<DetailPageCubit>(context).getProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPageCubit, DetailPageState>(
        builder: (context, state) {
      if (state is LoadingDetailState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProductLoadedState) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TopDetailPage(
                          productImg: state.product.mainImage,
                          productId: state.product.id,
                          images: state.product.images),
                      ContentDetailPage(
                        productId: state.product.id,
                        productName: state.product.name,
                        productSize: state.product.size,
                        productColor: state.product.colour,
                        productDetails: state.product.details,
                        reviews: state.product.reviews,
                      )
                    ],
                  ),
                ),
              ),
              BottomDetailPage(
                productPrice: state.product.price,
              )
            ],
          ),
        );
      } else if (state is ProductUpdatedState) {
        print(state.lastName);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TopDetailPage(
                          productImg: state.product.mainImage,
                          productId: state.product.id,
                          images: state.product.images),
                      ContentDetailPage(
                        productId: state.product.id,
                        productName: state.product.name,
                        productSize: state.product.size,
                        productColor: state.product.colour,
                        productDetails: state.product.details,
                        reviews: state.product.reviews,
                      )
                    ],
                  ),
                ),
              ),
              BottomDetailPage(
                productPrice: state.product.price,
              )
            ],
          ),
        );
      } else {
        return Center(
          child: Text('Something went wrong'),
        );
      }
    });
  }
}
