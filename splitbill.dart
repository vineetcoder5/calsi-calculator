import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_parser/math_parser.dart';

class splitbill extends StatefulWidget {
  const splitbill({super.key});

  @override
  State<splitbill> createState() => _splitbillState();
}

class _splitbillState extends State<splitbill> {
  late BannerAd _bannerAd;
  bool _isAdloaded = false;
  final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-7887859852662981/9055246178'
    : 'ca-app-pub-7887859852662981/3419776114';
  @ override
  void initState() {
    super.initState();
    _initBannerAd();
  }
  _initBannerAd(){
    _bannerAd = BannerAd(size: AdSize.fullBanner, adUnitId: 'ca-app-pub-3940256099942544/6300978111', listener: BannerAdListener(
      onAdLoaded: (ad){
        setState(() {
          _isAdloaded = true;
        });
      },
      onAdFailedToLoad: (ad, error){
        debugPrint('BannerAd failed to load: $error');
          // Dispose the ad here to free resources.
        ad.dispose();
      },
    ), request: AdRequest());
    _bannerAd.load();
  }
  double persons = 20;
  double tip_percent = 20;
  String bill = "0.00";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              // child: _isAdloaded ? AdWidget(ad: _bannerAd): Container(),
              child:  AdWidget(ad: _bannerAd),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,top: 5),
              height: 50.h,
              width: 100.sw,
              // color: Colors.green,
              child: Text("Split bill",style: TextStyle(fontSize: 30.h, fontWeight: FontWeight.bold,color: Colors.white))
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 125.h,
              width: 100.sw,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Creates border
                    color: Color.fromARGB(239, 76, 175, 79),
              ),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 150.w,
                          // color: Colors.deepOrange,
                          margin: EdgeInsets.only(left: 30,top: 20),
                          child: Text("Total",style: TextStyle(fontSize: 25.h,fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,left: 30),
                          height: 50.h,
                          width: 160.w,
                          // color: Colors.cyan,
                          child: FittedBox(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(bill.toString(),style: TextStyle(fontSize: 40.h,fontWeight: FontWeight.w600),)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.cyan,
                    margin: EdgeInsets.only(left: 30),
                    width: 155.w,
                    // alignment: AlignmentDirectional.topStart,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          // color: Colors.blue,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Bill "+bill.toString(),style: TextStyle(fontSize: 20.h,fontWeight: FontWeight.w700),),
                        ),
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          margin: EdgeInsets.only(top: 5),
                          child: Text("Friends "+persons.toInt().toString(),style: TextStyle(fontSize: 20.h,fontWeight: FontWeight.w700),),
                        ),Container(
                          alignment: AlignmentDirectional.topStart,
                          margin: EdgeInsets.only(top: 5),
                          child: Text("Tip  "+tip_percent.toInt().toString()+"%",style: TextStyle(fontSize: 20.h,fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30,left: 20),
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  Container(
                    child: const Icon(
                      Icons.person_3_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 24.0,
                    ),
                  ),
                  Container(
                     margin: EdgeInsets.only(left: 4,right: 5),
                    child: SizedBox(
                      width: 55.w,
                      child: Text("x "+ persons.toInt().toString(),style: TextStyle(fontSize: 20,color: Colors.white),)
                      ),
                  ),
                  Container(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Color.fromARGB(255, 146, 198, 250),
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 7.0,
                      thumbColor: Color.fromARGB(255, 218, 219, 221),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayColor: Colors.red.withAlpha(32),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                      child: Container(
                        width: 300.w,
                        child: Slider(
                                value: persons,
                                min: 1,
                                max: 100,
                                divisions: 99,
                                label: persons.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    persons = value;
                                  });
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20),
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  Container(
                     margin: EdgeInsets.only(left: 4),
                    child: SizedBox(
                      width: 85.w,
                      child: Text("Tip "+ tip_percent.toInt().toString()+"%",style: TextStyle(fontSize: 20,color: Colors.white),)
                      ),
                  ),
                  Container(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Color.fromARGB(255, 146, 198, 250),
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 7.0,
                      thumbColor: Color.fromARGB(255, 218, 219, 221),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayColor: Colors.red.withAlpha(32),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                      child: Container(
                        width: 300.w,
                        child: Slider(
                                value: tip_percent,
                                max: 50,
                                divisions: 50,
                                label: tip_percent.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    tip_percent = value;
                                  });
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 15),
              height: 75.h,
              width: 100.sw,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Creates border
                    color:Color.fromARGB(239, 76, 175, 79),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 60),
                    child: const Icon(
                      Icons.person_2_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 50.0,
                    ),
                  ),
                  Container(
                    child: Text(" X1 = ",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    child: Text(split(persons, double.parse(bill), tip_percent).toStringAsFixed(2),style: TextStyle(fontSize: 27,fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            ),
            Container(
              height: 375.h,
              // color: Colors.amber,
              margin: EdgeInsets.only(top: 5.h,bottom: 15,right: 15,left: 15),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                               bill =  bill=="0.00"? "1": bill+"1";
                              });
                            },
                                child: Text("1",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                               bill =  bill=="0.00"? "2": bill+"2";
                              });
                            },
                                child: Text("2",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                               bill =  bill=="0.00"? "3": bill+"3";
                              });
                            },
                                child: Text("3",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),        
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                            setState(() {
                              bill =  bill=="0.00"? "4": bill+"4";
                              });
                            },
                                child: Text("4",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                               bill =  bill=="0.00"? "5": bill+"5";
                              });
                            },
                                child: Text("5",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                bill =  bill=="0.00"? "6": bill+"6";
                              });
                            },
                                child: Text("6",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),        
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                             setState(() {
                                bill =  bill=="0.00"? "7": bill+"7";
                              });
                            },
                                child: Text("7",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                 bill =  bill=="0.00"? "8": bill+"8";
                              });
                            },
                                child: Text("8",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                 bill =  bill=="0.00"? "9": bill+"9";
                              });
                            },
                                child: Text("9",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),        
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                             setState(() {
                                bill =  bill=="0.00"? "0": bill+"0";
                              });
                            },
                                child: Text("0",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                  if(!bill.contains('.')){
                                    bill  = bill+".";
                                  }
                          
                              });
                            },
                                child: Text(".",style: TextStyle(fontSize: 39.h),),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                  if(bill == "0.00" || bill.length==0 || bill.length==1){
                                      bill = "0.00";
                                    }else{
                                      bill = bill.substring(0,bill.length-1);
                                    }
                              });
                            },
                              child: Image.asset('images/delete.png',color: Colors.white,),
                              style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                              padding: EdgeInsets.all(12.h),
                                ),
                          ),
                        ),        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
num split(double persons,double bill,double tip_percent){
  var ansswer = ((((bill*tip_percent)/100)+bill)/persons).toString();
  final expression = MathNodeExpression.fromString(ansswer,).calc(MathVariableValues({}), );

  return expression;
}