import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/core/colors.dart';
import 'package:store_app/presentation/widgets/common_text.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  final String content = '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tempus eu egestas aliquam aliquet massa tellus ut mi. Augue sodales laoreet mi gravida vehicula condimentum faucibus nascetur enim. Amet vitae dui nunc, bibendum felis in amet. Et, consectetur mauris lobortis at magna. Leo odio lacus scelerisque at enim.

Vivamus dignissim amet dolor elit dolor sagittis a facilisis nam. Gravida senectus sit sem odio ac eget. Hendrerit suspendisse eros egestas mattis. Purus aliquam ut risus, leo quis et, neque, ultrices magna. Quisque adipiscing nunc bibendum cras lacus varius cursus. In odio mauris aliquet a non mauris. Donec nam cras vitae at placerat ac.
Quis et amet, tincidunt diam egestas nisl, felis donec. Quam lorem arcu, hac sed. A, tincidunt aliquam pulvinar id. Arcu, pellentesque in ullamcorper interdum neque. Massa, eu a scelerisque varius. Sodales sapien, elementum eu, nibh adipiscing vitae nullam fringilla etiam.

Egestas egestas quis pretium fermentum. Enim massa in consectetur integer sit sed. Nulla quam amet nisi ornare volutpat. Adipiscing adipiscing sed in venenatis luctus ut. Aliquam nunc est blandit ut. Aliquam senectus duis pellentesque egestas. Molestie tortor, volutpat quis ultricies gravida nam dignissim. In etiam risus euismod tellus condimentum ipsum convallis dui. Vel in sed varius magnis. Quis tortor metus habitasse egestas senectus volutpat non id. Augue lorem nunc morbi nam pharetra. Eu vehicula aliquam suscipit orci at orci, venenatis. Fames arcu, nibh id nibh. Elementum justo, pellentesque tincidunt vulputate ante eget dui arcu laoreet.
Leo egestas suspendisse suspendisse leo. Sapien tempor ut in molestie. Dui convallis massa et elementum tempus mauris neque placerat. Convallis quisque ut posuere at lectus suscipit suscipit adipiscing dictum. Metus arcu, vitae sem dolor. At ut donec non ipsum pharetra eu justo. Ac pellentesque turpis urna vel mi sed viverra. Scelerisque ultrices netus egestas cras adipiscing placerat tortor. Viverra in ullamcorper duis risus ridiculus lectus porttitor ac nibh. Aliquam turpis neque integer nisl morbi id egestas dis. Cursus sed vestibulum libero sed eget purus. Mauris maecenas morbi id cursus diam. Justo, eget et vitae non. Sagittis, ornare varius ipsum mi massa consectetur vulputate morbi.
Sed massa magna interdum eget felis netus. Neque nunc feugiat molestie vulputate commodo, vestibulum enim, amet. Eget turpis egestas pretium velit. Id nisl lacus facilisi senectus neque et urna. A diam orci aliquet purus. Senectus ultricies rhoncus feugiat eu cursus venenatis donec in elit. Dui justo, sit enim id facilisi. Ipsum turpis duis arcu at porttitor. Eleifend aliquet penatibus elementum morbi ut eget pellentesque faucibus. Rutrum donec id tellus ultrices convallis lectus. Scelerisque porta mauris pellentesque tellus pulvinar adipiscing diam vitae interdum. Sem tincidunt duis hendrerit tristique integer. Pretium non tincidunt quisque consequat, senectus gravida gravida. Neque, a, egestas amet congue iaculis purus, purus viverra blandit. Vel sapien sed aenean vel velit.
Eget tellus egestas laoreet arcu integer tellus nunc. Tellus, suspendisse lorem non nisl. Duis tellus mauris risus condimentum lorem sit risus tellus. Tellus bibendum lobortis gravida proin semper libero tortor placerat tellus. Mauris tortor aliquam quam sed aliquet ullamcorper at ridiculus in. Sit aliquet netus tellus in ridiculus purus pellentesque ut. Venenatis mattis augue a mollis posuere. Sit purus consectetur amet enim lectus arcu volutpat. Morbi lectus ullamcorper praesent augue dignissim tristique convallis lacus. Volutpat mi quam amet malesuada at fringilla.
Dolor ac massa faucibus feugiat dolor pulvinar montes. Eget donec netus nec faucibus viverra. Tempor malesuada dictum nisl morbi curabitur nunc, sit arcu ornare. Donec odio at ac in nec amet. Vel cras lacus feugiat sit. Quisque ac massa tortor lacus commodo, dictum pretium. Et, lorem vitae, id adipiscing nisi lorem orci, tristique ipsum. Bibendum fames viverra feugiat etiam maecenas est at vitae. Ultrices sapien adipiscing arcu tellus diam, a libero, ipsum morbi. Et aliquam volutpat scelerisque lorem. Elementum semper mattis sit platea lacus fermentum molestie. Dui, viverra vitae et aliquet cursus fermentum sit.
Blandit mauris, nisl turpis eget cras proin. Velit sem nisi, et ipsum et quam varius enim. Commodo neque iaculis feugiat id ultrices euismod facilisis. Pellentesque sed orci, egestas nulla nulla. Euismod aenean tortor at sit cras ac elit nibh. Dui massa rhoncus consequat faucibus neque, at. Gravida vulputate donec lectus purus morbi facilisi sollicitudin venenatis ultrices. Integer adipiscing urna maecenas dui natoque. Neque nibh morbi risus et, at bibendum. Pharetra proin cras eget risus, netus pharetra, bibendum quisque. Turpis at arcu, tellus fusce. Vulputate aliquet et, rhoncus a amet pellentesque nec magna. Eget et amet, enim, at. Ullamcorper ullamcorper hac venenatis, euismod ac in elementum. Amet facilisis nulla pulvinar bibendum id cum adipiscing sem.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 34, left: 9, bottom: 34),
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
            CommonText(
              text: 'Terms of Service',
              size: 26,
              font: 'SFPRODISPLAYBOLD',
            ),
            SizedBox(height: 28,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: CommonText(text: content, size: 14, color: AppColors.grey2, lineHeight: 1.9,),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
