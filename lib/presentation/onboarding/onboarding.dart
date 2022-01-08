import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_archi/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardTitle1, AppStrings.onBoardSubTitle1,
            ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardTitle2, AppStrings.onBoardSubTitle2,
            ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardTitle3, AppStrings.onBoardSubTitle3,
            ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardTitle4, AppStrings.onBoardSubTitle4,
            ImageAssets.onBoardingLogo4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkPrimary,
      appBar: AppBar(
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index){
            return Container();
          }),
    );
  }
}

class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(this.title, this.subtitle, this.image);
}
