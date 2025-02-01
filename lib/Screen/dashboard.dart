import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Widget/new_anime_widget.dart';
import 'package:animestation_project_uas/Widget/upcoming_widget.dart';

class Dashboard extends StatelessWidget {
  
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
           children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello Your Name",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                       Text(
                        "What to Watch?",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 105, 105, 105),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/images/koboo.jpg",
                    height: 70,
                    width: 70,
                    ),
                  ),
                ],
              ),

            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
               child: Row(children: [
              Icon(Icons.search,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: 30,
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(left: 5),
                child: TextFormField(
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black54),
                ),
                )
              ),
              ],
             ),
            ),
            SizedBox(height: 30),
            UpcomingWidget(),
            SizedBox(height: 40),
            NewAnimeWidget(),
           ],
        )
        ),
      ),
    );
  }
}