import 'dart:collection';

import 'package:course_project_5braincells/Profile_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    //HomeScreen(),
    Text("Home Page"),
    Text("Trending Page"),
    Text("Calendar Page"),
    Text("Bookmarked Page"),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), title: Text("Trending")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Calendar")),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), title: Text("Bookmark")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile")),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue[100],
        ),
      ),
    );
  }
}



// class Profile extends StatelessWidget {
//
//   int userId = 12345;
//   String firstName = 'Firstname';
//   String lastName = 'Lastname';
//   double rating = 4.7;
//   List<String> languages = ['English', 'Spanish', 'French'];
//   List<String> languageBios = [
//     'The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly but gets faster each minute after you hear this signal bodeboop. A sing lap should be completed every time you hear this sound. ding Remember to run in a straight line and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark. Get ready!… Start.',
//     'La prueba FitnessGram Pacer es una prueba de capacidad aeróbica de varias etapas que se vuelve cada vez más difícil a medida que continúa. La prueba del marcapasos de 20 metros comenzará en 30 segundos. Alinee al principio. La velocidad de carrera comienza lentamente pero se acelera cada minuto después de escuchar esta señal de bodeboop. Se debe completar una vuelta de canto cada vez que escuche este sonido. ding Recuerda correr en línea recta y correr el mayor tiempo posible. La segunda vez que no completa una vuelta antes del sonido, la prueba termina. La prueba comenzará con la palabra inicio. En sus marcas. ¡Prepárate! ... Empieza.',
//     "Le test FitnessGram Pacer est un test de capacité aérobie en plusieurs étapes qui devient progressivement plus difficile à mesure qu'il se poursuit. Le test du stimulateur de 20 mètres commencera dans 30 secondes. Alignez-vous au départ. La vitesse de course démarre lentement mais s'accélère chaque minute après que vous entendez ce signal bodeboop. Un tour de chant doit être terminé chaque fois que vous entendez ce son. N'oubliez pas de courir en ligne droite et de courir le plus longtemps possible. La deuxième fois que vous ne parvenez pas à terminer un tour avant le son, votre test est terminé. Le test commencera au début du mot. À vos marques. Préparez-vous!… Commencez."
//     //'English', 'Spanish', 'French'
//    ];
//   String imageUrl = 'assets/default.png';
//
//   List<Widget> getLanguageTabs(List<String> languages) {
//     List<Widget> tabs = new List();
//     for (String language in languages){
//       tabs.add(Text(
//         language,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 22,
//         ),
//       ));
//     }
//     return tabs;
//   }
//
//   List<Widget> getLanguageBios(List<String> bios) {
//     List<Widget> bioTabs = new List();
//     for (String bio in bios){
//       bioTabs.add(Text(
//         bio,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 18,
//         ),
//       ));
//     }
//     return bioTabs;
//   }
//
//   int _selectedIndex = 0;
//   static const List<Widget> _screen = <Widget>[
//     Text('Index 0: Profile'),
//     Text('Index 1: Search'),
//     Text('Index 2: Jobs'),
//     Text('Index 3: Setings'),
//   ];
//
//   void _onItemTapped(int index) {
//     // Go to page
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(primaryColor: Colors.blue),
//         home: DefaultTabController(
//           length: languages.length,
//           child: Scaffold(
//
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(285.0),
//               child: AppBar(
//                 title: Text('Service App'),
//                 centerTitle: true,
//                 flexibleSpace: Column(
//                   children: <Widget>[
//
//                     // Image Avatar
//                     Center(
//                       heightFactor: 1.2,
//
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//                         child: Image(
//                           image: AssetImage(imageUrl),
//                           height: 100.0,
//                           width: 100.0,
//                         ),
//                       ),
//                     ),
//
//                     // Name
//                     Center(
//                       child: Text(
//                         firstName+" "+lastName,
//                         style: TextStyle(
//                           fontSize: 32.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//
//                     // Rating
//                     Center(
//                       child: Row(
//                         children: [
//                           Text(
//                             rating.toString(),
//                             style: TextStyle(
//                               fontSize: 26.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '/5 Stars',
//                             style: TextStyle(
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                         mainAxisAlignment: MainAxisAlignment.center,
//                       ),
//                       heightFactor: 1.5,
//                     ),
//                   ],
//                 ),
//
//                 bottom: TabBar(
//                   tabs: getLanguageTabs(languages),
//                 ),
//               ),
//             ),
//
//             // Bios for different languages
//             body: TabBarView(
//               children: getLanguageBios(languageBios),
//
//             ),
//
//             // Bottom Navigation Bar
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   title: Text('Profile'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search),
//                   title: Text('Search'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.calendar_today),
//                   title: Text('Jobs'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.settings),
//                   title: Text('Settings'),
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedItemColor: Colors.blue,
//               onTap: _onItemTapped,
//             ),
//           ),
//         )
//     );
//   }
// }
