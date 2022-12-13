import 'package:flutter/material.dart';

import 'package:yobo_project/local_widgets/snake_path.dart';

class HomeScreen extends StatefulWidget {
  final int numberOfCircles;
  final int completedCircles;

  const HomeScreen(
      {required this.numberOfCircles, required this.completedCircles, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int level = 0;
    bool previousLevelWasOdd = false;
    final width = MediaQuery.of(context).size.width;
    double endGateDistance = 50;
    return Scaffold(
      backgroundColor: const Color(0xFF181723),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              decoration: const BoxDecoration(
                color: Color(0XFFf9e4c8),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height + 1000,
                    width: double.infinity,
                    child: SnakePath(widget.numberOfCircles)),
                ...List.generate(
                  widget.numberOfCircles,
                  (index) {
                    if (index == widget.numberOfCircles - 1) {
                      endGateDistance = 50 + (level + 1) * 150;
                    }
                    if (level == 0) {
                      level++;
                      return Positioned(
                        top: 50,
                        child: _buildChildNode(index < widget.completedCircles),
                      );
                    } else if (level.isOdd && !previousLevelWasOdd) {
                      previousLevelWasOdd = true;
                      return Positioned(
                        child: _buildChildNode(index < widget.completedCircles),
                        top: 50 + level * 150,
                        left: -(width * 0.25 + 50),
                        right: 0,
                      );
                    } else if (level.isOdd) {
                      return Positioned(
                        child: _buildChildNode(index < widget.completedCircles),
                        top: 50 + level++ * 150,
                        left: width * 0.25 + 50,
                        right: 0,
                      );
                    } else {
                      previousLevelWasOdd = false;
                      return Positioned(
                        child: _buildChildNode(index < widget.completedCircles),
                        top: 50 + level++ * 150,
                      );
                    }
                  },
                ),
                Positioned(top: endGateDistance, child: _buildFinishing()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChildNode(bool isCompleted) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color:
              isCompleted ? const Color(0xFFd5fff9) : const Color(0xFF353c45),
          shape: BoxShape.circle),
    );
  }

  Widget _buildFinishing() {
    return Container(
      height: 100,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 4),
        color: Colors.brown,
      ),
      child: const Center(
        child: Text(
          'END',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
