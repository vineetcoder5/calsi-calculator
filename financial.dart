import 'package:calsi/gst.dart';
import 'package:calsi/splitbill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class financial extends StatefulWidget {
  const financial({super.key});

  @override
  State<financial> createState() => _financialState();
}

class _financialState extends State<financial> {
   final List<String> funcs = <String>["Split bill","Gst"];
   final List<String> imagepath = <String>["images/splitbill.png","images/splitbill.png"];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 25,
      crossAxisCount: 3,
      children: List.generate(funcs.length , (index) {
        return Container(
        child: ElevatedButton(
          onPressed: (){
            setState(() {
               HapticFeedback.mediumImpact();
              // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              //               return splitbill();
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
                        Container(child: Text(funcs[index],style: TextStyle(color: Colors.black),))
                      ],
                    ),
            ),
        ),
      );
      }),
    );
  }
}

Route _createRoute(int inde) {
  
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => inde==0? splitbill():gst(),
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