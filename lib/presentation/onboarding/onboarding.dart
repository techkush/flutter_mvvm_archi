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

  List<SliderObject> _getSliderData() =>
      [
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
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(_list[index]);
          }),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100 + MediaQuery.of(context).padding.bottom,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  )),
            ),
            // add layout for indicator and arrows
            Container(
              color: ColorManager.primary,
              child: Column(
                children: [
                  _getBottomSheetWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: const SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.chevron_left, color: Colors.white,),
              ),
              onTap: () {
                _pageController.animateToPage(_getPreviousIndex(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
          // circle indicators

          Row(
            children: [
              for(int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getPropertiesCircle(i),
                )
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: const SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(Icons.chevron_right, color: Colors.white,),
              ),
              onTap: (){
                _pageController.animateToPage(_getNextIndex(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          )
        ],
      ),
    );
  }

  int _getPreviousIndex(){
    int previousIndex = _currentIndex --;
    if(previousIndex == -1){
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  int _getNextIndex(){
    int nextIndex = _currentIndex ++;
    if(nextIndex >= _list.length){
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  Widget _getPropertiesCircle(int index) {
    if (index == _currentIndex) {
      return const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 10,);
    } else {
      return const Icon(Icons.circle, color: Colors.white, size: 10,);
    }
  }
}


class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        // Image Widget
        Image(
          image: AssetImage(_sliderObject.image),
        )
      ],
    );
  }
}

class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(this.title, this.subtitle, this.image);
}
