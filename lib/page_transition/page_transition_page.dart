import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageTransitionPage extends StatefulWidget {
  const PageTransitionPage({Key? key}) : super(key: key);

  @override
  _PageTransitionPageState createState() => _PageTransitionPageState();
}

class _PageTransitionPageState extends State<PageTransitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Transition'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Left to Right'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Right to Left'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Left to Right (Joined)'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightJoined,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Right to Left (Joined)'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightJoined,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Bottom to Top'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Top to Bottom'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Fade'),
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.fade,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: TestPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
    );
  }
}

