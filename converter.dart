import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'comconverter.dart';
class converter extends StatefulWidget {
  const converter({super.key});

  @override
  State<converter> createState() => _converterState();
}

class _converterState extends State<converter> {
   final List<String> names = <String>['Speed','Leength','Volume','weight and mass','Temp','Area','Time','Power','Pressure','Energy'];
   final List<String> imagepath = <String>['images/speed.png','images/lenght.png','images/volume.png','images/weight.png','images/temp.png','images/area.png','images/time.png','images/power.png','images/pressure.png','images/energy.png'];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 25,
      crossAxisCount: 3,
      children: List.generate(names.length , (index) {
        return Container(
        child: ElevatedButton(
          onPressed: (){
            setState(() {
               HapticFeedback.mediumImpact();
              // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              //               return comconverter();
              //             }));
              Navigator.of(context).push(_createRoute(index));
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Color.fromARGB(224, 218, 198, 209), 
          ),
          child: Container(
          // padding: const EdgeInsets.all(8),
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            imagepath[index],
                          ),
                        ),
                        Container(child: Text(names[index],style: TextStyle(color: Colors.black),))
                      ],
                    ),
            ),
        ),
      );
      }),
    );
  }
}
Route _createRoute(names) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => comconverter(ind: names,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInBack;
      

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}