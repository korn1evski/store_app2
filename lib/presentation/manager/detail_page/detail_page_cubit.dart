import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';
import '../../../domain/use_cases/send_review_usecase.dart';
import '../guest_review/guest_review_cubit.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit(
      {required this.getProductByIdUseCase,
      required this.sendReviewUseCase,})
      : super(DetailPageInitial());
  final GetProductByIdUseCase getProductByIdUseCase;
  final SendReviewUseCase sendReviewUseCase;
  String? imageLink;

  void loading() {
    emit(LoadingDetailState());
  }

  Future<void> sendReview(
      {required int id,
      required String firstName,
      required String lastName,
      required int rating,
      required String message,
      required int productId,
      required String imageLink,
      required BuildContext context}) async {
    await sendReviewUseCase.call(
        id: id,
        firstName: firstName,
        lastName: lastName,
        rating: rating,
        message: message,
        img: imageLink);
    Navigator.pop(context);

    updateDetailPage(productId);
    BlocProvider.of<GuestReviewCubit>(context).upgradeInitial(false);
  }

  void getProduct(int id) async {
    var product = await getProductByIdUseCase.call(id);
    emit(ProductLoadedState(product: product));
  }

  void updateDetailPage(int id) async {
    var product = await getProductByIdUseCase.call(id);
    emit(ProductUpdatedState(product: product));
  }
}
