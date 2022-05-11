import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/manager/intro/intro_cubit.dart';
import 'package:store_app/presentation/pages/login_page.dart';
import 'package:store_app/presentation/pages/nav_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = di.sl<SharedPreferences>();
    final String? refreshToken = prefs.getString('refreshToken');
    if (refreshToken != null) {
      BlocProvider.of<IntroCubit>(context).verifyLogin(refreshToken);
      return BlocBuilder<IntroCubit, IntroState>(builder: (context, state) {
        if (state is IntroLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is IntroLoadedState) {
          return NavPage();
        } else if (state is IntroErrorLoadedState) {
          return LoginPage();
        } else {
          return Container();
        }
      });
    } else {
      return LoginPage();
    }
  }
}
