
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_parser/math_parser.dart';
import 'converter.dart';
import 'dart:io' show Platform;

import 'financial.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with TickerProviderStateMixin{
  
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
  var question = "";
  var realquestion = "";
  var answer = "=";
  int specialoperator = 0;
  int pointacess = 1;
  int bracketcounter=0;
  var degcon = "rad";
  var updrealquestion;
  var bracketpos="F";
  bool scientific = false;
  final List<String> fourdel = <String>['sin(', 'cos(','tan(','log('];
  final List<String> fivedel = <String>['asin(', 'acos(','atan('];
  final List<String> numbers = <String>['1', '2', '3','4','5','6','7','8','9','0'];
  var pastquestion = <String>[];
  var pastanswer = <String>[];
  var pastrealquestion = <String>[];
  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 3, vsync: this);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("AD mob"),
      // ),
      body: SafeArea(
        child: SnappingSheet(     
          lockOverflowDrag: true,
          snappingPositions: const [
          SnappingPosition.factor(
            positionFactor: 0.68,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: Duration(seconds: 1),
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          // SnappingPosition.factor(
          //   snappingCurve: Curves.elasticOut, 
          //   snappingDuration: Duration(milliseconds: 1750),
          //   positionFactor: 0.7,
          // ),
          SnappingPosition.factor(
            grabbingContentOffset: GrabbingContentOffset.bottom,
            snappingCurve: Curves.easeInExpo,
            snappingDuration: Duration(seconds: 1),
            positionFactor: 0.455,
          ),
        ],
        grabbing: Container(
          decoration: BoxDecoration(
          color: Color.fromARGB(255, 36, 36, 36),
          borderRadius: BorderRadius.vertical( top: Radius.circular(0),bottom: Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              // child: _isAdloaded ? AdWidget(ad: _bannerAd): Container(),
              child:  AdWidget(ad: _bannerAd),
            ),
            // Container(
            //   width: _bannerAd.size.width.toDouble(),
            //   height: _bannerAd.size.height.toDouble(),
            //   child: AdWidget(ad: _bannerAd),
            // ),
            Container(
            alignment: AlignmentDirectional.topEnd,
            child: SizedBox(
              width: 100.sw,
              height: 115.h,
              child: Container(
                margin: EdgeInsets.only(right: 14,left: 14),
                alignment: AlignmentDirectional.centerEnd,
              child: question.length<18 ? FittedBox(
                alignment: AlignmentDirectional.centerEnd,
                // fit: BoxFit.fitHeight, 
                child: Text(question,style: TextStyle(fontSize: 50,color: Colors.white,)),
              ) : SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(question,style: TextStyle(fontSize: 42,color: Colors.white,),),
              ),
              ),
            ),  
            ),
             Container(
            margin: EdgeInsets.only(right: 14,left: 14),
            alignment: AlignmentDirectional.topEnd,
            child: SizedBox(
              // width: 390,
              width: 100.sw,
              height: 78.h,
              child: Container(
              child: answer.length<20 ? FittedBox(
                alignment: AlignmentDirectional.centerEnd,
                // fit: BoxFit.fitHeight, 
                child: Text(answer,style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: 'Heebo'),),
              ) : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(answer,style: TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'Heebo'),),
              ),
              ),
            ),  
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.only(bottom: 10),
              width: 100,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
        ),
        grabbingHeight: 290.h,
        sheetBelow: SnappingSheetContent(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
             Container(
              color: Colors.black12,
              alignment: AlignmentDirectional.topStart,
              child: Container(
                child: Column(
                  children: <Widget>[
                   Container(
                    alignment: Alignment.center,
                    // color: Colors.amber,
                    // margin: EdgeInsets.only(bottom: 10),
                    height: 75.h,
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabcontroller,
                      indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), // Creates border
                            color: Color.fromARGB(255, 105, 105, 105),
                      ),
                      tabs:   [
                        Tab(child: Text("calsi",style: TextStyle(fontSize: 20.h,fontFamily: 'Pacifico',))),
                        Tab(child: Text("converter",style: TextStyle(fontSize: 20.h,fontFamily: 'Pacifico',))),
                        Tab(child: Text("financial",style: TextStyle(fontSize: 20.h,fontFamily: 'Pacifico',))),
                      ]
                      ),
                   ),
                   Container(
                    // height: double.nan,
                    //  height: 10.spMax,
                    height: 535.h,
                    // height: 10.sh,
                    child: TabBarView(
                      controller: _tabcontroller,
                      children: [
                         Container(
                            child: scientific? 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  [
                                Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                if(specialoperator==0 || specialoperator==2){
                                                question = question + "\u221A(";
                                                realquestion = realquestion+"sqrt(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                              }else{
                                                question = question + "x\u221A(";
                                                realquestion = realquestion+"*sqrt(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                              }          
                                           });
                                            },
                                            child: Text("\u221A",style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question = question + "\u03C0";
                                                realquestion = realquestion+"pi";
                                                specialoperator=1;
                                                // bracketcounter = bracketcounter+1;
                                                
                                           });
                                            },
                                            child: Text("\u03C0",style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                        alignment: AlignmentDirectional.bottomCenter,
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              if (specialoperator==0){
                                                realquestion=realquestion.substring(0,realquestion.length-1) + "^";
                                                question = question.substring(0,question.length-1) +"^";
                                              }else if(specialoperator!=2){
                                                question=question+"^";
                                                realquestion = realquestion+"^";
                                                specialoperator = 0;
                                                pointacess=1;
                                                bracketpos="F";
                                              }
                                           });
                                            },
                                            child: Text("^",style: TextStyle(fontSize: 30.h), ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            alignment: AlignmentDirectional.bottomCenter,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"e";
                                                realquestion = realquestion+"e";
                                                specialoperator = 1;
                                                bracketpos="R";
                                           });
                                            },
                                            child: Text("e",style: TextStyle(fontSize: 20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (scientific){
                                                scientific = false;
                                              }else{
                                                scientific = true;
                                              }
                                           });
                                            },
                                          child: Image.asset('images/expandless.png',color: Colors.white,),
                                          style: ElevatedButton.styleFrom(
                                             backgroundColor:  Color.fromARGB(255, 105, 105, 105),
                                            // shape: RoundedRectangleBorder(
                                            //   borderRadius: BorderRadius.circular(20),
                                            // ),
                                            shape: CircleBorder(),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),)
                                  ],
                                )),
                                Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"\u00B2";
                                                realquestion = realquestion+"^2";
                                                specialoperator = 1;
                                                bracketpos="R";
                                           });
                                            },
                                            child: Text("x\u00B2",style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(degcon=="deg"){
                                              degcon = "rad";
                                            }else{
                                               degcon = "deg";
                                            }
                                           });
                                            },
                                            child: Text(degcon,style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                            
                                                question=question+"sin(";
                                                realquestion = realquestion+"sin(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                                // bracketpos="R";
                                           });
                                            },
                                            child: Text("Sin",style: TextStyle(fontSize: 25.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"cos(";
                                                realquestion = realquestion+"cos(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                                // bracketpos="R";
                                           });
                                            },
                                            child: Text("Cos",style: TextStyle(fontSize: 25.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"tan(";
                                                realquestion = realquestion+"tan(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                           });
                                            },
                                            child: Text("Tan",style: TextStyle(fontSize: 25.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),)
                                  ],
                                )),
                                Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"ln(";
                                                realquestion = realquestion+"ln(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                           });
                                            },
                                            child: Text("ln",style: TextStyle(fontSize: 20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              question=question+"log(";
                                                realquestion = realquestion+"log(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                           });
                                            },
                                            child: Text("log",style: TextStyle(fontSize: 20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"sin\u207B\u00B9(";
                                                realquestion = realquestion+"asin(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                           });
                                            },
                                            child: Text("sin\u207B\u00B9",style: TextStyle(fontSize: 20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"cos\u207B\u00B9(";
                                                realquestion = realquestion+"acos(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                           });
                                            },
                                            child: Text("cos\u207B\u00B9",style: TextStyle(fontSize:  20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              question=question+"tan\u207B\u00B9(";
                                              realquestion = realquestion+"atan(";
                                              bracketcounter = bracketcounter+1;
                                              specialoperator = 2;
                                           });
                                            },
                                            child: Text("tan\u207B\u00B9",style: TextStyle(fontSize:  20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),)
                                  ],
                                )),
                                Expanded(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              question="";
                                              realquestion = "";
                                              answer = "=";
                                              specialoperator = 0;
                                              pointacess = 1;
                                              bracketpos="F";
                                              bracketcounter=0;
                                           });
                                            },
                                            child: Text("AC",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                            setState(() {
                                                if(specialoperator==0 || specialoperator==2){
                                                  question=question+"(";
                                                  realquestion = realquestion+"(";
                                                  bracketcounter = bracketcounter+1;
                                                  specialoperator = 2;
                                                }else{
                                                  question=question+"x(";
                                                  realquestion = realquestion+"*(";
                                                  bracketcounter = bracketcounter+1;
                                                  specialoperator = 2;
                                                }                               
                                            });
                                          },
                                            child: Text("( ",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(bracketcounter != 0 && specialoperator != 2){
                                              question=question+")";
                                              realquestion = realquestion+")";
                                              bracketcounter = bracketcounter-1;
                                              specialoperator = 12;
                                          }
                                        });
                                      },
                                            child: Text(" )",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "/";
                                              question = question.substring(0,question.length-1) +"\u00F7";
                                            }else if(specialoperator!=2){
                                              question=question+"\u00F7";
                                              realquestion = realquestion+"/";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                          child: Text('\u00F7',style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                // change
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x7";
                                            realquestion = realquestion+"*7";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"7";
                                          realquestion = realquestion+"7";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
                                        });
                                      },
                                            child: Text("7",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x8";
                                            realquestion = realquestion+"*8";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"8";
                                          realquestion = realquestion+"8";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
                                        });
                                      },
                                            child: Text("8",style: TextStyle(fontSize: 35.h),),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x9";
                                            realquestion = realquestion+"*9";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"9";
                                          realquestion = realquestion+"9";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
                                          
                                        });
                                      },
                                            child: Text("9",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "*";
                                              question = question.substring(0,question.length-1) +"x";
                                            }else if(specialoperator!=2){
                                              question=question+"x";
                                              realquestion = realquestion+"*";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("X",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x4";
                                              realquestion = realquestion+"*4";
                                              specialoperator = 1;
                                              bracketpos="R";
                                            }else{
                                            question=question+"4";
                                            realquestion = realquestion+"4";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                  
                                          });
                                        },
                                            child: Text("4",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x5";
                                            realquestion = realquestion+"*5";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"5";
                                            realquestion = realquestion+"5";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                    
                                          });
                                        },
                                            child: Text("5",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), 
                                           backgroundColor: Color.fromARGB(255, 30, 29, 29),//<-- SEE HERE
                                         padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x6";
                                            realquestion = realquestion+"*6";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"6";
                                            realquestion = realquestion+"6";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                        
                                          });
                                        },
                                            child: Text("6",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                                         padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                           if(realquestion.length != 0 && realquestion.substring(realquestion.length-1,realquestion.length)== "-"){
                                              question=question;
                                              realquestion = realquestion;
                                            }else{
                                              question=question+"-";
                                              realquestion = realquestion+"-";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("-",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x1";
                                            realquestion = realquestion+"*1";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"1";
                                            realquestion = realquestion+"1";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                          
                                          });
                                        },
                                            child: Text("1",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                            setState(() {
                                              if(specialoperator==12){
                                                question=question+"x2";
                                              realquestion = realquestion+"*2";
                                              specialoperator = 1;
                                              bracketpos="R";
                                              }else{
                                              question=question+"2";
                                              realquestion = realquestion+"2";
                                              specialoperator = 1;
                                              bracketpos="R";
                                              }
                                        
                                          });
                                        },
                                            child: Text("2",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x3";
                                              realquestion = realquestion+"*3";
                                              specialoperator = 1;
                                              bracketpos="R";
                              
                                            }else{
                                              question=question+"3";
                                              realquestion = realquestion+"3";
                                              specialoperator = 1;
                                              bracketpos="R";
                                            }
                                      
                                          });
                                        },
                                            child: Text("3",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "+";
                                              question = question.substring(0,question.length-1) +"+";
                                            }else if(specialoperator!=2){
                                              question=question+"+";
                                              realquestion = realquestion+"+";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("+",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                     child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                            question=question+"0";
                                            realquestion = realquestion+"0";
                                            specialoperator = 1;
                                            bracketpos="R";
                              
                                        });
                                      },
                                            child: Text("0",style: TextStyle(fontSize: 35.h),),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (pointacess==0){
                                              question=question;
                                            }else{
                                              question=question+".";
                                              realquestion = realquestion+".";
                                              specialoperator = 1;
                                              pointacess=0;
                                              bracketpos="R";
                                            }
                                          });
                                        },
                                            child: Text(".",style: TextStyle(fontSize: 35.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                           backgroundColor: Color.fromARGB(255, 30, 29, 29), //<-- SEE HERE
                                         padding: EdgeInsets.all(9.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(realquestion.length>=5 && (realquestion.substring(realquestion.length-5,realquestion.length) == "sqrt(")){
                                                    question = question.substring(0,question.length-2);
                                                    realquestion = realquestion.substring(0,realquestion.length-5);
                                                    bracketcounter = bracketcounter-1;                    
                                            }else if(realquestion.length>=3 && (realquestion.substring(realquestion.length-3,realquestion.length) == "ln(")){
                                                    question = question.substring(0,question.length-3);
                                                    realquestion = realquestion.substring(0,realquestion.length-3);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.length>=5 &&(fivedel.contains(realquestion.substring(realquestion.length-5,realquestion.length)))){
                                                    question = question.substring(0,question.length-6);
                                                    realquestion = realquestion.substring(0,realquestion.length-5);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.length>=4 &&(fourdel.contains(realquestion.substring(realquestion.length-4,realquestion.length)))){
                                                    question = question.substring(0,question.length-4);
                                                    realquestion = realquestion.substring(0,realquestion.length-4);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              bracketcounter = bracketcounter-1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              bracketcounter = bracketcounter+1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              pointacess = 1;
                                            }else{
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                            }
                                            if(realquestion.length==0){
                                              question="";
                                              realquestion = "";
                                              answer = "=";
                                              specialoperator = 0;
                                              pointacess = 1;
                                              bracketpos="F";
                                              bracketcounter=0;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="e"){
                                                specialoperator = 1;
                                            }else if(realquestion.length >= 2 && realquestion.substring(realquestion.length-2,realquestion.length)=="pi"){
                                                specialoperator = 1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="^"){
                                                specialoperator = 0;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                                specialoperator = 2;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                                specialoperator = 12;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                                specialoperator = 1;
                                                pointacess=0;
                                            }else if(numbers.contains(realquestion.substring(realquestion.length-1,realquestion.length))){
                                                specialoperator = 1;
                                            }else{
                                              specialoperator = 0;
                                              pointacess=1;
                                            }
                                          });
                                        },
                                          child: Image.asset('images/delete.png',color: Colors.white,),
                                         style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          padding: EdgeInsets.all(7.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                            setState(() {
                                              updrealquestion = realquestion;
                                              if (degcon=="deg"){
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)sin\('), 'sin((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)cos\('), 'cos((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)tan\('), 'tan((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'asin\('), '(180/pi)*asin(');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'acos\('), '(180/pi)*acos(');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'atan\('), '(180/pi)*atan(');
                                                // realquestion.replaceAll('cos(', 'cos(180/pi*');
                                                // realquestion.replaceAll('tan(', 'tan(180/pi*');
                                               }
                                               for (int i = 0; i < bracketcounter; i++) {
                                                  updrealquestion = updrealquestion+")";
                                              }
                                               //else if(degcon=="rad"){
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'sin\(pi\/180\*'), 'sin(');
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'cos\(pi\/180\*'), 'cos(');
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'tan\(pi\/180\*'), 'tan(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'asin\(pi\/180\*'), 'asin(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'acos\(pi\/180\*'), 'acos(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'atan\(pi\/180\*'), 'atan(');
                                              //   //  realquestion.replaceAll('cos(180/pi*','cos(');
                                              //   //  realquestion.replaceAll('tan(180/pi*','tan(');
                                              // }
                                              try{
                                                // var exp = Parser().parse(realquestion);
                                                // double evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
                                                // answer = (MathNodeExpression.fromString(realquestion)).calc() as String ;
                                                // print(evaluation);
                                                     final expression = MathNodeExpression.fromString(
                                                              updrealquestion,
                                                            ).calc(
                                                              MathVariableValues({}),
                                                            );
                                                            answer = expression.toString();
                                                            // answer = updrealquestion;
                                                            if(pastquestion.contains(question) == false){
                                                              pastquestion.insert(0,question);
                                                              pastanswer.insert(0,answer);
                                                              pastrealquestion.insert(0,realquestion);
                                                            }
                                              }catch(e){
                                                answer = "Format Error";
                                              }
                                            });
                                          },
                                              child: Text("=",style: TextStyle(fontSize: 35.h),),
                                            style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(), //<-- SEE HERE
                                            backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                           padding: EdgeInsets.all(9.h),
                                              ),
                                        ),
                                    ),
                                  ],
                                )),
                            ])
                            :Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  [
                                Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                if(specialoperator==0 || specialoperator==2){
                                                question = question + "\u221A(";
                                                realquestion = realquestion+"sqrt(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                              }else{
                                                question = question + "x\u221A(";
                                                realquestion = realquestion+"*sqrt(";
                                                bracketcounter = bracketcounter+1;
                                                specialoperator = 2;
                                              }          
                                           });
                                            },
                                            child: Text("\u221A",style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question = question + "\u03C0";
                                                realquestion = realquestion+"pi";
                                                specialoperator=1;
                                                // bracketcounter = bracketcounter+1;
                                                
                                           });
                                            },
                                            child: Text("\u03C0",style: TextStyle(fontSize: 30.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                        alignment: AlignmentDirectional.bottomCenter,
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              if (specialoperator==0){
                                                realquestion=realquestion.substring(0,realquestion.length-1) + "^";
                                                question = question.substring(0,question.length-1) +"^";
                                              }else if(specialoperator!=2){
                                                question=question+"^";
                                                realquestion = realquestion+"^";
                                                specialoperator = 0;
                                                pointacess=1;
                                                bracketpos="F";
                                              }
                                           });
                                            },
                                            child: Text("^",style: TextStyle(fontSize: 30.h), ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            alignment: AlignmentDirectional.bottomCenter,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                                question=question+"e";
                                                realquestion = realquestion+"e";
                                                specialoperator = 1;
                                                bracketpos="R";
                                           });
                                            },
                                            child: Text("e",style: TextStyle(fontSize: 20.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),),
                                      Container(
                                       child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (scientific){
                                                scientific = false;
                                              }else{
                                                scientific = true;
                                              }
                                           });
                                            },
                                          child: Image.asset('images/expandmore.png',color: Colors.white,),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  Color.fromARGB(255, 103, 102, 100),
                                            // shape: RoundedRectangleBorder(
                                            //   borderRadius: BorderRadius.circular(20),
                                            // ),
                                            shape: CircleBorder(),
                                          // shape: StadiumBorder(), //<-- SEE HERE
                                          // padding: EdgeInsets.all(19.h),
                                            ),
                                      ),)
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                           // HapticFeedback.mediumImpact();
                                            HapticFeedback.mediumImpact();
                                          setState(() {
                                              question="";
                                              realquestion = "";
                                              answer = "=";
                                              specialoperator = 0;
                                              pointacess = 1;
                                              bracketpos="F";
                                              bracketcounter=0;
                                           });
                                            },
                                            child: Text("AC",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          shape: CircleBorder(), //<-- SEE HERE
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                            setState(() {
                                                if(specialoperator==0 || specialoperator==2){
                                                  question=question+"(";
                                                  realquestion = realquestion+"(";
                                                  bracketcounter = bracketcounter+1;
                                                  specialoperator = 2;
                                                }else{
                                                  question=question+"x(";
                                                  realquestion = realquestion+"*(";
                                                  bracketcounter = bracketcounter+1;
                                                  specialoperator = 2;
                                                }                               
                                            });
                                          },
                                            child: Text("( ",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100), //<-- SEE HERE
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(bracketcounter != 0 && specialoperator != 2){
                                              question=question+")";
                                              realquestion = realquestion+")";
                                              bracketcounter = bracketcounter-1;
                                              specialoperator = 12;
                                          }
                                        });
                                      },
                                            child: Text(" )",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100), //<-- SEE HERE
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "/";
                                              question = question.substring(0,question.length-1) +"\u00F7";
                                            }else if(specialoperator!=2){
                                              question=question+"\u00F7";
                                              realquestion = realquestion+"/";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                          child: Text("\u00F7",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), 
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),//<-- SEE HERE
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x7";
                                            realquestion = realquestion+"*7";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"7";
                                          realquestion = realquestion+"7";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
                                        });
                                      },
                                            child: Text("7",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                             backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          shape: CircleBorder(), //<-- SEE HERE
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x8";
                                            realquestion = realquestion+"*8";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"8";
                                          realquestion = realquestion+"8";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
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
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                          if(specialoperator==12){
                                            question=question+"x9";
                                            realquestion = realquestion+"*9";
                                            specialoperator = 1;
                                            bracketpos="R";
                                          }else{
                                          question=question+"9";
                                          realquestion = realquestion+"9";
                                          specialoperator = 1;
                                          bracketpos="R";
                                          }
                                          
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
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "*";
                                              question = question.substring(0,question.length-1) +"x";
                                            }else if(specialoperator!=2){
                                              question=question+"x";
                                              realquestion = realquestion+"*";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("X",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x4";
                                              realquestion = realquestion+"*4";
                                              specialoperator = 1;
                                              bracketpos="R";
                                            }else{
                                            question=question+"4";
                                            realquestion = realquestion+"4";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                  
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
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x5";
                                            realquestion = realquestion+"*5";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"5";
                                            realquestion = realquestion+"5";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                    
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
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x6";
                                            realquestion = realquestion+"*6";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"6";
                                            realquestion = realquestion+"6";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                        
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
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(realquestion.length != 0 && realquestion.substring(realquestion.length-1,realquestion.length)== "-"){
                                              question=question;
                                              realquestion = realquestion;
                                            }else{
                                              question=question+"-";
                                              realquestion = realquestion+"-";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("-",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x1";
                                            realquestion = realquestion+"*1";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }else{
                                            question=question+"1";
                                            realquestion = realquestion+"1";
                                            specialoperator = 1;
                                            bracketpos="R";
                                            }
                                          
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
                                          HapticFeedback.mediumImpact();
                                            setState(() {
                                              if(specialoperator==12){
                                                question=question+"x2";
                                              realquestion = realquestion+"*2";
                                              specialoperator = 1;
                                              bracketpos="R";
                                              }else{
                                              question=question+"2";
                                              realquestion = realquestion+"2";
                                              specialoperator = 1;
                                              bracketpos="R";
                                              }
                                        
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
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(specialoperator==12){
                                              question=question+"x3";
                                              realquestion = realquestion+"*3";
                                              specialoperator = 1;
                                              bracketpos="R";
                              
                                            }else{
                                              question=question+"3";
                                              realquestion = realquestion+"3";
                                              specialoperator = 1;
                                              bracketpos="R";
                                            }
                                      
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
                                     Expanded(
                                       child: ElevatedButton(
                                        onPressed: () {
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (specialoperator==0){
                                              realquestion=realquestion.substring(0,realquestion.length-1) + "+";
                                              question = question.substring(0,question.length-1) +"+";
                                            }else if(specialoperator!=2){
                                              question=question+"+";
                                              realquestion = realquestion+"+";
                                              specialoperator = 0;
                                              pointacess=1;
                                              bracketpos="F";
                                            }
                                          });
                                        },
                                            child: Text("+",style: TextStyle(fontSize: 39.h),),
                                          style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                          padding: EdgeInsets.all(12.h),
                                            ),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(child:Row(
                                  children: [
                                    Expanded(
                                     child: ElevatedButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        setState(() {
                                            question=question+"0";
                                            realquestion = realquestion+"0";
                                            specialoperator = 1;
                                            bracketpos="R";
                              
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
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if (pointacess==0){
                                              question=question;
                                            }else{
                                              question=question+".";
                                              realquestion = realquestion+".";
                                              specialoperator = 1;
                                              pointacess=0;
                                              bracketpos="R";
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
                                          HapticFeedback.mediumImpact();
                                          setState(() {
                                            if(realquestion.length>=5 && (realquestion.substring(realquestion.length-5,realquestion.length) == "sqrt(")){
                                                    question = question.substring(0,question.length-2);
                                                    realquestion = realquestion.substring(0,realquestion.length-5);
                                                    bracketcounter = bracketcounter-1;                    
                                            }else if(realquestion.length>=3 && (realquestion.substring(realquestion.length-3,realquestion.length) == "ln(")){
                                                    question = question.substring(0,question.length-3);
                                                    realquestion = realquestion.substring(0,realquestion.length-3);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.length>=5 &&(fivedel.contains(realquestion.substring(realquestion.length-5,realquestion.length)))){
                                                    question = question.substring(0,question.length-6);
                                                    realquestion = realquestion.substring(0,realquestion.length-5);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.length>=4 &&(fourdel.contains(realquestion.substring(realquestion.length-4,realquestion.length)))){
                                                    question = question.substring(0,question.length-4);
                                                    realquestion = realquestion.substring(0,realquestion.length-4);
                                                    bracketcounter = bracketcounter-1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              bracketcounter = bracketcounter-1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              bracketcounter = bracketcounter+1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                              pointacess = 1;
                                            }else{
                                              question = question.substring(0,question.length-1);
                                              realquestion = realquestion.substring(0,realquestion.length-1);
                                            }
                                            if(realquestion.length==0){
                                              question="";
                                              realquestion = "";
                                              answer = "=";
                                              specialoperator = 0;
                                              pointacess = 1;
                                              bracketpos="F";
                                              bracketcounter=0;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="e"){
                                                specialoperator = 1;
                                            }else if(realquestion.length >= 2 && realquestion.substring(realquestion.length-2,realquestion.length)=="pi"){
                                                specialoperator = 1;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="^"){
                                                specialoperator = 0;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                                specialoperator = 2;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                                specialoperator = 12;
                                            }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                                specialoperator = 1;
                                                pointacess=0;
                                            }else if(numbers.contains(realquestion.substring(realquestion.length-1,realquestion.length))){
                                                specialoperator = 1;
                                            }else{
                                              specialoperator = 0;
                                              pointacess=1;
                                            }
                                          });
                                        },
                                          child: Image.asset('images/delete.png',color: Colors.white,),
                                          style: ElevatedButton.styleFrom(
                                          alignment: AlignmentDirectional.center,
                                          backgroundColor: Color.fromARGB(255, 30, 29, 29),
                                          shape: CircleBorder(), //<-- SEE HERE
                                          padding: EdgeInsets.all(10.h),
                                            ),
                                      ),
                                    ),
                                     Expanded(
                                       child: ElevatedButton(
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                            setState(() {
                                              updrealquestion = realquestion;
                                              if (degcon=="deg"){
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)sin\('), 'sin((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)cos\('), 'cos((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'(?<!a)tan\('), 'tan((pi/180)*');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'asin\('), '(180/pi)*asin(');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'acos\('), '(180/pi)*acos(');
                                                updrealquestion = updrealquestion.replaceAll(RegExp(r'atan\('), '(180/pi)*atan(');
                                                // realquestion.replaceAll('cos(', 'cos(180/pi*');
                                                // realquestion.replaceAll('tan(', 'tan(180/pi*');
                                              }
                                              for (int i = 0; i < bracketcounter; i++) {
                                                  updrealquestion = updrealquestion+")";
                                              }
                                               //else if(degcon=="rad"){
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'sin\(pi\/180\*'), 'sin(');
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'cos\(pi\/180\*'), 'cos(');
                                              //    updrealquestion = updrealquestion.replaceAll(RegExp(r'tan\(pi\/180\*'), 'tan(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'asin\(pi\/180\*'), 'asin(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'acos\(pi\/180\*'), 'acos(');
                                              //   //  updrealquestion = updrealquestion.replaceAll(RegExp(r'atan\(pi\/180\*'), 'atan(');
                                              //   //  realquestion.replaceAll('cos(180/pi*','cos(');
                                              //   //  realquestion.replaceAll('tan(180/pi*','tan(');
                                              // }
                                              try{
                                                // var exp = Parser().parse(realquestion);
                                                // double evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
                                                // answer = (MathNodeExpression.fromString(realquestion)).calc() as String ;
                                                // print(evaluation);
                                                     final expression = MathNodeExpression.fromString(
                                                              updrealquestion,
                                                            ).calc(
                                                              MathVariableValues({}),
                                                            );
                                                            answer = expression.toString();
                                                            // answer = updrealquestion;
                                                            if(pastquestion.contains(question) == false){
                                                              pastquestion.insert(0,question);
                                                              pastanswer.insert(0,answer);
                                                              pastrealquestion.insert(0,realquestion);
                                                            }
                                              }catch(e){
                                                answer = "Format Error";
                                              }
                                            });
                              
                                          },
                                              child: Text("=",style: TextStyle(fontSize: 39.h),),
                                            style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(), //<-- SEE HERE
                                            backgroundColor: Color.fromARGB(255, 103, 102, 100),
                                           padding: EdgeInsets.all(9.h),
                                              ),
                                        ),),
                                  ],
                                )),
                            ]),
                          ),
                        Container( child: converter(),),
                        Container( child: financial(),),
                      ],
                    ),
                   )
                  ],
                ),
              ),
             )
            ],
            
          )
        ),
        sheetAbove: SnappingSheetContent(
          draggable: true,
          child: Container(
            color: Color.fromARGB(255, 77, 77, 77),
            child: ListView.builder(
              itemCount: pastquestion.length,
              itemBuilder: (BuildContext context, int index){
                return  Container(
                  color: Color.fromARGB(255, 77, 77, 77),
                  child: Column(
                    children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                           margin: EdgeInsets.only(top: 10),
                          width: 390.w,
                          height: 3,
                          decoration: BoxDecoration(
                          color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                        ),
                        ),
                      Container(
                        child: SizedBox(
                          height: 60.h,
                          width: 1000,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Color.fromARGB(255, 77, 77, 77)
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: pastquestion[index].length<18 ? FittedBox(
                                    alignment: AlignmentDirectional.centerEnd,
                                    // fit: BoxFit.fitHeight, 
                                    child: Text(pastquestion[index],style: TextStyle(fontSize: 40),),
                                     ) : SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                          child: Text(pastquestion[index],style: TextStyle(fontSize: 25),),
                                     ),
                            ),
                            onPressed: (){
                              setState(() {
                                question = pastquestion[index];
                                realquestion = pastrealquestion[index];
                                answer = "";
                                 if(realquestion.length==0){
                                            question="";
                                            realquestion = "";
                                            answer = "=";
                                            specialoperator = 0;
                                            pointacess = 1;
                                            bracketpos="F";
                                            bracketcounter=0;
                                }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="e"){
                                    specialoperator = 1;
                                }else if(realquestion.substring(realquestion.length-2,realquestion.length)=="pi"){
                                    specialoperator = 1;
                                }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="^"){
                                    specialoperator = 0;
                                }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                    specialoperator = 2;
                                }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                    specialoperator = 12;
                                }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                    specialoperator = 1;
                                    pointacess=0;
                                }else if(numbers.contains(realquestion.substring(realquestion.length-1,realquestion.length))){
                                    specialoperator = 1;
                                }else{
                                  specialoperator = 0;
                                  pointacess=1;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: SizedBox(
                          height: 55.h,
                          width: 1000,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Color.fromARGB(255, 77, 77, 77)
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: pastanswer[index].length<18 ? FittedBox(
                                    alignment: AlignmentDirectional.centerEnd,
                                    // fit: BoxFit.fitHeight, 
                                    child: Text(pastanswer[index],style: TextStyle(fontSize: 30),),
                                     ) : SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                          child: Text(pastanswer[index],style: TextStyle(fontSize: 20),),
                                     ),
                            ),
                            onPressed: (){
                              setState(() {
                                question = pastanswer[index];
                                realquestion = pastanswer[index];
                                answer = "";
                                 if(realquestion.length==0){
                                            question="";
                                            realquestion = "";
                                            answer = "=";
                                            specialoperator = 0;
                                            pointacess = 1;
                                            bracketpos="F";
                                            bracketcounter=0;
                                          }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="e"){
                                              specialoperator = 1;
                                          }else if(realquestion.substring(realquestion.length-2,realquestion.length)=="pi"){
                                              specialoperator = 1;
                                          }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="^"){
                                              specialoperator = 0;
                                          }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="("){
                                              specialoperator = 2;
                                          }else if(realquestion.substring(realquestion.length-1,realquestion.length)==")"){
                                              specialoperator = 12;
                                          }else if(realquestion.substring(realquestion.length-1,realquestion.length)=="."){
                                              specialoperator = 1;
                                              pointacess=0;
                                          }else if(numbers.contains(realquestion.substring(realquestion.length-1,realquestion.length))){
                                              specialoperator = 1;
                                          }else{
                                            specialoperator = 0;
                                            pointacess=1;
                                          }
                              });
                            },
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onVerticalDragDown: (DragDownDetails details ){
                      //     answer = "hi";
                      //   },
                      // )
                    ],
                  ),
                );
              },
              reverse: true,
            ),
          )
        ),
        ),
      ),
    );
  }
}

