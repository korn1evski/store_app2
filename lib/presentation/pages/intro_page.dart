import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/presentation/manager/intro/intro_cubit.dart';
import 'package:store_app/presentation/pages/login_page.dart';
import 'package:store_app/presentation/pages/nav_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IntroCubit>(context).verifyLogin(context);
    return BlocBuilder<IntroCubit, IntroState>(builder: (context, state) {
      if (state is IntroLoadingState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (state is IntroLoadedState) {
        return const NavPage();
      } else if (state is IntroErrorLoadedState) {
        return const LoginPage();
      } else if (state is IntroElseState) {
        return const LoginPage();
      } else {
        return Container();
      }
    });
  }
}
