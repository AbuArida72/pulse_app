import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/widgets/back_widget.dart';
class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}
enum SingingCharacter { all, tablets, syrup, vitamin}
class _FilterScreenState extends State<FilterScreen> {
  SingingCharacter _character = SingingCharacter.all;
  List typeList = ['All', 'tablets', 'syrup', 'vitamin'];
  List brandList = ['Kukis', 'Oscan', 'Okasa', 'Bescikos', 'Olo', 'Olisa'];
  List mgList = ['25', '50', '100', '250', '500'];
  List sortByList = ['low to high', 'high to low', 'popular'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              BackWidget(name: Strings.filtersBy,),
              bodyWidget(context),
              applyFilterWidget(context)
            ],
          ),
        ),
      ),
    );
  }
  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 60),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productTypeWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            brandWidget(context),
            mgWidget(context),
            sortByWidget(context)
          ],
        ),
      )
    );
  }
  productTypeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.productType,
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: Colors.black
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Radio(
                  value: SingingCharacter.all,
                  toggleable: true,
                  autofocus: true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                Text(
                  typeList[0],
                  style: CustomStyle.textStyle,
                ),
                Radio(
                  value: SingingCharacter.tablets,
                  toggleable: true,
                  autofocus: true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                Text(
                  typeList[1],
                  style: CustomStyle.textStyle,
                ),
                Radio(
                  value: SingingCharacter.syrup,
                  toggleable: true,
                  autofocus: true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                Text(
                  typeList[2],
                  style: CustomStyle.textStyle,
                ),
                Radio(
                  value: SingingCharacter.vitamin,
                  toggleable: true,
                  autofocus: true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                    });
                  },
                ),
                Text(
                  typeList[3],
                  style: CustomStyle.textStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  brandWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.brand,
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: Colors.black
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: GridView.count(
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  brandList.length, (index) {
                return TextButton(
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: CustomColor.secondary,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 0.5))
                    ),
                    child: Center(
                      child: Text(
                        brandList[index],
                        style: TextStyle(
                            fontSize: Dimensions.smallTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    /*if (!slot.isAvailable) {
                      print('already booked');
                      Fluttertoast.showToast(msg: Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    } else {
                      setState(() {
                        list[index] = !list[index];
                      });
                      print('you can book this slot: ' + list.toString());
                    }*/
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  mgWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.mg,
            style: TextStyle(
                fontSize: Dimensions.largeTextSize,
                color: Colors.black
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: GridView.count(
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  mgList.length, (index) {
                return TextButton(
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: CustomColor.secondary,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 0.5))
                    ),
                    child: Center(
                      child: Text(
                        '${mgList[index]}mg',
                        style: TextStyle(
                            fontSize: Dimensions.smallTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    /*if (!slot.isAvailable) {
                      print('already booked');
                      Fluttertoast.showToast(msg: Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    } else {
                      setState(() {
                        list[index] = !list[index];
                      });
                      print('you can book this slot: ' + list.toString());
                    }*/
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  sortByWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.sortBy,
            style: TextStyle(
                fontSize: Dimensions.largeTextSize,
                color: Colors.black
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: GridView.count(
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  sortByList.length, (index) {
                return TextButton(
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: CustomColor.secondary,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 0.5))
                    ),
                    child: Center(
                      child: Text(
                        sortByList[index],
                        style: TextStyle(
                            fontSize: Dimensions.smallTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    /*if (!slot.isAvailable) {
                      print('already booked');
                      Fluttertoast.showToast(msg: Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    } else {
                      setState(() {
                        list[index] = !list[index];
                      });
                      print('you can book this slot: ' + list.toString());
                    }*/
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  applyFilterWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize * 3,
          right: Dimensions.marginSize * 3,
        ),
        child: GestureDetector(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.circular(Dimensions.radius * 2)
            ),
            child: Center(
              child: Text(
                Strings.applyFilter.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop(
            );
          },
        ),
      ),
    );
  }
}
