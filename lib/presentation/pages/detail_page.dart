import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/widgets/detail_page/structure_detail_page.dart';

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
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ProductLoadedState) {
        return StructureDetailPage(
            mainImage: state.product.mainImage,
            id: state.product.id,
            images: state.product.images,
            productName: state.product.name,
            productSize: state.product.size,
            productDetails: state.product.details,
            reviews: state.product.reviews,
            price: state.product.price,
            productColor: state.product.colour);
      } else if (state is ProductUpdatedState) {
        return StructureDetailPage(
            mainImage: state.product.mainImage,
            id: state.product.id,
            images: state.product.images,
            productName: state.product.name,
            productSize: state.product.size,
            productDetails: state.product.details,
            reviews: state.product.reviews,
            price: state.product.price,
            productColor: state.product.colour);
      } else {
        return const Scaffold(
          body: Center(
            child: Text('Something went wrong'),
          ),
        );
      }
    });
  }
}
