import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/get_product_by_id_usecase.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/presentation/manager/feed_back/feedback_cubit.dart';
import '../../../domain/entities/account_info_entity.dart';
import '../../../domain/use_cases/send_review_usecase.dart';
import '../guest_review/guest_review_cubit.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit(
      {required this.getProductByIdUseCase,
      required this.sendReviewUseCase, required this.getAccountInfoUseCase, required this.verifyLoginUseCase, required this.getSharedStringUseCase})
      : super(DetailPageInitial());
  final GetProductByIdUseCase getProductByIdUseCase;
  final SendReviewUseCase sendReviewUseCase;
  final GetSharedStringUseCase getSharedStringUseCase;
  final VerifyLoginUseCase verifyLoginUseCase;
  final GetAccountInfoUseCase getAccountInfoUseCase;


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
      required String imageLink,
      required BuildContext context}) async {
    await sendReviewUseCase.call(
        id: id,
        firstName: firstName,
        lastName: lastName,
        rating: rating,
        message: message.trim(),
        img: imageLink);
    Navigator.pop(context);
    BlocProvider.of<FeedbackCubit>(context).loading(false);

    updateDetailPage(id);
    BlocProvider.of<GuestReviewCubit>(context).upgradeInitial(false);
  }

  Future<void> prepareReview({required BuildContext context, required productId, required String message, required int starsReview}) async{
    final AccountInfoEntity? accountEntity = await getAccountInfoUseCase.call();
    if(accountEntity != null) {
      final nameArr = accountEntity.fullName.trim().split(' ');
      if (nameArr.length == 2) {
        sendReview(id: productId,
            firstName: nameArr[1],
            lastName: nameArr[0],
            rating: starsReview + 1,
            message: message,
            imageLink: 'string',
            context: context);
      } else {
        sendReview(id: productId,
            firstName: accountEntity.fullName,
            lastName: 'default',
            rating: starsReview + 1,
            message: message,
            imageLink: 'string',
            context: context);
      }
    }
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
