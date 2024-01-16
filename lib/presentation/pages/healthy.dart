import 'package:flutter/material.dart';
import 'dart:async';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class HealthyPage extends StatefulWidget {
  @override
  _HealthyPageState createState() => _HealthyPageState();
}

class _HealthyPageState extends State<HealthyPage> {
  String _status = 'Not Walking';
  int _steps = 0;
  bool _isSimulating = false;

  late StreamController<StepCount> _stepCountController;

  @override
  void initState() {
    super.initState();
    _stepCountController = StreamController<StepCount>();
  }

  void _startSimulation() {
    if (!_isSimulating) {
      _isSimulating = true;
      _simulateWalking();
    }
  }

  void _stopSimulation() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _status = 'stopped';
    });
    _isSimulating = false;
  }

  void _simulateWalking() async {
    while (_isSimulating) {
      await Future.delayed(Duration(seconds: 1));
      _stepCountController.add(StepCount(_steps + 1));
      setState(() {
        _steps += 1;
        _status = 'walking';
      });
    }
  }

  @override
  void dispose() {
    _stepCountController.close();
    // _stepCountStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xFF16697A), Color(0xFF82C0CC)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                )),
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Steps Taken',
                  style: TextStyle(fontSize: 30),
                ),
                StreamBuilder<StepCount>(
                  stream: _stepCountController.stream,
                  builder: (context, snapshot) {
                    return Text(
                      _steps.toString(),
                      style: const TextStyle(fontSize: 60),
                    );
                  },
                ),
                const Divider(
                  height: 100,
                  thickness: 0,
                  color: Colors.white,
                ),
                const Text(
                  'Pedestrian Status',
                  style: TextStyle(fontSize: 30),
                ),
                Icon(
                  _status == 'walking'
                      ? Icons.directions_walk
                      : _status == 'stopped'
                          ? Icons.accessibility_new
                          : Icons.error,
                  size: 100,
                ),
                Center(
                  child: Text(
                    _status,
                    style: _status == 'walking' || _status == 'stopped'
                        ? const TextStyle(fontSize: 30)
                        : const TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ElevatedButton(
                  onPressed: _isSimulating ? _stopSimulation : _startSimulation,
                  child: Text(_isSimulating ? 'Stop Walking' : 'Start Walking'),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class StepCount {
  final int steps;

  StepCount(this.steps);
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.20);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.15,
      size.width * 1,
      size.height * 0.15,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
