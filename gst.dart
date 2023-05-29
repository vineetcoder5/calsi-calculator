import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_parser/math_parser.dart';

class gst extends StatefulWidget {
  const gst({super.key});

  @override
  State<gst> createState() => _gstState();
}

class _gstState extends State<gst> {
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
  double gst_percent = 20.0;
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
              child: Text("Gst bill",style: TextStyle(fontSize: 30.h, fontWeight: FontWeight.bold,color: Colors.white))
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 190.h,
              width: 100.sw,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Creates border
                    color: Color.fromARGB(239, 76, 175, 79),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: AlignmentDirectional.topCenter,
                    child: Text("Bill",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: AlignmentDirectional.topCenter,
                    child: Text("\$"+bill,style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  ),
                   Container(
                    child: Row(
                      children: [
                       Container(
                        margin: EdgeInsets.only(top: 25,left: 60.w),
                        child: Text("Gst",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                       ),
                       Container(
                        margin: EdgeInsets.only(top: 25,left: 130.w),
                        child: Text("Total",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                       )
                      ],
                    ),
                    // margin: EdgeInsets.only(top: 30,),
                    // alignment: AlignmentDirectional.bottomStart,
                    // child: Text("Gst",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  ),
                  Container(
                    child: Row(
                      children: [
                       SizedBox(
                        width: 200,
                        height: 40,
                         child: Container(
                          // color: Colors.amber,
                          margin: EdgeInsets.only(left: 10.w),
                          child: FittedBox(
                            alignment: AlignmentDirectional.center,
                            child: Text("\$"+(split(double.parse(bill), gst_percent)-double.parse(bill)).toStringAsFixed(2),style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w800),)),
                         ),
                       ),
                        SizedBox(
                        width: 160,
                        height: 40,
                         child: Container(
                          // color: Colors.amber,
                          margin: EdgeInsets.only(left: 10.w),
                          child: FittedBox(
                            alignment: AlignmentDirectional.center,
                            child: Text(split(double.parse(bill), gst_percent).toStringAsFixed(2),style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w800),)),
                         ),
                       ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,bottom: 5),
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  Container(
                     margin: EdgeInsets.only(left: 4),
                    child: SizedBox(
                      width: 85.w,
                      child: Text("Gst "+ gst_percent.toInt().toString()+"%",style: TextStyle(fontSize: 20,color: Colors.white),)
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
                                value: gst_percent,
                                max: 50.0,
                                min: 0.0,
                                divisions: 100,
                                label: gst_percent.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    gst_percent = value;
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
              margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 20),
              height: 75.h,
              width: 100.sw,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Creates border
                    color:Color.fromARGB(239, 76, 175, 79),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Total Amount = ",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    child: Text(split(double.parse(bill), gst_percent).toStringAsFixed(2),style: TextStyle(fontSize: 27,fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            ),
            Container(
              height: 385.h,
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
num split(double bill,double gst_percent){
  var ansswer = ((((bill*gst_percent)/100)+bill)).toString();
  final expression = MathNodeExpression.fromString(ansswer,).calc(MathVariableValues({}), );

  return expression;
}