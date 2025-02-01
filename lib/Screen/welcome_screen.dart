import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Scaffold/custom_scaffold.dart';
import 'package:animestation_project_uas/Screen/dashboard.dart';
import 'package:animestation_project_uas/Auth/login.dart';
import 'package:animestation_project_uas/nav_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 48.0,
            ),
            child: 
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children:[
                  const TextSpan(
                  text: 'Welcome To Kronimez\n',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255,255,255,255),
                  ),
                ),
               WidgetSpan(
                  alignment: PlaceholderAlignment.middle, // Menempatkan widget di tengah teks
                  child: SizedBox(
                    height: 50, 
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const TextSpan(
                  text: '\nWatch Anime Everywhere',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(183, 255, 255, 255)
                  ),
                 ),
                ],
               ),
              ),
          ),
         

          
          
        ],
      ),
    );
  }
}