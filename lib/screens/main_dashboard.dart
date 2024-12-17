// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse/screens/dashboard/filter_screen.dart';
import 'package:pulse/screens/dashboard/home_screen.dart';
import 'package:pulse/screens/dashboard/medicine_bag_screen.dart';
import 'package:pulse/screens/dashboard/my_order_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            )
        ),
        child: BottomNavigationBar(
            elevation: 25,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex ,
            onTap: _onTapIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/home.svg',
                  ),
                  label: "home",
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: currentIndex == 0 ? Container(
                      height: 6,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2)
                      ),
                    ) : Container(),
                  )
              ),
              BottomNavigationBarItem(
                label: "Search",
                  icon: SvgPicture.asset(
                    'assets/svg/location.svg',
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: currentIndex == 1 ? Container(
                      height: 6,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2)
                      ),
                    ) : Container(),
                  )
              ),
              BottomNavigationBarItem(
                label: "Bag",
                  icon: SvgPicture.asset(
                    'assets/svg/bag.svg',
                    color: currentIndex == 2 ? Colors.red : Colors.grey,
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: currentIndex == 2 ? Container(
                      height: 6,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2)
                      ),
                    ) : Container(),
                  )
              ),
              BottomNavigationBarItem(
                label: "Order",
                  icon: SvgPicture.asset(
                    'assets/svg/document.svg',
                    color: currentIndex == 3 ? Colors.red : Colors.grey,
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: currentIndex == 3 ? Container(
                      height: 6,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2)
                      ),
                    ) : Container(),
                  )
              ),
            ]
        ),
      ),
      body: goToScreen(currentIndex),
    );
  }
  _onTapIndex(index) {
    setState(() {
      currentIndex = index;
      print('index: $index');
    });
    goToScreen(currentIndex);
  }
  goToScreen(int currentIndex) {
    print('indexx: $currentIndex');
    switch(currentIndex){
      case 0:
        return HomeScreen();
      case 1:
        return FilterScreen();
      case 2:
        return MedicineBagScreen();
      case 3:
        return MyOrderScreen();
    }
  }
}
