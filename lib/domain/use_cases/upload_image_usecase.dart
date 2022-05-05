
import 'dart:io';

import '../repositories/swagger_repository.dart';

class UploadImageUseCase {
  final SwaggerRepository repository;
  UploadImageUseCase({required this.repository});

 Future<String> call(File image) async{
   return repository.uploadImage(image);
 }
}