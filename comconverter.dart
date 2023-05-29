
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:units_converter/units_converter.dart';

class comconverter extends StatefulWidget {
  int ind;
  comconverter({Key? key, required this.ind}):super(key: key);

  @override
  State<comconverter> createState() => _comconverterState();
}

class _comconverterState extends State<comconverter> {
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
  int firstselect = 0;
  int secondselect = 1;
  var firstinput = "1";
  var secondinput = "1";
  int inputsel = 0;
  @override
  Widget build(BuildContext context) {
    var indd = widget.ind;
    final List leenght = indd==0? <SPEED>[SPEED.milesPerHour,SPEED.kilometersPerHour,SPEED.knots,SPEED.metersPerSecond,SPEED.feetsPerSecond,SPEED.minutesPerKilometer]
     : indd==1?<LENGTH>[LENGTH.kilometers,LENGTH.meters,LENGTH.yards,LENGTH.inches,LENGTH.millimeters,LENGTH.miles,LENGTH.feet,LENGTH.centimeters,LENGTH.angstroms,LENGTH.lightYears,LENGTH.nanometers,LENGTH.parsec,LENGTH.picometers]
     : indd==2?<VOLUME>[VOLUME.tablespoonsUs,VOLUME.cups,VOLUME.usGallons,VOLUME.usQuarts,VOLUME.liters,VOLUME.microliters,VOLUME.milliliters,VOLUME.nanoliters,VOLUME.picoliters,VOLUME.centiliters,VOLUME.cubicCentimeters,VOLUME.cubicFeet,VOLUME.cubicInches,VOLUME.cubicMeters,VOLUME.cubicMillimeters,VOLUME.cups,VOLUME.deciliters,VOLUME.femtoliters]
     : indd==3?<MASS>[MASS.carats,MASS.centigrams,MASS.grams,MASS.kilograms,MASS.micrograms,MASS.milligrams,MASS.nanograms,MASS.pounds,MASS.quintals,MASS.tons,MASS.nanograms,MASS.ounces,MASS.troyOunces]
     : indd==4?<TEMPERATURE>[TEMPERATURE.celsius,TEMPERATURE.delisle,TEMPERATURE.fahrenheit,TEMPERATURE.kelvin,TEMPERATURE.rankine,TEMPERATURE.reamur,TEMPERATURE.romer]
     : indd==5?<AREA>[AREA.acres,AREA.are,AREA.hectares,AREA.squareCentimeters,AREA.squareFeet,AREA.squareInches,AREA.squareKilometers,AREA.squareMeters,AREA.squareMiles,AREA.squareMillimeters,AREA.squareYard,AREA.squareFeetUs]
     : indd==6?<TIME>[TIME.centuries,TIME.days,TIME.minutes,TIME.seconds,TIME.weeks,TIME.years365,TIME.nanoseconds,TIME.decades,TIME.hours,TIME.microseconds,TIME.millennium,TIME.milliseconds,TIME.centiseconds,TIME.lustrum]
     : indd==7?<POWER>[POWER.europeanHorsePower,POWER.gigawatt,POWER.kilowatt,POWER.megawatt,POWER.milliwatt,POWER.watt]
     : indd==8?<PRESSURE>[PRESSURE.atmosphere,PRESSURE.bar,PRESSURE.hectoPascal,PRESSURE.millibar,PRESSURE.pascal,PRESSURE.psi,PRESSURE.torr,PRESSURE.inchOfMercury]
     : indd==9?<ENERGY>[ENERGY.calories,ENERGY.electronvolts,ENERGY.energyFootPound,ENERGY.joules,ENERGY.kilocalories,ENERGY.kilowattHours]
     : List.empty();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("funm"),
      // ),
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
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(leenght.length, (index){
                  return  Container(
                    margin: EdgeInsets.only(top: 15,right: 3,left: 3,bottom: 3),
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          firstselect = index;
                          firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor:  firstselect!=index ? Colors.teal[100]: Color.fromARGB(255, 11, 245, 226), 
                    ),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        height: 40.h,
                        child: Text(leenght[index].toString().split('.')[1],style: TextStyle(fontSize: 20.h,color: Colors.black))
                        ),
                      ),
                  );
                }),
              ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              height: 90.h,
              width: 100.sw,
              // color: Color.fromARGB(255, 255, 135, 7),
              child: Row(
                children: [
                  Container(
                    width: 200.w,
                    padding: EdgeInsets.only(left: 12),
                     child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      // fit: BoxFit.fitHeight, 
                      child: Text(leenght[firstselect].toString().split('.')[1],style: TextStyle(fontSize: 10.h, color: Colors.white,)),
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        inputsel = 0;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 40.w),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border(
                          bottom: BorderSide(width: 2, color: inputsel!=0? Colors.white: Colors.green),
                        )
                      ),
                      width: 170.w,
                      height: 60.h,
                      // color: Colors.black,
                      child:  firstinput.length < 9 ? FittedBox(
                        alignment: AlignmentDirectional.center,
                        // fit: BoxFit.fitHeight, 
                        child: Text(firstinput,style: TextStyle(fontSize: 45.h, color: Colors.white,))
                      ): SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: inputsel==0? true:false,
                          child: Text(firstinput,style: TextStyle(fontSize: 35.h, color: Colors.white,)),
                        ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.centerStart,
              child: Image.asset('images/conversionimage.png',scale: 1.5.h, ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              height: 90.h,
              width: 100.sw,
              // color: Color.fromARGB(255, 255, 135, 7),
              child: Row(
                children: [
                  Container(
                    width: 200.w,
                    padding: EdgeInsets.only(left: 12),
                     child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      // fit: BoxFit.fitHeight, 
                      child: Text(leenght[secondselect].toString().split('.')[1],style: TextStyle(fontSize: 10.h, color: Colors.white,)),
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        inputsel=1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 40.w),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        border: Border(
                          bottom: BorderSide(width: 2, color: inputsel!=1? Colors.white: Colors.green),
                        )
                      ),
                      width: 170.w,
                      height: 60.h,
                      // color: Colors.black,
                      child: secondinput.length < 9 ? FittedBox(
                        alignment: AlignmentDirectional.center,
                        // fit: BoxFit.fitHeight, 
                        child: Text(secondinput,style: TextStyle(fontSize: 45.h, color: Colors.white,)),
                      ): SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: inputsel!=0? true:false,
                          child: Text(secondinput,style: TextStyle(fontSize: 35.h, color: Colors.white,)),
                        ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(leenght.length, (index){
                  return  Container(
                    margin: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          secondselect = index;
                           secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: secondselect!=index ? Colors.teal[100]: Color.fromARGB(255, 11, 245, 226), 
                    ),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        height: 40.h,
                        child: Text(leenght[index].toString().split('.')[1],style: TextStyle(fontSize: 20.h,color: Colors.black))
                        ),
                      ),
                  );
                }),
              ),
              ),
            ),
            Container(
              height: 435.h,
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
                                // secondinput = double.parse(firstinput).convertFromTo(LENGTH.angstroms, LENGTH.micrometers).toString();
                                // secondinput = double.parse(firstinput).convertFromTo(LENGTH.meters, LENGTH.inches).toString();
                                // secondinput = double.parse(firstinput).convertFromTo(leenght[secondselect], LENGTH.meters).toString();
                                if(inputsel==0){
                                  firstinput  = firstinput+"1";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"1";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                              setState(() {
                                if(inputsel==0){
                                  firstinput  = firstinput+"2";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"2";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                              setState(() {
                                if(inputsel==0){
                                  firstinput  = firstinput+"3";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"3";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                                if(inputsel==0){
                                  firstinput  = firstinput+"4";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"4";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                              setState(() {
                                if(inputsel==0){
                                  firstinput  = firstinput+"5";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"5";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                              setState(() {
                                if(inputsel==0){
                                  firstinput  = firstinput+"6";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"6";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                                if(inputsel==0){
                                  firstinput  = firstinput+"7";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"7";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
                                }
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
                                if(inputsel==0){
                                  firstinput  = firstinput+"8";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"8";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                              setState(() {
                                if(inputsel==0){
                                  firstinput  = firstinput+"9";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"9";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
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
                                if(inputsel==0){
                                  firstinput  = firstinput+"0";
                                  secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                }else{
                                  secondinput = secondinput+"0";
                                  firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
                                }
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
                                if(inputsel==0){
                                  if(!firstinput.contains('.')){
                                    firstinput  = firstinput+".";
                                    secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                  }
                                }else{
                                 if(!secondinput.contains('.')){
                                    secondinput  = secondinput+".";
                                    firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
                                  }
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
                                  if(inputsel==0){
                                    if(firstinput.length!=1){
                                      firstinput = firstinput.substring(0,firstinput.length-1);
                                      secondinput = double.parse(firstinput).convertFromTo(leenght[firstselect], leenght[secondselect]).toString();
                                    }else{
                                      firstinput = firstinput.substring(0,firstinput.length-1);
                                      secondinput = "";
                                    }
                                  }else{
                                    if(secondinput.length!=1){
                                      secondinput = secondinput.substring(0,secondinput.length-1);
                                      firstinput =  double.parse(secondinput).convertFromTo(leenght[secondselect], leenght[firstselect]).toString();
                                    }else{
                                      secondinput = secondinput.substring(0,secondinput.length-1);
                                      firstinput="";
                                    }
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
        ),
        ),
      );
  }
}