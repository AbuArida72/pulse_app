
import 'package:pulse/helpers/strings.dart';

class OnBoardingItem {
  final String? title;
  final String? image;
  final String? subImage;

  const OnBoardingItem({this.title, this.image, this.subImage});
}

class OnBoardingItems {
  static List<OnBoardingItem> loadOnboardItem () {
    const fi = <OnBoardingItem> [
      OnBoardingItem(
        title: Strings.title1,
        image: 'assets/images/onboard/1.png',
        subImage: 'assets/images/onboard/sub.png',
      ),
      OnBoardingItem(
          title: Strings.title2,
        image: 'assets/images/onboard/2.png',
        subImage: 'assets/images/onboard/sub.png',
      ),
      OnBoardingItem(
          title: Strings.title3,
          image: 'assets/images/onboard/3.png',
        subImage: 'assets/images/onboard/sub.png',
      ),
    ];
    return fi;
  }
}