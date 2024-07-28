// homepage.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_app/language_provider.dart';
import 'package:my_app/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              DropdownButton<String>(
                value: context.watch<LanguageProvider>().language,
                items: <String>['English', 'Sinhala', 'Tamil']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    context.read<LanguageProvider>().setLanguage(newValue);
                  }
                },
              ),
              const SizedBox(width: 10.0),
              IconButton(
                onPressed: () {
                  // onPressed for IconButton
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/children.png'),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: darkGrayClr,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: darkGrayClr,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(
                    imagePath: 'assets/Feelings.png',
                    buttonText: getLocalizedText(context, 'Feelings'),
                    onPressed: () {
                      _showFeelingsBottomSheet(context, 'Feelings');
                    },
                  ),
                  ImageButton(
                    imagePath: 'assets/family.png',
                    buttonText: getLocalizedText(context, 'Relationships'),
                    onPressed: () {
                      _showRelationsBottomSheet(context, 'Relationships');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(
                    imagePath: 'assets/yes.png',
                    buttonText: getLocalizedText(context, 'Good'),
                    onPressed: () {
                      // onPressed for Good
                    },
                  ),
                  ImageButton(
                    imagePath: 'assets/no.png',
                    buttonText: getLocalizedText(context, 'Bad'),
                    onPressed: () {
                      // onPressed for Bad
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(
                    imagePath: 'assets/need.png',
                    buttonText: getLocalizedText(context, 'Want'),
                    onPressed: () {
                      // onPressed for Want
                    },
                  ),
                  ImageButton(
                    imagePath: 'assets/dont.png',
                    buttonText: getLocalizedText(context, 'DontWant'),
                    onPressed: () {
                      // onPressed for Don't Want
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const ImageButton({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onPressed();
        FlutterTts flutterTts = FlutterTts();
        String language = context.read<LanguageProvider>().language;
        // Adjust language settings for FlutterTts
        switch (language) {
          case 'Sinhala':
            await flutterTts.setLanguage('si-LK');
            break;
          case 'Tamil':
            await flutterTts.setLanguage('ta-IN');
            break;
          default:
            await flutterTts.setLanguage('en-US');
        }
        await flutterTts.speak(buttonText);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 120,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: primaryClr),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(imagePath,
                      width: 80, height: 80, fit: BoxFit.cover),
                ),
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: darkGrayClr,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showFeelingsBottomSheet(BuildContext context, String title) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageButton(
                              imagePath: 'assets/hungry.png',
                              buttonText: getLocalizedText(context, 'Hungry'),
                              onPressed: () {
                                // onPressed for Hungry
                              },
                            ),
                            ImageButton(
                              imagePath: 'assets/thirsty.png',
                              buttonText: getLocalizedText(context, 'Thirsty'),
                              onPressed: () {
                                // onPressed for Thirsty
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageButton(
                              imagePath: 'assets/tired.png',
                              buttonText: getLocalizedText(context, 'Tired'),
                              onPressed: () {
                                // onPressed for Tired
                              },
                            ),
                            ImageButton(
                              imagePath: 'assets/sleep.jpg',
                              buttonText: getLocalizedText(context, 'Sleepy'),
                              onPressed: () {
                                // onPressed for Sleepy
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageButton(
                              imagePath: 'assets/happy.png',
                              buttonText: getLocalizedText(context, 'Happy'),
                              onPressed: () {
                                // onPressed for Happy
                              },
                            ),
                            ImageButton(
                              imagePath: 'assets/sad.png',
                              buttonText: getLocalizedText(context, 'Sad'),
                              onPressed: () {
                                // onPressed for Sad
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageButton(
                              imagePath: 'assets/angry.png',
                              buttonText: getLocalizedText(context, 'Angry'),
                              onPressed: () {
                                // onPressed for Angry
                              },
                            ),
                            ImageButton(
                              imagePath: 'assets/scare.png',
                              buttonText: getLocalizedText(context, 'Scared'),
                              onPressed: () {
                                // onPressed for Scared
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void _showRelationsBottomSheet(BuildContext context, String title) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imagePath: 'assets/mother.png',
                                buttonText: getLocalizedText(context, 'Mother'),
                                onPressed: () {
                                  // onPressed for Mother my_app\assets\father2.jpg
                                },
                              ),
                              ImageButton(
                                imagePath: 'assets/farther.png',
                                buttonText: getLocalizedText(context, 'Father'),
                                onPressed: () {
                                  // onPressed for Father
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imagePath: 'assets/brother.png',
                                buttonText:
                                    getLocalizedText(context, 'Elder Brother'),
                                onPressed: () {
                                  // onPressed for Brother
                                },
                              ),
                              ImageButton(
                                imagePath: 'assets/elder_sister.png',
                                buttonText:
                                    getLocalizedText(context, 'Elder Sister'),
                                onPressed: () {
                                  // onPressed for Sister
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imagePath: 'assets/uncle.png',
                                buttonText: getLocalizedText(
                                    context, 'Younger Brother'),
                                onPressed: () {
                                  // onPressed for Brother
                                },
                              ),
                              ImageButton(
                                imagePath: 'assets/younger_sister.png',
                                buttonText:
                                    getLocalizedText(context, 'Younger Sister'),
                                onPressed: () {
                                  // onPressed for Sister
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imagePath: 'assets/friend.png',
                                buttonText: getLocalizedText(context, 'Friend'),
                                onPressed: () {
                                  // onPressed for Friend
                                },
                              ),
                              ImageButton(
                                imagePath: 'assets/teacher.png',
                                buttonText:
                                    getLocalizedText(context, 'Teacher'),
                                onPressed: () {
                                  // onPressed for Teacher
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Map<String, Map<String, String>> localizedTexts = {
  'English': {
    'Feelings': 'Feelings',
    'Relationships': 'Relationships',
    'Good': 'Good',
    'Bad': 'Bad',
    'Want': 'Want',
    'DontWant': 'Don\'t Want',
    'Hungry': 'Hungry',
    'Thirsty': 'Thirsty',
    'Tired': 'Tired',
    'Sleepy': 'Sleepy',
    'Happy': 'Happy',
    'Sad': 'Sad',
    'Fear': 'Fear',
    'Angry': 'Angry',
    'Surprised': 'Surprised',
    'Disgusted': 'Disgusted',
    'Mother': 'Mother',
    'Father': 'Father',
    'Elder Sister': 'Elder Sister',
    'Younger Sister': 'Younger Sister',
    'Elder Brother': 'Elder Brother',
    'Younger Brother': 'Younger Brother',
    'Grandmother': 'Grandmother',
    'Grandfather': 'Grandfather',
    'Uncle': 'Uncle',
    'Aunt': 'Aunt',
    'Friend': 'Friend',
    'Teacher': 'Teacher',
  },
  'Sinhala': {
    'Feelings': 'හැඟීම්',
    'Relationships': 'සම්බන්ධතා',
    'Good': 'හොඳයි',
    'Bad': 'නරකයි',
    'Want': 'අවශ්යයි',
    'DontWant': 'නොඅවශ්යයි',
    'Hungry': 'බඩගිනියි',
    'Thirsty': 'තිබහයි',
    'Tired': 'මහන්සියි',
    'Sleepy': 'නිදිමතයි',
    'Happy': 'සතුටුයි',
    'Sad': 'දුකයි',
    'Scared': 'බියයි',
    'Angry': 'කේන්තියි',
    'Surprised': 'පුදුමයි',
    'Disgusted': 'අමාරුයි',
    'Mother': 'මව',
    'Father': 'පියා',
    'Elder Sister': 'ලොකු අක්කා',
    'Younger Sister': 'පොඩි අක්කා',
    'Elder Brother': 'ලොකු අයියා',
    'Younger Brother': 'පොඩි අයියා',
    'Grandmother': 'ආච්චි',
    'Grandfather': 'සීයා',
    'Uncle': 'මාමා',
    'Aunt': 'නැන්දා',
    'Friend': 'මිතුරා',
    'Teacher': 'ගුරුතුමා',
  },
  'Tamil': {
    'Feelings': 'உணர்வுகள்',
    'Relationships': 'உறவுகள்',
    'Good': 'நன்று',
    'Bad': 'கெட்டது',
    'Want': 'வேண்டும்',
    'DontWant': 'வேண்டாம்',
    'Hungry': 'பசிக்கின்றது',
    'Thirsty': 'தாகம்',
    'Tired': 'களைப்பு',
    'Sleepy': 'தூக்கம்',
    'Happy': 'மகிழ்ச்சி',
    'Sad': 'கவலை',
    'Fear': 'பயம்',
    'Angry': 'கோபம்',
    'Surprised': 'ஆச்சரியம்',
    'Disgusted': 'வெறுப்பு',
    'Mother': 'அம்மா',
    'Father': 'அப்பா',
    'Elder Sister': 'அண்ணி',
    'Younger Sister': 'தங்கை',
    'Elder Brother': 'அண்ணன்',
    'Younger Brother': 'தம்பி',
    'Grandmother': 'பாட்டி',
    'Grandfather': 'தாத்தா',
    'Uncle': 'மாமா',
    'Aunt': 'அத்தை',
    'Friend': 'நண்பர்',
    'Teacher': 'ஆசிரியர்',
  },
};

String getLocalizedText(BuildContext context, String key) {
  String language = context.watch<LanguageProvider>().language;
  return localizedTexts[language]?[key] ?? key;
}
