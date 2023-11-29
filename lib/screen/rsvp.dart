import 'package:flutter/material.dart';
import 'dart:async';

class RSVP extends StatefulWidget {
  final List<String> words;

  RSVP(this.words);

  @override
  _RSVPState createState() => _RSVPState();
}

class _RSVPState extends State<RSVP> {
  String pausePlay = "Play";
  int currentWordIndex = 0;
  bool play = false;
  String displayedWord = " ";
  int miliseconds = 200;
  String wpm = "300";
  StreamSubscription<int>? wordDisplayStream;


  void togglePausePlay() {
    setState(() {
      play = (play) ? false : true;
      pausePlay = (pausePlay == "Play") ? "Pause" : "Play";
    });
    if(play) {
      displayNextWord(Duration(milliseconds: miliseconds));
    }
  }



  void displayNextWord(Duration displayInterval) {
    wordDisplayStream?.cancel(); // Cancel the previous stream, if it's running.

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
        // makeshift fix here
        if (currentWordIndex <= widget.words.length) {
          displayedWord = widget.words[currentWordIndex - 1];
        }
        // } else {
        //   displayedWord = "End of Words";
        //   // displayedWord = widget.words[widget.words.length]
        // }
      });
    });
  }

  void reset() {
    setState(() {
      currentWordIndex = 0;
      displayedWord = widget.words[currentWordIndex];
    });
  }

  void increment() {
    setState(() {
      int currSpeed = int.parse(wpm);
      currSpeed += 25;
      wpm = currSpeed.toString();
      miliseconds = 1000~/(currSpeed / 60);
    });
    displayNextWord(Duration(milliseconds: miliseconds));
  }

  void decrement() {
    setState(() {
      int currSpeed = int.parse(wpm);
      currSpeed -= 25;
      wpm = currSpeed.toString();
      miliseconds = 1000~/(currSpeed / 60);
    });
    displayNextWord(Duration(milliseconds: miliseconds));
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  togglePausePlay();
                  decrement();
                  togglePausePlay();
                },
                child: const Text("--"),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                wpm,
                style: const TextStyle(
                  fontSize: 24.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  togglePausePlay();
                  increment();
                  togglePausePlay();
                },
                child: const Text("++"),
              ),
            ),
          ),
          // Big word in the middle of the screen
          Center(
            child: Text(
              displayedWord,
              style: const TextStyle(
                fontSize: 50.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ),

          // Bottom row with buttons on the left, middle, and right
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  reset();
                },
                child: Text('Reset'),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  togglePausePlay();
                },
                child: Text(pausePlay),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text("Right"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
