import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'user_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    print(user.id);
    // TODO: implement createState
    return ProfileScreenState();
  }
}

/*
  Home Screen Widget to be used when in the "Home" tab of the Navigation bar.
  This widget will contain the Search Bar used to find listings within the app.
*/
class ProfileScreenState extends State<ProfileScreen> {
  int userId = 12345;
  String firstName = 'Firstname';
  String lastName = 'Lastname';
  double rating = 4.7;
  List<String> languages = ['English', 'Spanish', 'French'];
  List<String> languageBios = [
    'The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly but gets faster each minute after you hear this signal bodeboop. A sing lap should be completed every time you hear this sound. ding Remember to run in a straight line and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark. Get ready!… Start.',
    'La prueba FitnessGram Pacer es una prueba de capacidad aeróbica de varias etapas que se vuelve cada vez más difícil a medida que continúa. La prueba del marcapasos de 20 metros comenzará en 30 segundos. Alinee al principio. La velocidad de carrera comienza lentamente pero se acelera cada minuto después de escuchar esta señal de bodeboop. Se debe completar una vuelta de canto cada vez que escuche este sonido. ding Recuerda correr en línea recta y correr el mayor tiempo posible. La segunda vez que no completa una vuelta antes del sonido, la prueba termina. La prueba comenzará con la palabra inicio. En sus marcas. ¡Prepárate! ... Empieza.',
    "Le test FitnessGram Pacer est un test de capacité aérobie en plusieurs étapes qui devient progressivement plus difficile à mesure qu'il se poursuit. Le test du stimulateur de 20 mètres commencera dans 30 secondes. Alignez-vous au départ. La vitesse de course démarre lentement mais s'accélère chaque minute après que vous entendez ce signal bodeboop. Un tour de chant doit être terminé chaque fois que vous entendez ce son. N'oubliez pas de courir en ligne droite et de courir le plus longtemps possible. La deuxième fois que vous ne parvenez pas à terminer un tour avant le son, votre test est terminé. Le test commencera au début du mot. À vos marques. Préparez-vous!… Commencez."
    //'English', 'Spanish', 'French'
  ];
  List<String> tabNames = ["Info", "Listings", "Reviews"];
  List<String> bios = [
    "My name is Navid Khan",
    "This are my listings",
    "List of reviews pulled from database go here"
  ];
  String imageUrl = 'assets/default.png';

  List<Widget> getTabs(List<String> tabNames) {
    List<Widget> tabs = new List();
    for (String name in tabNames) {
      tabs.add(Container(
          padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: Text(
            name,
            //textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )));
    }
    return tabs;
  }

  Widget reviews(uid) {
    //Future<List<>
    int commentLen = 5;
    return ListView.builder(
      itemCount: commentLen,
      itemBuilder: (context, index) {
        return ListTile(
            //title: Text('${comment[index]}'),
            );
      },
    );
  }

  List<Widget> getBios(List<String> bios) {
    List<Widget> bioTabs = new List();
    for (String bio in bios) {
      bioTabs.add(Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ))
          //Padding(padding: EdgeInsets.all(10));
          );
    }
    return bioTabs;
  }

  List<Widget> getLanguageTabs(List<String> languages) {
    List<Widget> tabs = new List();
    for (String language in languages) {
      tabs.add(Text(
        language,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ));
    }
    return tabs;
  }

  List<Widget> getLanguageBios(List<String> bios) {
    List<Widget> bioTabs = new List();
    for (String bio in bios) {
      bioTabs.add(Text(
        bio,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ));
    }
    return bioTabs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
                child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://visme.co/blog/wp-content/uploads/2017/07/50-Beautiful-and-Minimalist-Presentation-Backgrounds-04.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50, left: 135),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://external-preview.redd.it/9AWn6JJOzBSl3XLfNHCtEtfjaw3iUPriDltGV10P5A4.jpg?auto=webp&s=19b8fe70cd041d6fc3e49fbee361c9b0c46c049f"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 3,
                              offset: Offset(10, 10),
                            )
                          ]),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Nav",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Amherst, NY",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Rating:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        RatingBar.readOnly(
                            size: 30,
                            filledIcon: Icons.star,
                            initialRating: 4.5,
                            isHalfAllowed: true,
                            halfFilledIcon: Icons.star_half,
                            emptyIcon: Icons.star_border),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 50,
                  child: new AppBar(
                    title: TabBar(
                      tabs: getTabs(tabNames),
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        insets: EdgeInsets.all(0.1),
                      ),
                    ),
                    backgroundColor: Colors.lightBlue[200],
                  ),
                ),
                Expanded(child: TabBarView(children: getBios(bios)))
              ],
            )),
          ),
        ));

    // AppBar(
    //   backgroundColor: Colors.black,

    //   flexibleSpace: Column(
    //     children: <Widget>[
    //       // Image Avatar
    //       Center(
    //         heightFactor: 1.2,
    //         child: Image(
    //           image: AssetImage(imageUrl),
    //           height: 100.0,
    //           width: 100.0,
    //         ),
    //       ),

    //       // Name
    //       Center(
    //         child: Text(
    //           firstName + " " + lastName,
    //           style: TextStyle(
    //             fontSize: 32.0,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),

    // Rating
    //             Center(
    //               child: Row(
    //                 children: [
    //                   Text(
    //                     rating.toString(),
    //                     style: TextStyle(
    //                       fontSize: 26.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Text(
    //                     '/5 Stars',
    //                     style: TextStyle(
    //                       fontSize: 15.0,
    //                       fontWeight: FontWeight.normal,
    //                     ),
    //                   ),
    //                 ],
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //               ),
    //               heightFactor: 1.5,
    //             ),
    //           ],
    //         ),
    //         bottom: TabBar(
    //           tabs: getLanguageTabs(languages),
    //         ),
    //       ),
    //     ),

    //     // Bios for different languages
    //     body: TabBarView(
    //       children: getLanguageBios(languageBios),
    //     ),
    //   ),
    // ));
  }
}

class userReviews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return userReviewsState();
  }
}

class userReviewsState extends State<userReviews> {
  Future<List<String>> _getComments(uid) async {
    var data = await (http.get(
        "https://job-5cells.herokuapp.com/getRatingById/5f7267a78d607a000420675e"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
