import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/data/supplement.dart';
import 'package:pulse/widgets/add_quantity_widget.dart';

class MedicineDetailScreen extends StatefulWidget {
  final Supplement? supplement;
  const MedicineDetailScreen({Key? key, this.supplement}) : super(key: key);
  @override
  _MedicineDetailScreenState createState() => _MedicineDetailScreenState();
}
class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  List list = [];
  String selectedVolume = '';
  List faqList = ['Indications', 'Therapeutic Class', 'Interaction', 'Side Effects', 'Overdose '
      'Effects', 'Storage Conditions'];
  @override
  void initState() {
    super.initState();
    getAvailableList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Strings.medicineBag),),
      body: SingleChildScrollView(
          child: Column(
            children: [
              bodyWidget(context),
              addToCartWidget(context)
            ],
          ),
        ),
    );
  }
  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0, bottom: 100),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            medicineDetailsWidget(context),
            SizedBox(height: Dimensions.heightSize * 3,),
            detailsWidget(context),
            faqWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            recommendMedicineWidget(context),
            SizedBox(height: Dimensions.heightSize,)
          ],
        ),
      ),
    );
  }
  medicineDetailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius),
                    topRight: Radius.circular(Dimensions.radius))
              ),
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Image.asset(
                      widget.supplement?.image ?? "",
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 30,
                      right: -40,
                      child: Container(
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                          color: CustomColor.primary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(1, 1), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${widget.supplement?.discount}% OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(widget.supplement!.volumeList!.length, (index) {
                    return TextButton(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: list[index] ? CustomColor.primary :
                            CustomColor.secondary,
                            border: Border.all(color: CustomColor.primary.withOpacity(0.3), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                        ),
                        child: Center(
                          child: Text(
                            '${widget.supplement?.volumeList?[index]} mg',
                            style: TextStyle(
                                fontSize: Dimensions.smallTextSize,
                                fontWeight: FontWeight.bold,
                              color: list[index] ? Colors.white
                                  : CustomColor.primary
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          list[index] = !list[index];
                          selectedVolume = widget.supplement!.volumeList![index];
                        });
                      },
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void getAvailableList() {
    List<dynamic> value = [false, false, false, false] ;
    for( int i = 0; i < value.length; i++){
      var data = value[i];
      print(data);
      list.add(data);
    }
  }
  detailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.supplement?.name ?? "",
                        style: TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Text(
                        '${selectedVolume}mg',
                        style: TextStyle(
                          fontSize: Dimensions.largeTextSize,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Text(
                    'Bottle of $selectedVolume tablets',
                    style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            widget.supplement?.rating ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${widget.supplement?.newPrice}',
                    style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize,
                        color: CustomColor.primary,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Text(
                    '\$${widget.supplement?.newPrice}',
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2,
              bottom: Dimensions.heightSize,
            ),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          widget.supplement?.needPrescription ?? false ? Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColor.secondary,
              borderRadius: BorderRadius.circular(Dimensions.radius)
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
                top: Dimensions.heightSize,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.prescriptionRequired,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.largeTextSize
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Text(
                    widget.supplement?.description ?? "",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Dimensions.defaultTextSize
                    ),
                  ),
                ],
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }
  faqWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: faqList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 1,
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      title: Text(
                        faqList[index],
                        style: CustomStyle.textStyle,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                              .marginSize, bottom:
                          Dimensions.heightSize),
                          child:  ListTile(
                            title: Text(
                              widget.supplement?.description ?? "",
                              style: CustomStyle.textStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
  recommendMedicineWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.recommendMedicine,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.black
                ),
              ),
              Text(
                Strings.seeAll,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: SupplementList.list().length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Supplement supplement = SupplementList.list()[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                    .marginSize * 0.5),
                child: GestureDetector(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 220,
                          decoration: BoxDecoration(
                              color: CustomColor.secondary,
                              borderRadius: BorderRadius.circular(Dimensions.radius)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.marginSize * 0.5, right: Dimensions.marginSize * 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      supplement.image ?? "",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'USD ${supplement.newPrice}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.extraLargeTextSize
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.heightSize * 0.5,),
                                        Text(
                                          '\$${supplement.oldPrice}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Dimensions.largeTextSize,
                                              decoration: TextDecoration.lineThrough
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize * 0.5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          supplement.name ?? "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.extraLargeTextSize
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.heightSize * 0.5,),
                                        Text(
                                          'Bottle of ${supplement.piece} tablets',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Dimensions.defaultTextSize
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 20,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primary,
                                          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '4.5',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Dimensions.defaultTextSize
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.widthSize * 0.1,),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 25,
                            width: 60,
                            decoration: BoxDecoration(
                                color: CustomColor.primary,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius))
                            ),
                            child: Center(
                              child: Text(
                                '${supplement.discount}% OFF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.smallTextSize
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        MedicineDetailScreen(supplement: supplement)));
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
  addToCartWidget(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 2),
            topRight: Radius.circular(Dimensions.radius * 2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'USD 76.00',
                      style: TextStyle(
                        color: CustomColor.primary,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      Strings.total,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.largeTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: AddQuantityWidget()
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius * 2)
                    ),
                    child: Center(
                      child: Text(
                        Strings.addToCart.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Strings.successfullyAddedCart))
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
