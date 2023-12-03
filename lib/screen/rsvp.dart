import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class RSVP extends StatefulWidget {
  final List<String> words;

  RSVP(this.words);

  @override
  _RSVPState createState() => _RSVPState(); // reads directly from input text
}

class _RSVPState extends State<RSVP> {
  String pausePlay = "Play";
  int currentWordIndex = 0;
  bool play = false;
  String displayedWord = "";
  int miliseconds = 200;
  String wpm = "300";
  StreamSubscription<int>? wordDisplayStream;

  void togglePausePlay() {
    setState(() {
      play = !play;
    });
    if (play) {
      displayNextWord(Duration(milliseconds: miliseconds));
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      displayedWord = widget.words[0];
    });
  }

  void displayNextWord(Duration displayInterval) {
    wordDisplayStream?.cancel(); // Cancel the previous stream if it's running.

    wordDisplayStream = Stream.periodic(displayInterval, (_) {
      if (currentWordIndex < widget.words.length) {
        currentWordIndex++; // Move to the next word index if within bounds.
      } else {
        // Stop the stream when all words are displayed.
        play = false;
        wordDisplayStream?.cancel(); // Cancel the stream when it's done.
      }
      return currentWordIndex;
    })
        .takeWhile((_) => play)
        .listen((newNumber) {
      setState(() {
        // Makeshift fix here
        if (currentWordIndex <= widget.words.length) {
          displayedWord = widget.words[currentWordIndex - 1];
        }
      });
    });
  }

  void Backward() {
    setState(() {
      if(currentWordIndex - 15 > 0) {
        currentWordIndex -= 15;
      } else {
        currentWordIndex = 0;
      }
      displayedWord = widget.words[currentWordIndex];
    });
  }

  void Forward() {
    setState(() {
      if(currentWordIndex + 15 < widget.words.length) {
        currentWordIndex += 15;
      } else {
        currentWordIndex = widget.words.length - 1;
      }
      displayedWord = widget.words[currentWordIndex];
    });
  }

  void increment() {
    setState(() {
      int currSpeed = int.parse(wpm);
      currSpeed += 25;
      wpm = currSpeed.toString();
      miliseconds = (1000 ~/ (currSpeed / 60)).toInt();
    });
    displayNextWord(Duration(milliseconds: miliseconds));
  }

  void decrement() {
    setState(() {
      int currSpeed = int.parse(wpm);
      currSpeed -= 25;
      wpm = currSpeed.toString();
      miliseconds = (1000 ~/ (currSpeed / 60)).toInt();
    });
    displayNextWord(Duration(milliseconds: miliseconds));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Material(
                color: Colors.grey[800],
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    togglePausePlay();
                    decrement();
                    togglePausePlay();
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Icon(Icons.remove, color: Colors.white, size: 36.0),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        wpm,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "WPM",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Material(
                color: Colors.grey[800],
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    togglePausePlay();
                    increment();
                    togglePausePlay();
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, color: Colors.white, size: 36.0), // Adjusted size
                  ),
                ),
              ),
            ),
          ),


          // Big word in the middle of the screen
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                displayedWord,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            )
          ),
          // Bottom row with buttons on the left, middle, and right
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 140.0),
              child: Material(
                color: Colors.grey[800],
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Backward();
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.fast_rewind,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 140.0),
              child: CircleAvatar(
                radius: 30.0, // Adjust the radius as needed
                backgroundColor: Colors.grey[800],
                child: InkWell(
                  onTap: () {
                    togglePausePlay();
                  },
                  child: Icon(
                    play ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 140.0),
              child: Material(
                color: Colors.grey[800],
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Forward();
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Adding start position chooser functionality
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 30.0),
              child: SizedBox(
                width: double.infinity, // Set the width to occupy the full available width
                height: 60.0, // Set the height to your desired value
                child: ElevatedButton(
                  onPressed: () {
                    if(play) {
                      togglePausePlay();
                    }
                    _showClickableWordsScreen(context);
                  },
                  child: Text(
                    "Change Position",
                    style: TextStyle(fontSize: 24.0), // Set the desired font size
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClickableWordsScreen(BuildContext context) {
    List<String> words = widget.words;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: _buildTextSpans(words),
              ),
            ),
          ),
        );
      },
    );
  }

  List<TextSpan> _buildTextSpans(List<String> words) {
    List<TextSpan> textSpans = [];

    for (int i = 0; i < words.length; i++) {
      String word = words[i];

      textSpans.add(
        TextSpan(
          text: '$word ',
          style: TextStyle(
            color: i == currentWordIndex ? Colors.blue : Colors.black,
            fontSize: 20,
            fontWeight: i == currentWordIndex ? FontWeight.bold : FontWeight.normal,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _handleSelection(i);
              Navigator.of(context).pop(); // Close the bottom sheet
            },
        ),
      );
    }

    return textSpans;
  }

  void _handleSelection(int index) {
    // Set your state here based on the index of the pressed button
    setState(() {
      currentWordIndex = index;
      displayedWord = widget.words[currentWordIndex];
    });
    // You can set the state or perform any other actions as needed
  }

}

class MyRadioList extends StatefulWidget {
  final String wordsThing;

  MyRadioList(this.wordsThing);

  @override
  _MyRadioListState createState() => _MyRadioListState();
}

class _MyRadioListState extends State<MyRadioList> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<String> items = widget.wordsThing.split(",");
    return Scaffold(
      appBar: AppBar(
        title: Text('Select new position'),
        backgroundColor: Colors.grey[800],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RSVP(items.sublist(selectedIndex)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedIndex == index
                  ? Colors.red
                  : Colors.grey[800],
            ),
            child: Text(
              items[index],
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
