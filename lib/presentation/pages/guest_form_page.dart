import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';
import 'package:store_app/presentation/manager/guest_review/guest_review_cubit.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/presentation/widgets/guest_form_page/round_photo.dart';
import 'package:store_app/presentation/widgets/guest_form_page/stars.dart';
import '../../core/colors.dart';
import '../widgets/guest_form_page/form_field_name.dart';

class GuestFormPage extends StatefulWidget {
  const GuestFormPage({Key? key, required this.productId}) : super(key: key);
  final int productId;

  @override
  State<GuestFormPage> createState() => _GuestFormPageState();
}

class _GuestFormPageState extends State<GuestFormPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuestReviewCubit>(context).initAction();
  }

  final editName = TextEditingController();
  final editLastName = TextEditingController();
  final editMessage = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? image;
  int starsReview = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Form(
        key: _formkey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                BlocBuilder<GuestReviewCubit, GuestReviewState>(
                  builder: (context, state) {
                    if (state is ProvideImageState) {
                      this.image = state.image;
                      return RoungPhoto(
                        isFlutter: false,
                        image: image!,
                      );
                    } else {
                      return image != null
                          ? RoungPhoto(
                              isFlutter: false,
                              image: image!,
                            )
                          : RoungPhoto(isFlutter: true);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  heroTag: 'btn1',
                  onPressed: () {
                    BlocProvider.of<GuestReviewCubit>(context).pickImage();
                  },
                  label: Text(
                    'Choose image from gallery',
                  ),
                  icon: Icon(Icons.picture_in_picture),
                  backgroundColor: AppColors.green1,
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  heroTag: 'btn2',
                  onPressed: () {
                    BlocProvider.of<GuestReviewCubit>(context).takePhoto();
                  },
                  label: Text(
                    'Take a photo',
                  ),
                  icon: Icon(Icons.camera),
                  backgroundColor: AppColors.green1,
                ),
                FormFieldName(
                  target: 'FirstName',
                  controller: editName,
                ),
                FormFieldName(
                  target: 'LastName',
                  controller: editLastName,
                ),
                TextFormField(
                  controller: editMessage,
                  decoration: InputDecoration(labelText: 'Enter your message'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your message ';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CommonText(
                  text: 'Rate the product',
                  size: 16,
                  font: 'SFPRODISPLAYBOLD',
                ),
                BlocBuilder<GuestReviewCubit, GuestReviewState>(
                    builder: (context, state) {
                  if (state is UpdateReviewPageState) {
                    starsReview = state.review;
                    return Stars(selectedStar: starsReview);
                  } else {
                    return Stars(selectedStar: -1);
                  }
                }),
                FloatingActionButton.extended(
                  heroTag: 'btn3',
                  onPressed: () {
                    if (starsReview == -1) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Alert'),
                          content: Text('Add review first'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'))
                          ],
                        ),
                      );
                    }
                    if (_formkey.currentState!.validate() && starsReview != -1) {
                      BlocProvider.of<DetailPageCubit>(context).sendReview(
                          id: widget.productId,
                          firstName: editName.text,
                          lastName: editLastName.text,
                          rating: starsReview + 1,
                          message: editMessage.value.text,
                        productId: widget.productId
                      );
                      Navigator.pop(context);
                    }
                  },
                  label: Text(
                    'Submit',
                  ),
                  icon: Icon(Icons.check_box),
                  backgroundColor: Colors.lightBlue,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
