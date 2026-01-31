import 'package:flutter/material.dart';
import 'package:ird_foundation/screens/side_menu_screen.dart';    
import 'home_screen.dart';    

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isDragging = false;
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  double get maxSlide => screenWidth * 0.75; // Drawer takes 75% of screen width
  double get maxY => screenHeight * 0.1;     // Home screen drops 10% down
  double get minScale => 0.85;




     


     
  void toggleDrawer() {
    setState(() {
      if (isDrawerOpen) {
        closeDrawer();
      } else {
        openDrawer();
      }
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = maxSlide;
      yOffset = maxY;
      scaleFactor = minScale;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

     
  void _onDragStart(DragStartDetails details) {
    setState(() {
      isDragging = true;    
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
         
      xOffset += details.delta.dx;

         
      if (xOffset < 0) xOffset = 0;
      if (xOffset > maxSlide) xOffset = maxSlide;

         
      double percent = xOffset / maxSlide;

         
      yOffset = percent * maxY;
      scaleFactor = 1 - (percent * (1 - minScale));
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      isDragging = false;    

         
         
      if (xOffset > maxSlide / 2 || details.primaryVelocity! > 500) {
        openDrawer();
      } else {
        closeDrawer();
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print(screenWidth*.609);
    print(screenHeight);
    return Scaffold(
      backgroundColor: const Color(0xFF0A8ED9),
      body: Stack(
        children: [
             
          GestureDetector(
            onTap: closeDrawer,    
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SideMenu(),
            ),
          ),

             
          GestureDetector(
               
            onTap: () {
              if (isDrawerOpen) closeDrawer();
            },

               
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,

            child: AnimatedContainer(
                 
              duration: isDragging ? Duration.zero : const Duration(milliseconds: 250),
              curve: Curves.easeOutCirc,

              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isDrawerOpen || xOffset > 0 ? 20 : 0.0),
                boxShadow: (isDrawerOpen || xOffset > 0)
                    ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 20),
                  )
                ]
                    : [],
              ),
              child: AbsorbPointer(
                   
                absorbing: isDrawerOpen || isDragging,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDrawerOpen || xOffset > 0 ? 20 : 0.0),
                  child: HomeScreen(
                    onMenuTap: toggleDrawer,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}