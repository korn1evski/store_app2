import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/register/register_cubit.dart';
import 'package:store_app/presentation/pages/terms_page.dart';
import 'package:store_app/presentation/widgets/add_button.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/presentation/widgets/login_widgets/password_input.dart';
import 'package:store_app/presentation/widgets/login_widgets/simple_input.dart';
import 'package:store_app/presentation/widgets/my_checkbox.dart';
import 'package:store_app/presentation/widgets/register_page/photo_upload_widget.dart';
import '../../core/validation_functions.dart';
import '../widgets/show_my_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void initState(){
    super.initState();
    BlocProvider.of<RegisterCubit>(context).toInitial();
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  String? repeatPassValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter password';
    } else if (value != passwordController.text) {
      return 'Passwords don\'t match';
    }
  }

  void onChangeCheck(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 16, right: 16, top: 66),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'img/arrow.svg',
                        width: 6,
                        height: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  CommonText(
                    text: 'Sign Up',
                    size: 26,
                    font: 'SFPRODISPLAYBOLD',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 28),
                    child: CommonText(
                      text: 'Please enter the required information for sign up',
                      size: 14,
                      color: AppColors.grey2,
                    ),
                  ),
                  PhotoUploadWidget(),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SimpleInput(
                            controller: nameController,
                            validationFunc: fullNameValid,
                            hintText: 'Full Name',
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SimpleInput(
                              controller: emailController,
                              validationFunc: emailValid,
                              hintText: 'Email'),
                          SizedBox(
                            height: 16,
                          ),
                          SimpleInput(
                              controller: phoneController,
                              validationFunc: phoneValid,
                              hintText: 'Phone'),
                          SizedBox(
                            height: 16,
                          ),
                          PasswordInput(
                            controller: passwordController,
                            hintText: 'Password',
                            validationFunc: passValid,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          PasswordInput(
                            controller: repeatController,
                            hintText: 'Repeat Password',
                            validationFunc: repeatPassValidation,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              MyCheckBox(
                                hoverColor: AppColors.grey3,
                                checkColor: Colors.white,
                                fillColor: AppColors.green1,
                                isChecked: isChecked,
                                foo: onChangeCheck,
                              ),
                              CommonText(
                                text: 'I agree with ',
                                size: 14,
                                color: AppColors.grey2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TermsPage()));
                                },
                                child: CommonText(
                                  text: 'Terms of Service',
                                  size: 14,
                                  color: AppColors.green1,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          AddButton(
                            text: 'REGISTRATION',
                            width: double.maxFinite,
                            onTap: () {
                              if (_formkey.currentState!.validate()) {}
                              if (!isChecked) {
                                showMyDialog(
                                    context,
                                    'Alert',
                                    'You should agree with our terms',
                                    'ok',
                                    AppColors.green1);
                              }
                              if (_formkey.currentState!.validate() && isChecked) {
                                BlocProvider.of<RegisterCubit>(context).registerLoading();
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
                                        nameController.text,
                                        emailController.text,
                                        phoneController.text,
                                        passwordController.text,
                                        context
                                );
                              }
                            },
                          ),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              if (state is RegistrationState) {

                                return Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: CommonText(text: state.message, size: 18, color: state.message.toLowerCase().contains('already') ? Colors.red : AppColors.green1,),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegistrationLoadingState) {
                      return Visibility(
                        visible: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white.withOpacity(0.5),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),
        ],
      ),
    );
  }
}
