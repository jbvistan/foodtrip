import 'package:flutter/material.dart';

import 'personalized_home_page.dart';
import 'results_page.dart';
import 'surprise_me_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 122, 34),
        ),
        useMaterial3: true,
      ),

      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Text(
                  'FoodTRIP',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Valenzuela City',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            elevation: 0,
          ),

          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          // "Personalized mode" button
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PersonalizedHomePage(),
                            ),
                          ),
                          child: Text('Personalized mode'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            foregroundColor: const Color.fromARGB(
                              221,
                              124,
                              124,
                              124,
                            ),
                            side: BorderSide(
                              color: const Color.fromARGB(221, 124, 124, 124),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10), // basically the row gap, fixed

                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Discovery mode'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 1,
                            ),
                            foregroundColor: const Color.fromARGB(
                              255,
                              255,
                              122,
                              34,
                            ),
                            side: BorderSide(
                              color: const Color.fromARGB(255, 255, 122, 34),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ), // Expanded means they share equal width
                    ],
                  ),

                  // Big question for the user
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'What is/are your craving today?',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                  ),

                  // Search bar
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 133, 133, 133),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: const Color.fromARGB(255, 133, 133, 133),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            cursorColor: const Color.fromARGB(
                              255,
                              133,
                              133,
                              133,
                            ),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 133, 133, 133),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Type a specific food (optional)',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 133, 133, 133),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // most choseeeeen
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'Most chosen',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 158, 158, 158),
                      ),
                    ),
                  ),

                  Container(
                    child: Container(
                      child: GridView.count(
                        crossAxisCount: 3, // 3 equal columns
                        crossAxisSpacing: 10,
                        childAspectRatio: 2, // width to height ratio
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Rice meals'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Burgers'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Desserts'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Soup'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Coffee'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Noodles'),
                            style: OutlinedButton.styleFrom(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                122,
                                34,
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 255, 122, 34),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResultsPage(),
                            ),
                          ),
                          child: Text("Find food"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              122,
                              34,
                            ),
                            foregroundColor: Colors.white,
                            elevation: 0, // remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        SizedBox(height: 10), // gap between buttons

                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SurpriseMePage(),
                            ),
                          ),
                          child: Text("I can't decide"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            backgroundColor: Colors.white,
                            foregroundColor: const Color.fromARGB(
                              255,
                              133,
                              133,
                              133,
                            ),
                            side: BorderSide(
                              color: const Color.fromARGB(255, 133, 133, 133),
                              width: 1,
                            ),
                            elevation: 0, // remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
