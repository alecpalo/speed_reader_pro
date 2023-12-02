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
            // alignment: Alignment(1.1, 1)
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text("Right"),
              ),
            ),
          ),
          // Adding start position chooser functionality
          Align(
            alignment: Alignment(0, 1.1),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  // open into screen showing input text
                  String widget_words = widget.words.join(',');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewScreen(widget_words),
                    ),
                  );
                },
                child: Text("Choose Position"),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

// NewScreen for Selecting position in text
class NewScreen extends StatelessWidget {
  final String words_thing;

  // constructor to get text from first screen
  NewScreen(this.words_thing);

  @override
  Widget build(BuildContext context) {
    List<String> items = words_thing.split(","); // change into list
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select new position'),
      ),
      body: ListView.builder( // now need to make these all buttons
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            // Add any additional widgets or functionality here
          );
        },
      ),
    );
  }
}


// now change all the elements in this lis


// body: Center(
// child: Text(textFromFirstScreen), // will replace this with text from first screen
// ),
