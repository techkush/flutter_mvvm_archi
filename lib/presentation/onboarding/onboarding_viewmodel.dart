import 'dart:async';

import 'package:flutter_mvvm_archi/domain/model.dart';
import 'package:flutter_mvvm_archi/presentation/base/baseview_model.dart';
import 'package:flutter_mvvm_archi/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_archi/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex ++;
    if(nextIndex >= _list.length){
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex --;
    if(previousIndex == -1){
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  // private functions
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

  _postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext();

  void goPrevious();

  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to the stream -- stream input
}

// output mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
