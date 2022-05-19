import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/manager/account/account_cubit.dart';
import 'package:store_app/presentation/pages/login_page.dart';
import 'package:store_app/presentation/widgets/common_text.dart';
import 'package:store_app/presentation/widgets/rounded_cached_image.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final double buttonHeight = 50;

  final double buttonWidth = 100;

  final double mainContainerHeight = 400;

  @override
  void initState(){
    BlocProvider.of<AccountCubit>(context).loadAccountPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(builder: (context, state){
      if(state is AccountPageLoadingState){
        return Scaffold(body: Center(child: CircularProgressIndicator(),),);
      } else if(state is AccountPageErrorState){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        return Container();
      } else if(state is AccountPageLoadedState){
        return Scaffold(
          body: Stack(children: [
            Container(
                width: double.maxFinite,
                height: mainContainerHeight,
                decoration: BoxDecoration(color: AppColors.green1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedCachedImage(imgUrl: state.imgLink, radius: 70),
                      SizedBox(height: 20,),
                      CommonText(
                          text: state.fullName,
                          size: 20,
                          color: Colors.white,
                          font: 'SFPRODISPLAYMEDIUM'),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(text: 'email', size: 14, color: Colors.white,),
                                SizedBox(height: 5,),
                                CommonText(text: state.email, size: 14, color: Colors.white,)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonText(text: 'phone', size: 14, color: Colors.white,),
                                SizedBox(height: 5,),
                                CommonText(text: state.phoneNumber, size: 14, color: Colors.white,)
                              ],
                            )
                          ],
                        ),
                      )
                    ])),
            Container(width: double.maxFinite, height: double.maxFinite,),
            Positioned(
                left: MediaQuery.of(context).size.width / 2 - buttonWidth / 2,
                top: mainContainerHeight - buttonHeight / 2,
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      BlocProvider.of<AccountCubit>(context).logOut(context);
                    },
                    child: CommonText(text: 'Log out', size: 14, color: Colors.white),
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                  ),
                ))
          ]),
        );
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        return Container();
      }
    });

  }
}
