
import '../repositories/swagger_repository.dart';

class SendReviewUseCase {
  final SwaggerRepository repository;
  SendReviewUseCase({required this.repository});

  Future<void> call({required int id, required String firstName, required String lastName, required int rating, required String message, required String img}) async {
    return repository.sendReview(id: id, firstName: firstName, lastName: lastName, rating: rating, message: message, img: img);
  }
}