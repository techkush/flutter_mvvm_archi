import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_archi/domain/model.dart';
import 'package:flutter_mvvm_archi/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_mvvm_archi/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot){
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SlideViewObject? slideViewObject){
    if(slideViewObject == null){
      return Container();
    }else{
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
            itemCount: slideViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(slideViewObject.sliderObject);
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
                    _getBottomSheetWidget(slideViewObject),
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

  }

  Widget _getBottomSheetWidget(SlideViewObject slideViewObject) {
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
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
          // circle indicators

          Row(
            children: [
              for(int i = 0; i < slideViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getPropertiesCircle(i, slideViewObject.currentIndex),
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
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getPropertiesCircle(int index, int _currentIndex) {
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

