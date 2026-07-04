import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RobotAnimation extends StatefulWidget {
  const RobotAnimation({super.key});
  
  @override
  State<RobotAnimation> createState()=> _RobotAnimationState();
  
}

class _RobotAnimationState extends State <RobotAnimation>with TickerProviderStateMixin{

     String robotImage = "assets/images/blackRobo.png";
     String shape = "assets/images/circle.png";

     bool isRobotActive = false;
  
  late AnimationController floatRobotController ;
  late AnimationController animationController;
  late AnimationController slideController;
  late AnimationController rotateController;


  late Animation <double> flaotRobotAnimation;

  late Animation <Color?> backgroundAnimation;

  late Animation <Color?> containerAnimation;

  late Animation <double> textOpacityAnimation;

  late Animation <double> shapeOpacityAnimation;
    late Animation <double> slideOpacityAnimation;

  late Animation<Offset> slideAnimation;

  late Animation<double> rotateAnimation;
 


  @override
  void initState() {
   
    super.initState();

    floatRobotController = AnimationController(vsync: this , duration: Duration(milliseconds: 900),);

    animationController = AnimationController(vsync: this , duration: Duration(milliseconds: 700),);

    slideController = AnimationController(vsync: this , duration: Duration(milliseconds: 700),);

    rotateController = AnimationController(vsync: this , duration: Duration(milliseconds: 700),);


    flaotRobotAnimation = Tween<double>(begin: -8 , end: 8).animate(CurvedAnimation(parent: floatRobotController, curve: Curves.easeInOut));

    backgroundAnimation = ColorTween(begin:Colors.grey , end: const Color.fromARGB(255, 206, 207, 207)).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInBack));

    containerAnimation = ColorTween(begin: const Color.fromARGB(255, 53, 57, 58) , end:  const Color.fromARGB(255, 65, 183, 242)).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    textOpacityAnimation = Tween<double>(begin: 1.0 , end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    
     shapeOpacityAnimation = Tween<double>(begin: 0.0 , end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
     slideOpacityAnimation = Tween<double>(begin: 0.0 , end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
     
     slideAnimation = Tween( begin:Offset(0, -1), end: Offset.zero,).animate(CurvedAnimation( parent: slideController, curve: Curves.easeInOut, ),);
     
    rotateAnimation = Tween<double>(begin: 0.0 , end: 2*pi).animate(CurvedAnimation(parent: rotateController, curve: Curves.easeInOut));
   
  }

  void startAnimation() {
  if (!isRobotActive) {
  setState(() {
      isRobotActive = true;
      changeColor(const Color.fromARGB(255, 65, 183, 242));
      robotImage = "assets/images/whiteRobo.png";
    });
    animationController.forward();
    floatRobotController.repeat(reverse: true);
    slideController.forward();
    rotateController.forward();
  }
}


void changeColor(Color newColor) {
  containerAnimation = ColorTween(
    begin: containerAnimation.value,
    end: newColor,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ),
  );

  animationController.forward(from: 0.0);
}

  @override
  void dispose() {
   floatRobotController.dispose();
   animationController.dispose();
   slideController.dispose();
   rotateController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AnimatedBuilder(animation: animationController, builder: (context , child )=>Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundAnimation.value,
        child: child,
      ),
      child: Stack(children: [

        
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          bottom: 20,
          child: AnimatedBuilder(animation: animationController, builder: (context , child )=>
         Container(
            width: 900,
            height: 700,
            decoration: BoxDecoration(
             color: containerAnimation.value,
             borderRadius: BorderRadius.circular(10)
            ),

            child: Stack(children: [

              Positioned(
          top: 0,
          left: 500,

          child: 
          SlideTransition(
            position: slideAnimation,
            child: 
            AnimatedBuilder(
              animation: animationController, builder: (context, child) => Opacity(opacity: slideOpacityAnimation.value,child: child,),
              child: Container(
                width: 230,
                height: 60,
                decoration: BoxDecoration(
                  color:const Color.fromARGB(255, 206, 207, 207),
                  borderRadius: BorderRadius.circular(20),
              
                ),
                child: Row(
                  mainAxisAlignment: .spaceAround,
                  children: [
              
                    GestureDetector(onTap: () {setState(() {
                      shape = "assets/images/circle.png";
                    });
                     changeColor(const Color.fromARGB(255, 65, 183, 242));
                     rotateController.forward(from: 0.0);
                     },
                      child: Icon(Icons.circle , size: 35, color: const Color.fromARGB(255, 108, 108, 108),)),

                    GestureDetector(onTap: () {
                      setState(() {
                        shape = "assets/images/square.png";
                        
                      });
                       changeColor(const Color.fromARGB(255, 123, 239, 183));
                       rotateController.forward(from: 0.0);
                    },
                      child: Icon(Icons.square , size: 35,color: const Color.fromARGB(255, 108, 108, 108),)),

                    GestureDetector ( onTap: () {
                      setState(() {
                        shape = "assets/images/triangle.png";
                      });
                       changeColor(const Color.fromARGB(255, 230, 85, 134));
                       rotateController.forward(from: 0.0);
                    },
                      child: Icon(Icons.change_history , size: 35, color:const Color.fromARGB(255, 108, 108, 108),))
              
                ],),
              ),
            ),
          )),
              
              
             Positioned(
              left: 300,
              top: 70,
              
               child: Opacity(opacity:  isRobotActive ? 0 : 1 ,child: Text(
                  "CLICK",
                           style: GoogleFonts.montserrat(
               fontSize: 200,
                color: Colors.grey,
                 letterSpacing: -5,
                  fontWeight: FontWeight.w800,
                 ),
                    ),)
               
             ),

             Positioned(
              top: 140,
              left: 460,
              child: AnimatedBuilder(animation: animationController, builder: (context ,child)=>Opacity(opacity: shapeOpacityAnimation.value,child: child,), 
              child: AnimatedBuilder(animation: rotateAnimation, builder: (context,child)=>Transform.rotate(angle: rotateAnimation.value,child: child,)
              ,child: Opacity(opacity: 0.6,
                child: Image.asset(shape,width: 320, height: 320,))),),),

             Positioned(
              top: 115,
              left: 480,
              child: AnimatedBuilder(
                            animation: flaotRobotAnimation,
                       builder: (context, child) {
                            return Transform.translate(
                        offset: Offset(0, flaotRobotAnimation.value),
                           child: child,
              );
                       },
                    child: GestureDetector(
                    onTap: startAnimation,
                    child:
                     Image.asset(
                       robotImage,
                          width: 250,
                          ),
                                   ),
                                 ),
            )
            
                 
                  
            ],),
           
         ),
            
          ),
        )

      ],),)
    );

   
   
  }

}