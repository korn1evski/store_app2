import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/login/login_cubit.dart';
import 'package:store_app/presentation/pages/sign_up_page.dart';
import 'package:store_app/presentation/widgets/add_button.dart';

import '../../core/validation_functions.dart';
import '../widgets/common_text.dart';
import '../widgets/login_widgets/password_input.dart';
import '../widgets/login_widgets/simple_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
   _emailController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 16, right: 16, top: 112),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Log In',
                    size: 26,
                    font: 'SFPRODISPLAYBOLD',
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Column(children: [
                              SimpleInput(
                                  controller: _emailController,
                                  validationFunc: emailValid,
                                  hintText: 'Email'),
                              SizedBox(
                                height: 16,
                              ),
                              PasswordInput(
                                controller: _passwordController,
                                hintText: 'Password',
                                validationFunc: passValid,
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              CommonText(
                                text: 'Forgot password?',
                                size: 14,
                                color: AppColors.green1,
                                font: 'SFPRODISPLAYMEDIUM',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 44,
                          ),
                          AddButton(
                            text: 'LOG IN',
                            width: double.maxFinite,
                            onTap: (){
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginLoading();
                                BlocProvider.of<LoginCubit>(context).login(_emailController.text, _passwordController.text, context);
                              }
                            },
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginFinishedState) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: CommonText(text: state.message, size: 18, color: Colors.red, center: true, lineHeight: 1.6,),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ))
                ],
              )),
          Positioned(
              top: 0,
              left: 0,
              child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
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
                  }))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(
              text: 'Not registered yet? ',
              size: 14,
              color: AppColors.grey2,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: CommonText(
                  text: 'Register',
                  size: 14,
                  color: AppColors.green1,
                ))
          ],
        ),
      ),
    );
  }
}
