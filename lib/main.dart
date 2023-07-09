import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookPage(),
    );
  }
}

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  double _rotationValue = 0.0;
 
  void _handleDrag(DragUpdateDetails details) {
    setState(() {
      _rotationValue -= details.delta.dx / 300;
      if (_rotationValue < 0.0) {
        _rotationValue = 0.0;
      } else if (_rotationValue > 1.0) {
        _rotationValue = 1.0;
      }
    });
    print(_rotationValue);
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() {
      if (_rotationValue > 0.5) {
        _rotationValue = 1.0;
      } else {
        _rotationValue = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      
      body: Stack(

        children: [
          Positioned.fill(
            bottom: kToolbarHeight/MediaQuery.of(context).size.height ,
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.blue,
              child: Text('Book App'),
            ),
          ),
          Positioned.fill(
            top: 80,
            child: GestureDetector(
              onHorizontalDragUpdate: _handleDrag,
              onHorizontalDragEnd: _handleDragEnd,
              child:   Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(vector.radians(_rotationValue * 90)),
                        child: Container(
                          color: Colors.amber, // Right page color
                      alignment: Alignment.center,
                          child: Text('asasjiaohaiojareresmasmdadmjwoijd'), // Left page color
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math.dart' as vector;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BookPage(),
//     );
//   }
// }

// class BookPage extends StatefulWidget {
//   @override
//   _BookPageState createState() => _BookPageState();
// }

// class _BookPageState extends State<BookPage> {
//   double _slideValue = 0.0;
//   bool _isReversed = false;

//   void _handleDrag(DragUpdateDetails details) {
//     setState(() {
//       _slideValue -= details.delta.dx / 300;
//       if (_slideValue < 0.0) {
//         _slideValue = 0.0;
//       } else if (_slideValue > 1.0) {
//         _slideValue = 1.0;
//       }
//     });
//   }

//   void _handleDragEnd(DragEndDetails details) {
//     setState(() {
//       if (_slideValue > 0.5) {
//         _slideValue = 1.0;
//       } else {
//         _slideValue = 0.0;
//       }
//     });
//   }

//   void _reverseAnimation() {
//     setState(() {
//       _isReversed = !_isReversed;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Buku Flutter'),
//       ),
//       body: GestureDetector(
//         onHorizontalDragUpdate: _handleDrag,
//         onHorizontalDragEnd: _handleDragEnd,
//         child: Stack(
//           children: [
//              Positioned.fill(
//               top: 50,
//               child: IgnorePointer(
//                 child: Container(
//                   color: Colors.blue, // Right page color
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Halaman 2',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned.fill(
//               top: 50,
//               child:  AnimatedContainer(
//                   duration: Duration(milliseconds: 500),
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.001)
//                     ..rotateY(vector.radians( _isReversed? _slideValue * -90:_slideValue * 90)),
//                   child: Container(
//                     color: Colors.white,
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Halaman 1',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ),
            
           
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _reverseAnimation,
//         child: Icon(Icons.swap_horiz),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math.dart' as vector;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BookPage(),
//     );
//   }
// }

// class BookPage extends StatefulWidget {
//   @override
//   _BookPageState createState() => _BookPageState();
// }

// class _BookPageState extends State<BookPage> with SingleTickerProviderStateMixin {
//   late PageController _pageController;
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _animationController = AnimationController(
//       duration: Duration(seconds: 5),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _handlePageChange(int pageIndex) {
//     if (_pageController.page! < pageIndex) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Buku Flutter'),
//       ),
//       body: GestureDetector(
//         onHorizontalDragEnd: (DragEndDetails details) {
//           if (details.velocity.pixelsPerSecond.dx > 0) {
//             _pageController.previousPage(
//               duration: Duration(seconds: 5),
//               curve: Curves.easeInOut,
//             );
//           } else if (details.velocity.pixelsPerSecond.dx < 0) {
//             _pageController.nextPage(
//               duration: Duration(seconds: 5),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         child: PageView.builder(
//           controller: _pageController,
//           itemCount: 5, // Jumlah halaman buku
//           onPageChanged: _handlePageChange,
//           itemBuilder: (context, index) {
//             return _buildPage(index);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPage(int pageIndex) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         double rotationValue = (_animation.value < 0.5) ? _animation.value * 2 : (1.0 - _animation.value) * 2;
//         return Container(
//           color: Colors.yellow, // Page color
//           alignment: Alignment.centerRight,
//           child: Transform(
//             alignment: Alignment.centerLeft,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..rotateY(vector.radians(rotationValue * 90)),
//             child: Container(
//               color: Colors.white,
//               alignment: Alignment.center,
//               child: Text(
//                 'Halaman ${pageIndex + 1}',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
