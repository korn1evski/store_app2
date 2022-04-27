import 'package:flutter/material.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 74, bottom: 74),
          child: CommonText(
            text: 'Favorites products',
            size: 18,
            font: 'SFPRODISPLAYBOLD',
          ),
        ),

      ],
    );
  }
}
